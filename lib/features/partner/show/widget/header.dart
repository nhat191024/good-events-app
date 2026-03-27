import 'package:sukientotapp/core/utils/import/global.dart';
import '../controller.dart';

class Header extends StatelessWidget {
  const Header({super.key, required this.controller});

  final ShowController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: context.statusBarHeight,
        left: 16,
        right: 16,
      ),
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        children: [
          SizedBox(
            height: 60,
            width: context.width,
            child: Stack(
              alignment: Alignment.centerLeft,
              children: [
                Text(
                  'my_shows'.tr,
                  style: context.typography.xl.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          TabBar(
            controller: controller.tabController,
            labelColor: context.primary,
            unselectedLabelColor: Colors.black,
            labelStyle: context.typography.base.copyWith(
              fontWeight: FontWeight.bold,
            ),
            unselectedLabelStyle: context.typography.base.copyWith(
              fontWeight: FontWeight.normal,
            ),
            indicatorSize: TabBarIndicatorSize.tab,
            dividerColor: Colors.transparent,
            tabs: [
              Tab(text: 'news'.tr),
              Tab(text: 'upcomings'.tr),
              Tab(text: 'histories'.tr),
            ],
          ),
        ],
      ),
    );
  }
}
