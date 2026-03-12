import 'dart:convert';

import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/data/models/partner/partner_bill_model.dart';
import 'package:sukientotapp/domain/repositories/partner/new_show_repository.dart';

class NewShowController extends GetxController {
  final NewShowRepository _repository;
  NewShowController(this._repository);

  final isLoading = false.obs;
  final ScrollController scrollController = ScrollController();

  final bills = <PartnerBill>[].obs;
  final availableCategories = <AvailableCategory>[].obs;
  final lastUpdated = ''.obs;

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
        !isLoading.value) {
      fetchRealtimeBills();
    }
  }

  Future<void> fetchRealtimeBills() async {
    if (isLoading.value) return;
    isLoading.value = true;
    try {
      final response = await _repository.getRealtimeBills();
      bills.assignAll(response.partnerBills);
      availableCategories.assignAll(response.availableCategories);
      lastUpdated.value = response.lastUpdated;
      logger.i('[NewShow] [Fetch] Fetched ${bills.length} bills');
      await _subscribeToCategories();
    } catch (e) {
      logger.e('[NewShow] [Fetch] Error: $e');
    } finally {
      isLoading.value = false;
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
