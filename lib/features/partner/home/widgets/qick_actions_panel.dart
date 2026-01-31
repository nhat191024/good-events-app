import 'package:sukientotapp/core/utils/import/global.dart';

class QickActionsPanel extends StatelessWidget {
  const QickActionsPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), color: Colors.white),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FTappable(
                onPress: () {},
                child: SizedBox(
                  width: 60,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(FIcons.calendars, color: FTheme.of(context).colors.primary, size: 24),
                      SizedBox(height: 4),
                      Text(
                        'calendar'.tr,
                        maxLines: 2,
                        style: TextStyle(
                          color: FTheme.of(context).colors.primary,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              FTappable(
                onPress: () {},
                child: SizedBox(
                  width: 60,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(FIcons.calendarPlus, color: FTheme.of(context).colors.primary, size: 24),
                      SizedBox(height: 4),
                      Text(
                        'take_order'.tr,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: FTheme.of(context).colors.primary,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              FTappable(
                onPress: () {},
                child: SizedBox(
                  width: 60,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        FIcons.calendarRange,
                        color: FTheme.of(context).colors.primary,
                        size: 24,
                      ),
                      SizedBox(height: 4),
                      Text(
                        'waiting'.tr,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: FTheme.of(context).colors.primary,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              FTappable(
                onPress: () {},
                child: SizedBox(
                  width: 60,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        FIcons.calendarCheck2,
                        color: FTheme.of(context).colors.primary,
                        size: 24,
                      ),
                      SizedBox(height: 4),
                      Text(
                        'confirmed'.tr,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: FTheme.of(context).colors.primary,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
