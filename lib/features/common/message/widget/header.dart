import 'package:searchbar_animation/searchbar_animation.dart';

import 'package:sukientotapp/core/utils/import/global.dart';
import '../controller.dart';

class Header extends StatefulWidget {
  const Header({super.key, required this.controller});

  final MessageController controller;

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  late final TextEditingController _searchTextController;

  @override
  void initState() {
    super.initState();
    _searchTextController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: context.statusBarHeight,
        left: 16,
        right: 16,
        bottom: 0,
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
                  'messages'.tr,
                  style: context.typography.xl.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: SearchBarAnimation(
                    searchBoxWidth: context.width - 32,
                    hintText: 'search_with_dot'.tr,
                    textEditingController: _searchTextController,
                    isOriginalAnimation: true,

                    buttonBorderColour: Colors.transparent,
                    buttonWidget: const Icon(
                      FIcons.search,
                      color: Colors.black,
                    ),
                    trailingWidget: const Icon(
                      FIcons.search,
                      color: Colors.black,
                    ),
                    secondaryButtonWidget: const Icon(
                      FIcons.x,
                      color: Colors.black,
                    ),

                    isSearchBoxOnRightSide: true,

                    onCollapseComplete: () {
                      _searchTextController.clear();
                      widget.controller.searchMessages('');
                    },

                    onChanged: (String value) {
                      widget.controller.searchMessages(value);
                    },
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
