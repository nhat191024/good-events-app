import 'package:sukientotapp/core/utils/import/global.dart';

import 'package:sukientotapp/domain/repositories/partner/message_repository.dart';
import 'package:sukientotapp/data/models/message_model.dart';
import 'package:sukientotapp/data/models/message_list_model.dart';

class MessageController extends GetxController {
  final MessageRepository _repository;
  MessageController(this._repository);

  // --- Thread list state ---
  final RxList<MessageListModel> filteredMessages = <MessageListModel>[].obs;
  final RxBool isLoading = false.obs;
  final RxBool isLoadingMore = false.obs;
  final RxBool hasMore = true.obs;
  final RxString searchQuery = ''.obs;
  int _currentPage = 1;

  // --- Message detail state ---
  final RxList<MessageModel> messagesDetail = <MessageModel>[].obs;
  final Rx<MessageListModel?> selectedThread = Rx<MessageListModel?>(null);
  final RxBool isLoadingMessages = false.obs;
  final RxBool isLoadingOlderMessages = false.obs;
  int _messagesPage = 1;
  bool _messagesHasMore = true;

  String get selectedThreadId => selectedThread.value?.id ?? '';

  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final ScrollController listScrollController = ScrollController();

  var selectedFiles = <dynamic>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchThreads();
    listScrollController.addListener(_onListScroll);
    scrollController.addListener(_onDetailScroll);
    debounce(
      searchQuery,
      (_) => _resetAndFetch(),
      time: const Duration(milliseconds: 500),
    );
  }

  @override
  void onClose() {
    messageController.dispose();
    scrollController.dispose();
    listScrollController.dispose();
    super.onClose();
  }

  // ──────────────────────────────────────────────
  // Thread list
  // ──────────────────────────────────────────────

  Future<void> fetchThreads({bool loadMore = false}) async {
    if (loadMore) {
      if (!hasMore.value || isLoadingMore.value) return;
      isLoadingMore.value = true;
    } else {
      isLoading.value = true;
    }

    try {
      final response = await _repository.getThreads(
        page: _currentPage,
        search: searchQuery.value.isEmpty ? null : searchQuery.value,
      );

      final threads = (response['threads'] as List<dynamic>? ?? [])
          .map((e) => MessageListModel.fromJson(e as Map<String, dynamic>))
          .toList();

      hasMore.value = response['has_more'] as bool? ?? false;
      _currentPage = (response['current_page'] as int? ?? _currentPage);

      if (loadMore) {
        filteredMessages.addAll(threads);
      } else {
        filteredMessages.assignAll(threads);
      }

      logger.i(
        '[MessageController] [fetchThreads] page=$_currentPage, hasMore=${hasMore.value}, count=${threads.length}',
      );
    } catch (e) {
      logger.e('[MessageController] [fetchThreads] Error: $e');
      AppSnackbar.showError(
        message: e.toString().replaceFirst('Exception: ', ''),
      );
    } finally {
      isLoading.value = false;
      isLoadingMore.value = false;
    }
  }

  Future<void> loadMore() async {
    if (!hasMore.value || isLoadingMore.value) return;
    _currentPage++;
    await fetchThreads(loadMore: true);
  }

  Future<void> refreshThreads() async {
    _currentPage = 1;
    hasMore.value = true;
    await fetchThreads();
  }

  void searchMessages(String query) {
    searchQuery.value = query;
  }

  void _resetAndFetch() {
    _currentPage = 1;
    hasMore.value = true;
    fetchThreads();
  }

  void _onListScroll() {
    final pos = listScrollController.position;
    if (pos.pixels >= pos.maxScrollExtent - 200) {
      loadMore();
    }
  }

  // ──────────────────────────────────────────────
  // Message detail (API)
  // ──────────────────────────────────────────────

  /// Opens a thread and loads the first page of messages from the API.
  Future<void> openThread(MessageListModel thread) async {
    selectedThread.value = thread;
    _messagesPage = 1;
    _messagesHasMore = true;
    messagesDetail.clear();
    await loadMessages();
  }

  Future<void> loadMessages() async {
    if (isLoadingMessages.value) return;
    final threadId = selectedThreadId;
    if (threadId.isEmpty) return;

    isLoadingMessages.value = true;
    try {
      final currentUserId =
          StorageService.readMapData(key: LocalStorageKeys.user, mapKey: 'id')
              as int?;
      final response = await _repository.getMessages(
        threadId: threadId,
        page: _messagesPage,
      );
      final raw = response['messages'] as List<dynamic>? ?? [];
      final messages = raw
          .map(
            (e) => MessageModel.fromApiJson(
              e as Map<String, dynamic>,
              currentUserId: currentUserId,
            ),
          )
          .toList();

      _messagesHasMore = response['hasMore'] as bool? ?? false;
      messagesDetail.assignAll(messages);
      scrollToBottom();

      logger.i(
        '[MessageController] [loadMessages] threadId=$threadId, count=${messages.length}, hasMore=$_messagesHasMore',
      );
    } catch (e) {
      logger.e('[MessageController] [loadMessages] Error: $e');
      AppSnackbar.showError(
        message: e.toString().replaceFirst('Exception: ', ''),
      );
    } finally {
      isLoadingMessages.value = false;
    }
  }

  Future<void> loadOlderMessages() async {
    if (!_messagesHasMore || isLoadingOlderMessages.value) return;
    final threadId = selectedThreadId;
    if (threadId.isEmpty) return;

    isLoadingOlderMessages.value = true;
    try {
      final currentUserId =
          StorageService.readMapData(key: LocalStorageKeys.user, mapKey: 'id')
              as int?;
      _messagesPage++;
      final response = await _repository.getMessages(
        threadId: threadId,
        page: _messagesPage,
      );
      final raw = response['messages'] as List<dynamic>? ?? [];
      final older = raw
          .map(
            (e) => MessageModel.fromApiJson(
              e as Map<String, dynamic>,
              currentUserId: currentUserId,
            ),
          )
          .toList();

      _messagesHasMore = response['hasMore'] as bool? ?? false;
      messagesDetail.insertAll(0, older);

      logger.i(
        '[MessageController] [loadOlderMessages] page=$_messagesPage, count=${older.length}, hasMore=$_messagesHasMore',
      );
    } catch (e) {
      logger.e('[MessageController] [loadOlderMessages] Error: $e');
      _messagesPage--; // revert on failure
      AppSnackbar.showError(
        message: e.toString().replaceFirst('Exception: ', ''),
      );
    } finally {
      isLoadingOlderMessages.value = false;
    }
  }

  void _onDetailScroll() {
    if (!scrollController.hasClients) return;
    final pos = scrollController.position;
    if (pos.pixels <= 200) {
      loadOlderMessages();
    }
  }

  void scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> sendMessage() async {
    final text = messageController.text.trim();
    if (text.isEmpty) return;
    final threadId = selectedThreadId;
    if (threadId.isEmpty) return;

    final optimistic = MessageModel(
      text: text,
      isSender: true,
      sended: false,
      time: DateFormat("HH:mm").format(DateTime.now()),
      date: DateFormat("yyyy-MM-dd").format(DateTime.now()),
    );
    messagesDetail.add(optimistic);
    messageController.clear();
    scrollToBottom();

    try {
      await _repository.sendMessage(threadId: threadId, body: text);
      final idx = messagesDetail.indexOf(optimistic);
      if (idx != -1) {
        messagesDetail[idx] = MessageModel(
          text: optimistic.text,
          isSender: optimistic.isSender,
          sended: true,
          time: optimistic.time,
          date: optimistic.date,
        );
      }
      logger.i('[MessageController] [sendMessage] Sent to thread=$threadId');
    } catch (e) {
      logger.e('[MessageController] [sendMessage] Error: $e');
      messagesDetail.remove(optimistic);
      messageController.text = text; // restore text on failure
      AppSnackbar.showError(
        message: e.toString().replaceFirst('Exception: ', ''),
      );
    }
  }
}
