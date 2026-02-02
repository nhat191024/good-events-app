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
        _buildItem(itemWidth, AppColors.primary, FIcons.calendarSearch, 'take_order', "10"),
        _buildItem(itemWidth, AppColors.amber500, FIcons.calendarCheck2, 'waiting', "5"),
      ],
    );
  }

  Container _buildItem(
    double itemWidth,
    Color iconBgColor,
    IconData iconData,
    String title,
    String count,
  ) {
    return Container(
      width: itemWidth,
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(32)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.fromLTRB(5, 5, 16, 0),
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(color: iconBgColor, shape: BoxShape.circle),
            child: Icon(iconData, color: Colors.white, size: 24),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title.tr,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                Text(
                  count,
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
    );
  }
}
