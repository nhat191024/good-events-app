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
  late String id;

  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final ScrollController listScrollController = ScrollController();

  var selectedFiles = <dynamic>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchThreads();
    listScrollController.addListener(_onListScroll);
    // Debounce search so we don't hammer the API on every keystroke
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
    // Actual fetch is triggered via debounce in onInit
  }

  void _resetAndFetch() {
    _currentPage = 1;
    hasMore.value = true;
    fetchThreads();
  }

  void _onListScroll() {
    final pos = listScrollController.position;
    // Load more when within 200px of the bottom
    if (pos.pixels >= pos.maxScrollExtent - 200) {
      loadMore();
    }
  }

  // ──────────────────────────────────────────────
  // Message detail (chat window)
  // ──────────────────────────────────────────────

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

  void sendMessage() {
    if (messageController.text.isNotEmpty) {
      messagesDetail.add(
        MessageModel(
          text: messageController.text,
          isSender: true,
          sended: true,
          time: DateFormat("HH:mm").format(DateTime.now()),
          date: DateFormat("yyyy-MM-dd").format(DateTime.now()),
        ),
      );
      messageController.clear();
      scrollToBottom();
    }
  }

  Future<void> pickFiles() async {
    AppSnackbar.showError(
      message: 'File picking disabled in demo (missing plugin)',
    );
  }

  void removeSelectedFile(dynamic file) {
    selectedFiles.remove(file);
  }
}
