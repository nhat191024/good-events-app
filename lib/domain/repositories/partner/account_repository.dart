import 'package:sukientotapp/data/models/partner/wallet_transaction_model.dart';

abstract class AccountRepository {
  Future<List<WalletTransactionModel>> getWalletTransactions();
  Future<String> regenerateAddFundsLink(int amount);
  Future<Map<String, dynamic>> confirmAddFunds({
    required String orderCode,
    required String status,
  });
  Future<void> logout();
  Future<void> deleteAccount(String password);
}
