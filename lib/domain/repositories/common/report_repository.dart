abstract class ReportRepository {
  Future<Map<String, dynamic>> reportUser({
    required int reportedUserId,
    required String title,
    required String description,
  });

  Future<Map<String, dynamic>> reportBill({
    required int reportedBillId,
    required String title,
    required String description,
  });
}
