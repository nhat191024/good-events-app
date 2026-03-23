import 'package:sukientotapp/data/models/partner/wallet_transaction_model.dart';

abstract class AccountRepository {
  Future<List<WalletTransactionModel>> getWalletTransactions();
}
