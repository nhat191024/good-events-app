import 'dart:convert';

import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/data/models/partner/partner_bill_model.dart';
import 'package:sukientotapp/domain/repositories/partner/new_show_repository.dart';
import 'package:sukientotapp/features/partner/home/controller.dart';
import 'package:sukientotapp/features/partner/show/controller.dart';
import 'package:sukientotapp/features/common/message/controller.dart';

class NewShowController extends GetxController {
  final NewShowRepository _repository;
  NewShowController(this._repository);

  final isLoading = false.obs;
  final hasMorePages = true.obs;
  final ScrollController scrollController = ScrollController();

  final bills = <PartnerBill>[].obs;
  final availableCategories = <AvailableCategory>[].obs;
  final lastUpdated = ''.obs;

  // ─── Filter State ────────────────────────────────────────────────────────────
  final filterSearch = ''.obs;
  final filterDate = 'all'.obs;
  final filterSort = 'date_asc'.obs;
  final filteredBills = <PartnerBill>[].obs;

  bool get isFilterActive =>
      filterSearch.value.isNotEmpty ||
      filterDate.value != 'all' ||
      filterSort.value != 'date_asc';

  int _currentPage = 1;
  int _lastPage = 1;
  final _subscribedChannels = <String>[];

  static const _pusherEventName = 'NewPartnerBillCreated';

  @override
  void onInit() {
    super.onInit();
    fetchRealtimeBills();
    scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (scrollController.position.pixels >=
            scrollController.position.maxScrollExtent - 200 &&
        !isLoading.value &&
        hasMorePages.value) {
      fetchRealtimeBills();
    }
  }

  // ─── Filter Logic ────────────────────────────────────────────────────────────

  void applyFilter({
    required String search,
    required String dateFilter,
    required String sort,
  }) {
    filterSearch.value = search;
    filterDate.value = dateFilter;
    filterSort.value = sort;
    _applyLocalFilter();
  }

  void clearFilter() {
    filterSearch.value = '';
    filterDate.value = 'all';
    filterSort.value = 'date_asc';
    filteredBills.clear();
  }

  void _applyLocalFilter() {
    var result = List<PartnerBill>.from(bills);

    final q = filterSearch.value.toLowerCase().trim();
    if (q.isNotEmpty) {
      result = result
          .where(
            (b) =>
                b.code.toLowerCase().contains(q) ||
                b.clientName.toLowerCase().contains(q) ||
                b.eventName.toLowerCase().contains(q) ||
                b.categoryName.toLowerCase().contains(q) ||
                b.address.toLowerCase().contains(q),
          )
          .toList();
    }

    if (filterDate.value != 'all') {
      final now = DateTime.now();
      result = result.where((b) {
        final date = DateTime.tryParse(b.date);
        if (date == null) return false;
        switch (filterDate.value) {
          case 'today':
            return date.year == now.year &&
                date.month == now.month &&
                date.day == now.day;
          case 'this_week':
            final start = now.subtract(Duration(days: now.weekday - 1));
            final end = start.add(const Duration(days: 6));
            return !date.isBefore(
                  DateTime(start.year, start.month, start.day),
                ) &&
                !date.isAfter(DateTime(end.year, end.month, end.day, 23, 59));
          case 'this_month':
            return date.year == now.year && date.month == now.month;
          default:
            return true;
        }
      }).toList();
    }

    switch (filterSort.value) {
      case 'date_desc':
        result.sort((a, b) => b.date.compareTo(a.date));
        break;
      case 'price_asc':
        result.sort((a, b) => (a.finalTotal ?? 0).compareTo(b.finalTotal ?? 0));
        break;
      case 'price_desc':
        result.sort((a, b) => (b.finalTotal ?? 0).compareTo(a.finalTotal ?? 0));
        break;
      default: // date_asc
        result.sort((a, b) => a.date.compareTo(b.date));
        break;
    }

    filteredBills.value = result;
  }

  // ─────────────────────────────────────────────────────────────────────────────

  Future<void> fetchRealtimeBills() async {
    if (isLoading.value || !hasMorePages.value) return;
    isLoading.value = true;
    final pageToFetch = _currentPage;
    try {
      final response = await _repository.getRealtimeBills(page: pageToFetch);

      if (pageToFetch == 1) {
        bills.assignAll(response.partnerBills);
        availableCategories.assignAll(response.availableCategories);
        await _subscribeToCategories();
      } else {
        bills.addAll(response.partnerBills);
      }

      lastUpdated.value = response.lastUpdated;
      _lastPage = response.meta.lastPage;

      if (response.meta.currentPage < _lastPage) {
        _currentPage = response.meta.currentPage + 1;
        hasMorePages.value = true;
      } else {
        hasMorePages.value = false;
      }

      logger.i(
        '[NewShow] [Fetch] Page $pageToFetch/$_lastPage - ${bills.length} total bills',
      );
    } catch (e) {
      logger.e('[NewShow] [Fetch] Error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshBills() async {
    _currentPage = 1;
    _lastPage = 1;
    hasMorePages.value = true;
    await fetchRealtimeBills();
  }

  final isAccepting = false.obs;

  Future<bool> acceptBill({required int billId, required double price}) async {
    isAccepting.value = true;
    try {
      await _repository.acceptBill(billId: billId, price: price);
      bills.removeWhere((b) => b.id == billId);
      if (Get.isRegistered<PartnerHomeController>()) {
        Get.find<PartnerHomeController>().updateShowDataOnAccept();
      }
      if (Get.isRegistered<ShowController>()) {
        Get.find<ShowController>().refreshNewBills();
      }
    if (Get.isRegistered<MessageController>()){
      Get.find<MessageController>().refreshThreads();
    }

      logger.i('[NewShow] [Accept] Bill $billId accepted at price $price');
      return true;
    } catch (e) {
      logger.e('[NewShow] [Accept] Error: $e');

      AppSnackbar.showError(
        message: 'failed_to_accept_show'.tr,
        title: 'failed'.tr,
      );
      return false;
    } finally {
      isAccepting.value = false;
    }
  }

  Future<void> _subscribeToCategories() async {
    await _unsubscribeAll();

    for (final category in availableCategories) {
      final channelName = 'private-category.${category.id}';
      await PusherService.subscribe(
        channelName: channelName,
        eventName: _pusherEventName,
        onEvent: _onPusherEvent,
      );
      _subscribedChannels.add(channelName);
    }
  }

  void _onPusherEvent(PusherEvent event) {
    if (event.eventName != _pusherEventName) return;
    if (event.data == null) return;

    try {
      final data = jsonDecode(event.data!) as Map<String, dynamic>;

      if (data.containsKey('id') && data.containsKey('code')) {
        final newBill = PartnerBill.fromMap(data);
        bills.insert(0, newBill);
        lastUpdated.value = DateFormat('HH:mm:ss').format(DateTime.now());
        logger.i('[NewShow] [Pusher] New bill received: ${newBill.code}');
      } else {
        final response = RealtimeBillsResponse.fromMap(data);
        bills.insertAll(0, response.partnerBills);
        lastUpdated.value = response.lastUpdated;
        logger.i(
          '[NewShow] [Pusher] ${response.partnerBills.length} new bill(s) received',
        );
      }
    } catch (e) {
      logger.e('[NewShow] [Pusher] Error parsing event: $e');
    }
  }

  Future<void> _unsubscribeAll() async {
    for (final channel in _subscribedChannels) {
      await PusherService.unsubscribe(channel);
    }
    _subscribedChannels.clear();
  }

  @override
  void onClose() {
    _unsubscribeAll();
    scrollController.dispose();
    super.onClose();
  }
}
