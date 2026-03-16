import 'package:flutter_animate/flutter_animate.dart';
import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/data/models/client/partner_category_model.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PopupPartnerSearchSheet extends StatelessWidget {
  const PopupPartnerSearchSheet({
    // required this.controller,
    super.key,
    required this.partnerCategories,
    required this.isLoadingPartners,
  });

  final RxList<PartnerCategoryModel> partnerCategories;
  final RxBool isLoadingPartners;
  // final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
          padding: EdgeInsets.only(top: 45),
          height: Get.height,
          color: Colors.white,
          child: Column(
            children: [
              Row(
                children: [
                  FTappable(
                    onPress: () {
                      Get.back();
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 12, 10, 10),
                      child: Icon(FIcons.chevronDown),
                    ),
                  ),
                  Text(
                    'partner_search'.tr,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SearchBar(
                  hintText: 'search_with_dot'.tr,
                  onChanged: (value) {},
                  leading: const Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: Icon(Icons.search),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Obx(() {
                  if (isLoadingPartners.value && partnerCategories.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const CircularProgressIndicator(),
                          const SizedBox(height: 10),
                          Text('loading_with_dot'.tr),
                        ],
                      ),
                    );
                  }

                  if (partnerCategories.isEmpty) {
                    return Center(
                      child: Text(
                        'in_dev'.tr,
                        style: TextStyle(
                          color: context.fTheme.colors.mutedForeground,
                        ),
                      ),
                    );
                  }

                  return CustomScrollView(
                    slivers: [
                      for (int i = 0; i < partnerCategories.length; i++) ...[
                        SliverToBoxAdapter(
                          child: _buildCategoryHeader(partnerCategories[i]),
                        ),
                        _buildPartnerSliverGrid(partnerCategories[i]),
                        if (i < partnerCategories.length - 1)
                          const SliverToBoxAdapter(
                            child: Divider(
                              height: 5.0,
                              thickness: 5.0,
                              color: Color.fromARGB(32, 140, 126, 126),
                            ),
                          ),
                      ],
                    ],
                  );
                }),
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(duration: 100.ms)
        .slideY(duration: 560.ms, begin: 0.1, end: 0, curve: Curves.elasticOut);
  }

  /// build category header
  Widget _buildCategoryHeader(PartnerCategoryModel category) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            category.name,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          // FBadge(child: Text('${category.partnerList.length}')),
        ],
      ),
    );
  }

  /// build partner sliver grid
  Widget _buildPartnerSliverGrid(PartnerCategoryModel category) {
    return SliverGrid(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
      ),
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return PartnerItem(partner: category.partnerList[index]);
        },
        childCount: category.partnerList.length,
      ),
    );
  }
}

class PartnerItem extends StatelessWidget {
  const PartnerItem({super.key, required this.partner});

  final PartnerSubcategoryModel partner;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.toNamed(
          Routes.partnerDetail,
          arguments: {
            'slug': partner.slug,
          },
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: partner.image,
              height: 70,
              width: 70,
              fit: BoxFit.cover,
              placeholder: (context, url) => const SizedBox(
                height: 70,
                width: 70,
                child: Center(
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
              ),
              errorWidget: (context, url, error) => const SizedBox(
                height: 70,
                width: 70,
                child: Center(child: Icon(Icons.error, color: Colors.grey)),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
            child: Text(
              textAlign: TextAlign.center,
              partner.name,
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
            ),
          ),
        ],
      ),
    );
  }
}
