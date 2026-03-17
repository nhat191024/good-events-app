import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/features/partner/show/controller.dart';
import 'package:sukientotapp/features/common/message/controller.dart';

class PartnerBottomNavigationController extends GetxController {
  final RxInt currentIndex = 0.obs;
  var isReverse = false.obs;

  final ShowController showController = Get.find<ShowController>();

  String? _userChannel;

  @override
  void onInit() {
    super.onInit();
    _subscribeToUserChannel();
  }

  @override
  void onClose() {
    _unsubscribeUserChannel();
    super.onClose();
  }

  Future<void> _subscribeToUserChannel() async {
    final userId =
        StorageService.readMapData(key: LocalStorageKeys.user, mapKey: 'id')
            as int?;
    if (userId == null) {
      logger.w('[PartnerBottomNav] [UserChannel] userId is null, skipping subscribe');
      return;
    }
    final channelName = 'private-user-messages.$userId';
    await PusherService.subscribe(
      channelName: channelName,
      eventName: 'SendMessage',
      onEvent: _onUserChannelMessage,
    );
    _userChannel = channelName;
    logger.i('[PartnerBottomNav] [Pusher] Subscribed to $channelName');
  }

  Future<void> _unsubscribeUserChannel() async {
    if (_userChannel == null) return;
    await PusherService.unsubscribe(_userChannel!);
    logger.i('[PartnerBottomNav] [Pusher] Unsubscribed from $_userChannel');
    _userChannel = null;
  }

  void _onUserChannelMessage(PusherEvent event) {
    logger.i(
      '[PartnerBottomNav] [UserChannel] Raw event → name="${event.eventName}" data=${event.data}',
    );
    if (!Get.isRegistered<MessageController>()) {
      logger.w('[PartnerBottomNav] [UserChannel] MessageController not registered, skipping');
      return;
    }
    Get.find<MessageController>().onUserChannelEvent(event);
  }

  void setIndex(int index, {int? setTab}) {
    isReverse.value = index < currentIndex.value;
    currentIndex.value = index;

    if (index == 1 && setTab != null) {
      if (Get.isRegistered<ShowController>()) {
        final showController = Get.find<ShowController>();
        showController.switchTab(setTab);
      } else {}
    }
  }
}
