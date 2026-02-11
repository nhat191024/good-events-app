import 'package:sukientotapp/core/utils/import/global.dart';
import '../controller.dart';

class OrderHeader extends StatefulWidget {
  const OrderHeader({super.key, required this.controller});

  final ClientOrderController controller;

  @override
  State<OrderHeader> createState() => _OrderHeaderState();
}

class _OrderHeaderState extends State<OrderHeader> {
  bool isSearchActive = false;
  late final FocusNode searchFocusNode;
  late final TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    searchFocusNode = FocusNode();
    searchController = TextEditingController();

    // Listen to controller's search query
    searchController.addListener(() {
      widget.controller.searchQuery.value = searchController.text;
    });
  }

  @override
  void dispose() {
    searchFocusNode.dispose();
    searchController.dispose();
    super.dispose();
  }

  void _activateSearch() {
    setState(() {
      isSearchActive = true;
    });
    // Request focus after build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      searchFocusNode.requestFocus();
    });
  }

  void _deactivateSearch() {
    setState(() {
      isSearchActive = false;
    });
    searchController.clear();
    searchFocusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: context.statusBarHeight,
        left: 16,
        right: 16,
        bottom: 8,
      ),
      decoration: const BoxDecoration(color: Colors.white),
      child: Column(
        children: [
          // Title and Search Row
          SizedBox(
            height: 50,
            child: Stack(
              children: [
                // Default state: Title + Search Icon
                if (!isSearchActive)
                  Row(
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'my_orders'.tr,
                            style: context.typography.xl.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: _activateSearch,
                        icon: Icon(
                          Icons.search,
                          color: context.primary,
                        ),
                        tooltip: 'search_orders'.tr,
                      ),
                    ],
                  ),

                // Search active state: Back button + TextField
                if (isSearchActive)
                  Row(
                    children: [
                      IconButton(
                        onPressed: _deactivateSearch,
                        icon: const Icon(Icons.arrow_back),
                        tooltip: 'cancel'.tr,
                      ),
                      Expanded(
                        child: TextField(
                          controller: searchController,
                          focusNode: searchFocusNode,
                          decoration: InputDecoration(
                            hintText: 'search_orders'.tr,
                            hintStyle: context.typography.sm.copyWith(
                              color: Colors.grey[400],
                            ),
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 12,
                            ),
                          ),
                          style: context.typography.base,
                          onSubmitted: (_) => _deactivateSearch(),
                        ),
                      ),
                      if (searchController.text.isNotEmpty)
                        IconButton(
                          onPressed: () {
                            searchController.clear();
                          },
                          icon: const Icon(Icons.clear, size: 20),
                          tooltip: 'cancel'.tr,
                        ),
                    ],
                  ),
              ],
            ),
          ),

          // Parent Tabs (Event Orders | Asset Orders)
          TabBar(
            controller: widget.controller.parentTabController,
            labelColor: context.primary,
            unselectedLabelColor: Colors.black54,
            labelStyle: context.typography.base.copyWith(
              fontWeight: FontWeight.bold,
            ),
            unselectedLabelStyle: context.typography.sm,
            indicatorSize: TabBarIndicatorSize.tab,
            dividerColor: Colors.transparent,
            tabs: [
              Tab(text: 'event_orders'.tr),
              Tab(text: 'asset_orders'.tr),
            ],
          ),
        ],
      ),
    );
  }
}
