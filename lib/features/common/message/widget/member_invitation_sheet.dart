import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/core/utils/phone_number_censor.dart';
import 'package:sukientotapp/data/models/chat_invitation_model.dart';
import 'package:sukientotapp/features/common/message/controller.dart';

Future<void> showMemberInvitationSheet(MessageController controller) async {
  controller.resetMemberSearch();
  await Get.bottomSheet<void>(
    _MemberInvitationSheet(controller: controller),
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
  );
  controller.resetMemberSearch();
}

class _MemberInvitationSheet extends StatelessWidget {
  const _MemberInvitationSheet({required this.controller});

  final MessageController controller;

  @override
  Widget build(BuildContext context) {
    final colors = context.fTheme.colors;
    return SafeArea(
      child: Container(
        height: MediaQuery.sizeOf(context).height * 0.72,
        padding: EdgeInsets.fromLTRB(
          20,
          12,
          20,
          16,
        ),
        decoration: BoxDecoration(
          color: colors.background,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 42,
                height: 4,
                decoration: BoxDecoration(
                  color: colors.border,
                  borderRadius: BorderRadius.circular(99),
                ),
              ),
            ),
            const SizedBox(height: 18),
            Text(
              'Mời thành viên',
              style: TextStyle(
                color: colors.foreground,
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'Nhập ít nhất 3 ký tự của số điện thoại.',
              style: TextStyle(color: colors.mutedForeground, fontSize: 13),
            ),
            const SizedBox(height: 16),
            FTextField(
              control: FTextFieldControl.managed(
                onChange: (value) => controller.searchMembers(value.text),
              ),
              autofocus: true,
              keyboardType: TextInputType.phone,
              label: const Text('Số điện thoại'),
              hint: 'Ví dụ: 090123',
            ),
            const SizedBox(height: 12),
            Expanded(child: Obx(() => _buildResults(context))),
          ],
        ),
      ),
    );
  }

  Widget _buildResults(BuildContext context) {
    final colors = context.fTheme.colors;
    if (controller.memberPhoneQuery.value.length < 3) {
      return const Center(child: Text('Nhập số điện thoại để bắt đầu tìm kiếm.'));
    }
    if (controller.isSearchingMembers.value) {
      return Center(
        child: CircularProgressIndicator(color: AppColors.primary, strokeWidth: 2),
      );
    }
    if (controller.memberSearchError.value.isNotEmpty) {
      return Center(
        child: Text(
          controller.memberSearchError.value,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.red),
        ),
      );
    }
    if (controller.memberSearchResults.isEmpty) {
      return const Center(child: Text('Không tìm thấy người dùng.'));
    }
    return ListView.separated(
      padding: const EdgeInsets.only(bottom: 24),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      itemCount: controller.memberSearchResults.length,
      separatorBuilder: (_, _) => Divider(color: colors.border),
      itemBuilder: (context, index) {
        final user = controller.memberSearchResults[index];
        return _UserTile(user: user, controller: controller);
      },
    );
  }
}

class _UserTile extends StatelessWidget {
  const _UserTile({required this.user, required this.controller});
  final ChatUserSearchResult user;
  final MessageController controller;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(user.name, maxLines: 1, overflow: TextOverflow.ellipsis),
      subtitle: Text(PhoneNumberCensor.censor(user.phone)),
      trailing: SizedBox(
        width: 88,
        child: Obx(() {
          final pending = controller.pendingInvitationUserIds.contains(user.id);
          final loading = controller.invitingUserIds.contains(user.id);
          if (pending) {
            return const Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Đang chờ',
                style: TextStyle(
                  color: Color(0xFFD97706),
                  fontWeight: FontWeight.w600,
                ),
              ),
            );
          }
          return FButton(
            onPress: loading ? null : () => controller.inviteUser(user),
            child: loading
                ? const SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('Mời'),
          );
        }),
      ),
    );
  }
}
