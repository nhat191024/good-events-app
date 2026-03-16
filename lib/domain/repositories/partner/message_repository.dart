abstract class MessageRepository {
  Future<Map<String, dynamic>> getThreads({required int page, String? search});
}
