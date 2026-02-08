import 'package:flutter_animate/flutter_animate.dart';

import 'package:sukientotapp/core/utils/import/global.dart';

import 'package:sukientotapp/features/client/home/widgets/bill_count.dart';
import 'package:sukientotapp/features/client/home/widgets/blogs_panel.dart';
import 'package:sukientotapp/features/client/home/widgets/header.dart';
import 'package:sukientotapp/features/client/home/widgets/new_order.dart';
import 'package:sukientotapp/features/client/home/widgets/popup_search_sheet.dart';
import 'package:sukientotapp/features/client/home/widgets/quick_action_panel.dart';
import 'package:sukientotapp/features/client/home/widgets/fake_search_bar.dart';

// import 'package:url_launcher/url_launcher.dart';

import 'controller.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double statusBarHeight = MediaQuery.of(context).viewPadding.top;
    TextEditingController searchController = TextEditingController();

    return FScaffold(
      header: Container(
        padding: EdgeInsets.only(top: statusBarHeight, left: 16, right: 16, bottom: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClientHomeHeader(controller: controller),
            const SizedBox(height: 6),
            FakeSearchBar(
              onTap: () {
                searchController.clear();
                showModalBottomSheet(
                  context: context,
                  builder: (context) =>
                      PopupPartnerSearchSheet(partnerCategories: controller.partnerList),
                  isScrollControlled: true,
                );
              },
            ),
          ],
        ),
      ),

      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Text(
              'quick_actions'.tr,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ).animate(delay: 650.ms).fadeIn(duration: 200.ms),

            const ClientQuickActionPanel(),

            const SizedBox(height: 4),
            const ClientBillCountPanel(),

            const SizedBox(height: 8),
            const NewOrderPanel(),

            const SizedBox(height: 14),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'news_and_blogs'.tr,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                GestureDetector(
                  onTap: () {
                    Get.snackbar('notification'.tr, 'in_dev'.tr);
                    // launchUrl(
                    //   Uri.parse(
                    //     'https://sukientot.com/dia-diem-to-chuc-su-kien',
                    //   ),
                    //   mode: LaunchMode.externalApplication,
                    // );
                  },
                  child: Text(
                    'see_more'.tr,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ).animate(delay: 900.ms).fadeIn(duration: 200.ms),

            const SizedBox(height: 8),
            ClientBlogPanel(blogs: controller.blogs),

            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
