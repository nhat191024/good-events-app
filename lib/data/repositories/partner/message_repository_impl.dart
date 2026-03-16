import 'package:sukientotapp/data/providers/common/message_provider.dart';
import 'package:sukientotapp/domain/repositories/partner/message_repository.dart';

class MessageRepositoryImpl implements MessageRepository {
  final MessageProvider _provider;
  final String _endpoint;

  MessageRepositoryImpl(this._provider, {required String endpoint})
      : _endpoint = endpoint;

  @override
  Future<Map<String, dynamic>> getThreads({
    required int page,
    String? search,
  }) async {
    return _provider.getThreads(
      endpoint: _endpoint,
      page: page,
      search: search,
    );
  }
}
