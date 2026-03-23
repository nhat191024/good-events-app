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
}
