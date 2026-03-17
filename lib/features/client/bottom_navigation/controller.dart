import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/features/common/message/controller.dart';

class ClientBottomNavigationController extends GetxController {
  final RxInt currentIndex = 0.obs;
  var isReverse = false.obs;

  static const _pusherEventName = 'SendMessage';
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
    if (userId == null) return;
    final channelName = 'private-user-messages.$userId';
    await PusherService.subscribe(
      channelName: channelName,
      eventName: _pusherEventName,
      onEvent: _onUserChannelMessage,
    );
    _userChannel = channelName;
    logger.i('[ClientBottomNav] [Pusher] Subscribed to $channelName');
  }

  Future<void> _unsubscribeUserChannel() async {
    if (_userChannel == null) return;
    await PusherService.unsubscribe(_userChannel!);
    logger.i('[ClientBottomNav] [Pusher] Unsubscribed from $_userChannel');
    _userChannel = null;
  }

  void _onUserChannelMessage(PusherEvent event) {
    if (Get.isRegistered<MessageController>()) {
      Get.find<MessageController>().onUserChannelEvent(event);
    }
  }

  void setIndex(int index) {
    isReverse.value = index < currentIndex.value;
    currentIndex.value = index;
  }
}
