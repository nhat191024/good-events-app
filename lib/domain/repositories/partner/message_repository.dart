abstract class MessageRepository {
  Future<Map<String, dynamic>> getThreads({required int page, String? search});

  Future<Map<String, dynamic>> getMessages({
    required String threadId,
    required int page,
  });
}
