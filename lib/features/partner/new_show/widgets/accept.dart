import 'package:sukientotapp/core/utils/import/global.dart  ';

import 'package:sukientotapp/features/components/button/plus.dart';

class Accept extends StatelessWidget {
  const Accept({super.key, required this.code});

  final String code;

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
        constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.75),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'price_quote'.tr,
                style: FTheme.of(context).typography.xl.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                'price_quote_for_show'.trParams({'code': code}),
                style: FTheme.of(context).typography.base.copyWith(fontWeight: FontWeight.w500),
              ),
              Column(
                children: [
                  const SizedBox(height: 16),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      hintText: 'input_price_quote'.tr,
                    ),
                    keyboardType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  CustomButtonPlus(
                    onTap: () {

                    },
                    btnText: 'apply_for_show'.tr,
                    textSize: 14,
                    fontWeight: FontWeight.w600,
                    width: double.infinity,
                    height: 38,
                    borderRadius: 10,
                    borderColor: Colors.transparent,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
