import 'package:sukientotapp/data/models/partner/partner_bill_model.dart';

class ShowBillCategory {
  final int id;
  final String name;

  const ShowBillCategory({required this.id, required this.name});

  factory ShowBillCategory.fromMap(Map<String, dynamic> map) {
    return ShowBillCategory(
      id: map['id'] as int,
      name: map['name'] as String,
    );
  }
}

class ShowBillEvent {
  final int id;
  final String name;

  const ShowBillEvent({required this.id, required this.name});

  factory ShowBillEvent.fromMap(Map<String, dynamic> map) {
    return ShowBillEvent(
      id: map['id'] as int,
      name: map['name'] as String,
    );
  }
}

class ShowBillClient {
  final int id;
  final String name;
  final String email;

  const ShowBillClient({
    required this.id,
    required this.name,
    required this.email,
  });

  factory ShowBillClient.fromMap(Map<String, dynamic> map) {
    return ShowBillClient(
      id: map['id'] as int,
      name: map['name'] as String,
      email: map['email'] as String,
    );
  }
}

class ShowBill {
  final int id;
  final String code;
  final String address;
  final String phone;
  final String date;
  final String startTime;
  final String endTime;
  final double? total;
  final double? finalTotal;
  final String status;
  final String? note;
  final int? threadId;
  final String? arrivalPhoto;
  final String createdAt;
  final ShowBillCategory category;
  final ShowBillEvent event;
  final ShowBillClient client;

  const ShowBill({
    required this.id,
    required this.code,
    required this.address,
    required this.phone,
    required this.date,
    required this.startTime,
    required this.endTime,
    this.total,
    this.finalTotal,
    required this.status,
    this.note,
    this.threadId,
    this.arrivalPhoto,
    required this.createdAt,
    required this.category,
    required this.event,
    required this.client,
  });

  factory ShowBill.fromMap(Map<String, dynamic> map) {
    return ShowBill(
      id: map['id'] as int,
      code: map['code'] as String,
      address: map['address'] as String,
      phone: map['phone'] as String,
      date: map['date'] as String,
      startTime: map['start_time'] as String,
      endTime: map['end_time'] as String,
      total:
          map['total'] != null ? (map['total'] as num).toDouble() : null,
      finalTotal:
          map['final_total'] != null
              ? (map['final_total'] as num).toDouble()
              : null,
      status: map['status'] as String,
      note: map['note'] as String?,
      threadId: map['thread_id'] as int?,
      arrivalPhoto: map['arrival_photo'] as String?,
      createdAt: map['created_at'] as String,
      category: ShowBillCategory.fromMap(
        map['category'] as Map<String, dynamic>,
      ),
      event: ShowBillEvent.fromMap(map['event'] as Map<String, dynamic>),
      client: ShowBillClient.fromMap(
        map['client'] as Map<String, dynamic>,
      ),
    );
  }
}

class ShowBillsResponse {
  final List<ShowBill> bills;
  final PaginationMeta meta;

  const ShowBillsResponse({required this.bills, required this.meta});

  factory ShowBillsResponse.fromMap(Map<String, dynamic> map) {
    final billsData = map['bills'] as Map<String, dynamic>;
    return ShowBillsResponse(
      bills:
          (billsData['data'] as List<dynamic>)
              .map((e) => ShowBill.fromMap(e as Map<String, dynamic>))
              .toList(),
      meta: PaginationMeta.fromMap(
        billsData['meta'] as Map<String, dynamic>,
      ),
    );
  }
}
