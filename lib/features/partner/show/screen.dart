import 'package:sukientotapp/core/utils/import/global.dart';
import 'controller.dart';

import './widget/header.dart';

//tabs
import './widget/new.dart';
import './widget/upcoming.dart';
import './widget/history.dart';

class ShowScreen extends GetView<ShowController> {
  const ShowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      childPad: false,
      header: Header(controller: controller),
      child: TabBarView(
        controller: controller.tabController,
        children: [
          NewWidget(),
          UpcomingWidget(),
          HistoryWidget(),
        ],
      ),
    );
  }
}
