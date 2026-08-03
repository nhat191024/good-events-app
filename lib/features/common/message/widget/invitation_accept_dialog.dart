import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/features/common/message/controller.dart';

/// Shows the receiver-side confirmation UI when a notification or deep link
/// supplies the invitation's thread id.
Future<bool> showChatInvitationDialog({
  required String threadId,
  required MessageController controller,
  String? inviterName,
}) async {
  final normalizedInviterName = inviterName?.trim();
  final accepted = await Get.dialog<bool>(
    Builder(
      builder: (dialogContext) => AlertDialog(
        title: const Text('Lời mời tham gia đoạn chat'),
        content: Text(
          normalizedInviterName == null || normalizedInviterName.isEmpty
              ? 'Bạn được mời tham gia đoạn chat. Bạn cần đồng ý trước khi có thể đọc tin nhắn hoặc tham gia cuộc gọi.'
              : '$normalizedInviterName đã mời bạn tham gia đoạn chat. Bạn cần đồng ý trước khi có thể đọc tin nhắn hoặc tham gia cuộc gọi.',
        ),
        actions: [
          Obx(
            () => TextButton(
              onPressed: controller.isAcceptingInvitation.value
                  ? null
                  : () => Navigator.of(dialogContext).pop(false),
              child: const Text('Để sau'),
            ),
          ),
          Obx(
            () => FButton(
              onPress: controller.isAcceptingInvitation.value
                  ? null
                  : () async {
                      final success = await controller.acceptInvitation(
                        threadId,
                      );
                      if (success && dialogContext.mounted) {
                        Navigator.of(dialogContext).pop(true);
                      }
                    },
              child: controller.isAcceptingInvitation.value
                  ? const SizedBox(
                      width: 18,
                      height: 18,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Đồng ý'),
            ),
          ),
        ],
      ),
    ),
    barrierDismissible: false,
  );
  return accepted ?? false;
}
