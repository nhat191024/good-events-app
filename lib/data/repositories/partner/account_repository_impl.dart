import 'package:sukientotapp/data/models/partner/wallet_transaction_model.dart';
import 'package:sukientotapp/data/providers/partner/account_provider.dart';
import 'package:sukientotapp/domain/repositories/partner/account_repository.dart';

class AccountRepositoryImpl implements AccountRepository {
  final AccountProvider _provider;

  AccountRepositoryImpl(this._provider);

  @override
  Future<List<WalletTransactionModel>> getWalletTransactions() async {
    final response = await _provider.getWalletTransactions();
    return response.map((e) => WalletTransactionModel.fromMap(e)).toList();
  }

  @override
  Future<String> regenerateAddFundsLink(int amount) async {
    return _provider.regenerateAddFundsLink(amount);
  }

  @override
  Future<Map<String, dynamic>> confirmAddFunds({
    required String orderCode,
    required String status,
  }) async {
    return _provider.confirmAddFunds(orderCode: orderCode, status: status);
  }

  @override
  Future<void> logout() async {
    await _provider.logout();
  }

  @override
  Future<void> deleteAccount(String password) async {
    await _provider.deleteAccount(password);
  }
}
