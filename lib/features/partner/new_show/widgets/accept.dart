import 'package:sukientotapp/core/utils/import/global.dart';

import 'package:sukientotapp/features/components/button/plus.dart';
import '../controller.dart';

class Accept extends StatefulWidget {
  const Accept({super.key, required this.code, required this.billId});

  final String code;
  final int billId;

  @override
  State<Accept> createState() => _AcceptState();
}

class _AcceptState extends State<Accept> {
  final _priceController = TextEditingController();

  @override
  void dispose() {
    _priceController.dispose();
    super.dispose();
  }

  Future<void> _onSubmit() async {
    final raw = _priceController.text.trim();
    final price = double.tryParse(raw);
    if (price == null || price < 10000) {
      GetxSuperSnackbar.showError(
        'invalid_price'.trParams({'min': '10.000'}),
        title: 'error'.tr,
      );
      return;
    }

    final controller = Get.find<NewShowController>();
    final success = await controller.acceptBill(
      billId: widget.billId,
      price: price,
    );

    if (success) {
      Get.back();
      GetxSuperSnackbar.showSuccess(
        'accepted_show'.trParams({'code': widget.code}),
        title: 'success'.tr,
      );
    } else {
      GetxSuperSnackbar.showError(
        'failed_to_accept_show'.trParams({'code': widget.code}),
        title: 'failed'.tr,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: FTheme.of(context).colors.background,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.75,
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'price_quote'.tr,
                style: FTheme.of(
                  context,
                ).typography.xl.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                'price_quote_for_show'.trParams({'code': widget.code}),
                style: FTheme.of(
                  context,
                ).typography.base.copyWith(fontWeight: FontWeight.w500),
              ),
              Column(
                children: [
                  const SizedBox(height: 16),
                  TextField(
                    controller: _priceController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: 'input_price_quote'.tr,
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  Obx(() {
                    final ctrl = Get.find<NewShowController>();
                    final accepting = ctrl.isAccepting.value;
                    return CustomButtonPlus(
                      onTap: () {
                        if (!accepting) _onSubmit();
                      },
                      btnText: accepting ? 'loading'.tr : 'apply_for_show'.tr,
                      textSize: 14,
                      fontWeight: FontWeight.w600,
                      width: double.infinity,
                      height: 38,
                      borderRadius: 10,
                      borderColor: Colors.transparent,
                    );
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
