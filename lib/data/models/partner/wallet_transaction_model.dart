class WalletTransactionModel {
  final String id;
  final String type;
  final String amount;
  final String newBalance;
  final String oldBalance;
  final String reason;
  final String createdAt;

  WalletTransactionModel({
    required this.id,
    required this.type,
    required this.amount,
    required this.newBalance,
    required this.oldBalance,
    required this.reason,
    required this.createdAt,
  });

  /// Returns true if the transaction is a debit (money going out of wallet)
  bool get isDebit => type != 'deposit';

  double get amountDouble => double.tryParse(amount) ?? 0.0;

  factory WalletTransactionModel.fromMap(Map<String, dynamic> map) {
    return WalletTransactionModel(
      id: map['id'].toString(),
      type: map['type']?.toString() ?? '',
      amount: map['amount']?.toString() ?? '0',
      newBalance: map['new_balance']?.toString() ?? '0',
      oldBalance: map['old_balance']?.toString() ?? '0',
      reason: map['reason']?.toString() ?? '',
      createdAt: map['created_at']?.toString() ?? '',
    );
  }
}
