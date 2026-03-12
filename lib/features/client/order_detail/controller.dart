import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/data/models/client/event_order_model.dart';
import 'package:sukientotapp/data/models/client/history_order_model.dart';
import 'package:sukientotapp/data/models/client/order_detail_model.dart';
import 'package:sukientotapp/domain/repositories/client/order_repository.dart';

class ClientOrderDetailController extends GetxController {
  final OrderRepository _repository;

  ClientOrderDetailController(this._repository);

  EventOrderModel? _eventOrder;
  HistoryOrderModel? _historyOrder;
  final RxBool isHistory = false.obs;

  // Details State
  final Rx<OrderDetailModel?> orderDetail = Rx<OrderDetailModel?>(null);
  final RxBool isLoadingDetails = false.obs;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    if (args != null && args is Map<String, dynamic>) {
      final order = args['order'];
      isHistory.value = args['isHistory'] ?? false;
      _assignOrder(order);
    } else {
      _assignOrder(args);
    }

    // Auto-fetch if this is a current order (where applicant/bill details lie)
    if (!isHistory.value && orderId != 0) {
      fetchOrderDetails();
    }
  }

  Future<void> fetchOrderDetails() async {
    isLoadingDetails.value = true;
    try {
      final response = await _repository.getOrderDetails(orderId);
      orderDetail.value = response;
    } catch (e) {
      logger.e('Error fetching order details: $e');
    } finally {
      isLoadingDetails.value = false;
    }
  }

  void _assignOrder(dynamic order) {
    if (order is HistoryOrderModel) {
      isHistory.value = true;
      _historyOrder = order;
    } else if (order is EventOrderModel) {
      isHistory.value = false;
      _eventOrder = order;
    }
  }

  // Unified Getters
  int get orderId {
    if (isHistory.value && _historyOrder != null) return _historyOrder!.id;
    if (!isHistory.value && _eventOrder != null) return _eventOrder!.id;
    return 0;
  }

  String get orderCode {
    if (isHistory.value && _historyOrder != null) return _historyOrder!.code ?? '';
    if (!isHistory.value && _eventOrder != null) return _eventOrder!.code;
    return '';
  }

  String get categoryName {
    if (isHistory.value && _historyOrder != null) return _historyOrder!.categoryName ?? '';
    if (!isHistory.value && _eventOrder != null) return _eventOrder!.categoryName;
    return '';
  }

  String get parentCategoryName {
    if (isHistory.value && _historyOrder != null) return _historyOrder!.parentCategoryName ?? '';
    if (!isHistory.value && _eventOrder != null) return _eventOrder!.parentCategoryName;
    return '';
  }

  String get eventName {
    if (isHistory.value && _historyOrder != null) return _historyOrder!.eventName ?? '';
    if (!isHistory.value && _eventOrder != null) return _eventOrder!.eventName;
    return '';
  }

  String get status {
    if (isHistory.value && _historyOrder != null) return _historyOrder!.status ?? '';
    if (!isHistory.value && _eventOrder != null) return _eventOrder!.status;
    return '';
  }

  String get address {
    if (isHistory.value && _historyOrder != null) return _historyOrder!.address ?? '';
    if (!isHistory.value && _eventOrder != null) return _eventOrder!.address;
    return '';
  }

  String get date {
    if (isHistory.value && _historyOrder != null) return _historyOrder!.date ?? '';
    if (!isHistory.value && _eventOrder != null) return _eventOrder!.date;
    return '';
  }

  String get startTime {
    if (isHistory.value && _historyOrder != null) return _historyOrder!.startTime ?? '';
    if (!isHistory.value && _eventOrder != null) return _eventOrder!.startTime;
    return '';
  }

  String get endTime {
    if (isHistory.value && _historyOrder != null) return _historyOrder!.endTime ?? '';
    if (!isHistory.value && _eventOrder != null) return _eventOrder!.endTime;
    return '';
  }

  double get finalTotal {
    if (isHistory.value && _historyOrder != null) {
      return _historyOrder!.finalTotal?.toDouble() ?? _historyOrder!.total?.toDouble() ?? 0.0;
    } else if (!isHistory.value && _eventOrder != null) {
      return _eventOrder!.finalTotal ?? 0.0;
    }
    return 0.0;
  }

  double get total {
    if (isHistory.value && _historyOrder != null) {
      return _historyOrder!.total?.toDouble() ?? 0.0;
    } else if (!isHistory.value && _eventOrder != null) {
      // EventOrderModel currently does not have 'total' mapped based on user payload,
      // falling back to finalTotal.
      return _eventOrder!.finalTotal ?? 0.0;
    }
    return 0.0;
  }

  String get note {
    if (isHistory.value && _historyOrder != null) return _historyOrder!.note ?? '';
    if (!isHistory.value && _eventOrder != null) return _eventOrder!.note;
    return '';
  }

  // Helper formatting created at
  String get createdAt {
    if (isHistory.value && _historyOrder != null) {
      return _historyOrder!.updatedAt ?? '';
    } else if (!isHistory.value && _eventOrder != null) {
      return '${_eventOrder!.date} ${_eventOrder!.startTime}';
    }
    return '';
  }

  String? get arrivalPhoto {
    if (isHistory.value && _historyOrder != null) {
      return _historyOrder!.arrivalPhoto;
    }
    return null;
  }

  String? get categoryImage {
    if (isHistory.value && _historyOrder != null) {
      return _historyOrder!.categoryImage;
    } else if (!isHistory.value && _eventOrder != null) {
      return _eventOrder!.categoryImage;
    }
    return null;
  }

  // Partner Info (If available)
  String get partnerName {
    if (isHistory.value && _historyOrder != null) {
      return _historyOrder!.partner?.partnerProfile?.partnerName ??
          _historyOrder!.partner?.name ??
          'partner_not_found'.tr;
    }
    // For current orders: find the chosen applicant (status == 'closed') from the details API
    if (!isHistory.value) {
      final items = orderDetail.value?.items ?? [];
      final chosen = items.where((i) => i.status == 'closed').firstOrNull;
      if (chosen != null) {
        return chosen.partner?.partnerProfile?.partnerName ??
            chosen.partner?.name ??
            'partner_not_found'.tr;
      }
    }
    return 'partner_not_found'.tr;
  }

  double? get partnerRating {
    if (isHistory.value && _historyOrder != null) {
      return _historyOrder!.partner?.statistics?.averageStars?.toDouble();
    }
    return null;
  }
}
