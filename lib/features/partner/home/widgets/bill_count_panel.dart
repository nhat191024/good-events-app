import 'package:sukientotapp/core/utils/import/global.dart';

class BillCountPanel extends StatelessWidget {
  const BillCountPanel({super.key});

  @override
  Widget build(BuildContext context) {
    double panelWidth = MediaQuery.of(context).size.width;
    double itemWidth = (panelWidth - 58) / 2;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: itemWidth,
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(32)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(5, 5, 16, 0),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(color: AppColors.primary, shape: BoxShape.circle),
                child: Icon(FIcons.calendarSearch, color: Colors.white, size: 24),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'new_show'.tr,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Text(
                      "10",
                      style: TextStyle(
                        color: AppColors.primary,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        Container(
          width: itemWidth,
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(32)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(5, 5, 16, 0),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(color: AppColors.amber600, shape: BoxShape.circle),
                child: Icon(FIcons.calendarCheck2, color: Colors.white, size: 24),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'confirmed'.tr,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Text(
                      "10",
                      style: TextStyle(
                        color: AppColors.amber600,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
