import 'package:sukientotapp/core/utils/import/global.dart';
import '../controller/controller.dart';

class ReportBottomSheet extends GetView<ClientOrderDetailController> {
  const ReportBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
          top: 24,
          left: 24,
          right: 24,
          bottom: MediaQuery.of(context).viewInsets.bottom + 24,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'report_bill_title'.tr,
              style: context.typography.lg.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            Obx(() {
              final titleError = controller.reportErrors['title']?.join('\n');
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'report_title_label'.tr,
                    style: context.typography.sm.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: controller.reportTitleController,
                    decoration: InputDecoration(
                      hintText: 'report_title_hint'.tr,
                      errorText: titleError,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                  ),
                ],
              );
            }),

            const SizedBox(height: 16),

            Obx(() {
              final descError = controller.reportErrors['description']?.join('\n');
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'report_desc_label'.tr,
                    style: context.typography.sm.copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: controller.reportDescriptionController,
                    maxLines: 4,
                    decoration: InputDecoration(
                      hintText: 'report_desc_hint'.tr,
                      errorText: descError,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                  ),
                ],
              );
            }),

            const SizedBox(height: 24),

            Obx(() {
              final billIdError = controller.reportErrors['reported_bill_id']?.join('\n');
              if (billIdError != null) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Text(
                    billIdError,
                    style: context.typography.xs.copyWith(color: Colors.red),
                  ),
                );
              }
              return const SizedBox.shrink();
            }),

            Obx(
              () => SizedBox(
                height: 48,
                child: ElevatedButton(
                  onPressed: controller.isSubmittingReport.value
                      ? null
                      : () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          controller.submitReport();
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: context.primary,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: controller.isSubmittingReport.value
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                        )
                      : Text(
                          'submit_report'.tr,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
