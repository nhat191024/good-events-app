import 'package:flutter_animate/flutter_animate.dart';
import 'package:sukientotapp/core/utils/import/global.dart';

class ClientBillCountPanel extends StatefulWidget {
  const ClientBillCountPanel({super.key});

  @override
  State<ClientBillCountPanel> createState() => _ClientBillCountPanelState();
}

class _ClientBillCountPanelState extends State<ClientBillCountPanel> {
  @override
  Widget build(BuildContext context) {
    double panelWidth = MediaQuery.of(context).size.width;
    double itemWidth = (panelWidth - 36) / 2;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _BillItem(
          width: itemWidth,
          iconBgColor: AppColors.primary,
          iconData: FIcons.calendarSearch,
          title: 'pending_order',
          count: "10",
        ),
        _BillItem(
          width: itemWidth,
          iconBgColor: AppColors.amber500,
          iconData: FIcons.calendarCheck2,
          title: 'confirmed_order',
          count: "5",
        ),
      ],
    ).animate(delay: 800.ms).fadeIn(duration: 200.ms);
  }
}

class _BillItem extends StatefulWidget {
  final double width;
  final Color iconBgColor;
  final IconData iconData;
  final String title;
  final String count;

  const _BillItem({
    required this.width,
    required this.iconBgColor,
    required this.iconData,
    required this.title,
    required this.count,
  });

  @override
  State<_BillItem> createState() => _BillItemState();
}

class _BillItemState extends State<_BillItem> with SingleTickerProviderStateMixin {
  AnimationController? _controller;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _controller?.forward().then((_) => _controller?.reverse());
      },
      child:
          Container(
                width: widget.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.fromLTRB(15, 15, 16, 0),
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(color: widget.iconBgColor, shape: BoxShape.circle),
                      child: Icon(widget.iconData, color: Colors.white, size: 24),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15, right: 15, top: 6, bottom: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.title.tr,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            widget.count,
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
              )
              .animate(
                autoPlay: false,
                onInit: (controller) => _controller = controller,
              )
              .scaleXY(end: 0.95, duration: 100.ms, curve: Curves.easeInOut),
    );
  }
}
