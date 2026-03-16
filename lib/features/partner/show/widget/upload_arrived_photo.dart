import 'package:image_picker/image_picker.dart';
import 'package:sukientotapp/core/utils/import/global.dart';

import 'package:sukientotapp/features/components/widget/upload_photo.dart';
import 'package:sukientotapp/features/components/button/plus.dart';

import 'package:sukientotapp/features/partner/show/controller.dart';

class UploadArrivedPhoto extends StatelessWidget {
  const UploadArrivedPhoto({
    super.key,
    required this.code,
    required this.billId,
  });

  final String code;
  final int billId;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.8,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: context.fTheme.colors.background,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'upload_arrived_photo'.tr,
                style: context.typography.base.copyWith(
                  fontWeight: FontWeight.bold,
                  color: context.fTheme.colors.foreground,
                ),
              ),
              IconButton(onPressed: () => Get.back(), icon: Icon(FIcons.x)),
            ],
          ),
          Text(
            code,
            style: context.typography.base.copyWith(
              fontWeight: FontWeight.bold,
              color: context.fTheme.colors.foreground,
            ),
          ),
          const SizedBox(height: 20),
          UploadPhoto(
            onImagePicked: (XFile image) {
              Get.find<ShowController>().selectedImage.value = image;
            },
            onImageRemoved: () {
              Get.find<ShowController>().selectedImage.value = null;
            },
          ),
          Text(
            'upload_arrived_photo_desc'.tr,
            style: context.typography.base.copyWith(
              fontWeight: FontWeight.w300,
              fontSize: 12,
              color: context.fTheme.colors.foreground,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: CustomButtonPlus(
                  onTap: () => Get.back(),
                  btnText: 'cancel'.tr,
                  textSize: 14,
                  fontWeight: FontWeight.w600,
                  height: 34,
                  borderRadius: 10,
                  borderColor: Colors.transparent,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: CustomButtonPlus(
                  onTap: () => Get.find<ShowController>().markInJob(billId),
                  btnText: 'confirm'.tr,
                  textSize: 14,
                  fontWeight: FontWeight.w600,
                  height: 34,
                  borderRadius: 10,
                  borderColor: Colors.transparent,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
