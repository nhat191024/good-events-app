import 'dart:convert';

import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/data/models/partner/partner_bill_model.dart';
import 'package:sukientotapp/domain/repositories/partner/new_show_repository.dart';

class NewShowController extends GetxController {
  final NewShowRepository _repository;
  NewShowController(this._repository);

  final isLoading = false.obs;
  final hasMorePages = true.obs;
  final ScrollController scrollController = ScrollController();

  final bills = <PartnerBill>[].obs;
  final availableCategories = <AvailableCategory>[].obs;
  final lastUpdated = ''.obs;

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
      logger.i('[NewShow] [Accept] Bill $billId accepted at price $price');
      return true;
    } catch (e) {
      logger.e('[NewShow] [Accept] Error: $e');
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
