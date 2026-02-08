import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/features/client/home/widgets/fake_search_bar.dart';

class PopupPartnerSearchSheet extends StatelessWidget {
  const PopupPartnerSearchSheet({
    // required this.controller,
    super.key,
    required this.partnerCategories,
  });

  final RxList<PartnerCategory> partnerCategories;
  // final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    logger.i('this is partner categories: ${partnerCategories.toString()}');
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
                child: ListView.separated(
                  itemCount: partnerCategories.length,
                  itemBuilder: (context, index) {
                    return _buildPartnerCategory(partnerCategories[index]);
                  },
                  separatorBuilder: (context, index) {
                    return const Divider(
                      height: 5.0,
                      thickness: 5.0,
                      color: Color.fromARGB(32, 140, 126, 126),
                    );
                  },
                ),
              ),
            ],
          ),
        )
        .animate()
        .fadeIn(duration: 100.ms)
        .slideY(duration: 800.ms, begin: 0.1, end: 0, curve: Curves.elasticOut);
  }

  /// build partner category
  Widget _buildPartnerCategory(PartnerCategory category) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start, // Ensure proper alignment
      mainAxisSize: MainAxisSize.min, // Keep column size minimal
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(category.name, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              // FBadge(child: Text('${category.partnerList.length}')),
            ],
          ),
        ),
        _buildPartnerList(category),
      ],
    );
  }

  /// build partner list
  /// grid with 3 columns
  Widget _buildPartnerList(PartnerCategory category) {
    return GridView.builder(
      shrinkWrap: true,
      primary: false,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 1,
        crossAxisSpacing: 4,
        mainAxisSpacing: 4,
      ),
      itemCount: category.partnerList.length,
      itemBuilder: (context, index) {
        return PartnerItem(partner: category.partnerList[index]);
      },
    );
  }
}

class PartnerItem extends StatelessWidget {
  const PartnerItem({super.key, required this.partner});

  final PartnerCard partner;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(partner.image, height: 70, width: 70, fit: BoxFit.cover),
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

class PartnerCard {
  const PartnerCard({required this.id, required this.name, required this.image});

  final String id;
  final String name;
  final String image;
  @override
  String toString() {
    return 'PartnerCard(id: $id, name: $name)';
  }
}

class PartnerCategory {
  const PartnerCategory({
    required this.id,
    required this.name,
    required this.image,
    this.partnerList = const [],
  });

  final String id;
  final String name;
  final String image;
  final List<PartnerCard> partnerList;

  @override
  String toString() {
    return 'PartnerCategory(id: $id, name: $name, partnerList: $partnerList)';
  }
}
