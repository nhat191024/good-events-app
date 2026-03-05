import 'package:sukientotapp/core/utils/import/global.dart';

import 'package:sukientotapp/domain/repositories/partner/message_repository.dart';
import 'package:sukientotapp/data/models/message_model.dart';
import 'package:sukientotapp/data/models/message_list_model.dart';

class MessageController extends GetxController {
  final MessageRepository _repository;
  MessageController(this._repository);

  final List<MessageListModel> messages = <MessageListModel>[
    MessageListModel(
      id: '1',
      avatar: 'assets/images/placeholder.png',
      name: 'Dr. John Doe',
      newestMessage:
          'Hello, how are you? Hello, how are you? Hello, how are you? Hello, how are you?',
      time: '10m',
      isRead: false,
      unreadMessages: 2,
    ),
    MessageListModel(
      id: '2',
      avatar: 'assets/images/placeholder.png',
      name: 'Jane',
      newestMessage: 'Hello, how are you?',
      time: '2m',
      isRead: false,
      unreadMessages: 1,
    ),
    MessageListModel(
      id: '3',
      avatar: 'assets/images/placeholder.png',
      name: 'Dr. James',
      newestMessage: 'Hello, how are you?',
      time: '13m',
      isRead: true,
      unreadMessages: 0,
    ),
    MessageListModel(
      id: '4',
      avatar: 'assets/images/placeholder.png',
      name: 'Isabella',
      newestMessage: 'Hello, how are you?',
      time: '20m',
      isRead: true,
      unreadMessages: 0,
    ),
  ];

  final RxList<MessageModel> messagesDetail = <MessageModel>[
    MessageModel(
      text: 'Thank you for booking an appointment with me.',
      isSender: true,
      sended: true,
      time: '10:00',
      date: '2024-10-31',
    ),
    MessageModel(
      text: 'And if you have any questions or inquires do let me know.',
      isSender: true,
      sended: true,
      time: '10:01',
      date: '2024-10-31',
    ),
    MessageModel(
      text: 'Hi, Doctor',
      isSender: false,
      sended: true,
      time: '10:02',
      date: '2024-11-01',
    ),
  ].obs;

  late String id;
  late int totalMessage;

  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  // Uncomment when file_picker is added
  // var selectedFiles = <PlatformFile>[].obs;
  var selectedFiles = <dynamic>[].obs; // Placeholder

  Future<void> pickFiles() async {
    Get.snackbar('Notice', 'File picking disabled in demo (missing plugin)');
  }

  void removeSelectedFile(dynamic file) {
    selectedFiles.remove(file);
  }

  final RxList<MessageListModel> filteredMessages = <MessageListModel>[].obs;
  final RxString searchQuery = ''.obs;

  @override
  void onInit() {
    totalMessage = messages.length;
    filteredMessages.assignAll(messages);
    super.onInit();
  }

  void searchMessages(String query) {
    searchQuery.value = query;
    if (query.isEmpty) {
      filteredMessages.assignAll(messages);
    } else {
      filteredMessages.assignAll(
        messages
            .where((message) => message.name.toLowerCase().contains(query.toLowerCase()))
            .toList(),
      );
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

  void sendMessage() async {
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
}
