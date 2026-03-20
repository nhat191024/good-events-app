import 'package:sukientotapp/core/utils/import/global.dart';
import 'package:sukientotapp/features/client/home/widgets/popup_search_sheet.dart';
import '../controller.dart';

class CategoryIntroCard extends GetView<GuestHomeController> {
  const CategoryIntroCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.ensurePartnersLoaded();
        showModalBottomSheet(
          context: context,
          builder: (context) => PopupPartnerSearchSheet(
            partnerCategories: controller.partnerList,
            isLoadingPartners: controller.isLoadingPartners,
          ),
          isScrollControlled: true,
        );
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   'partner categories here'.toUpperCase(),
            //   style: const TextStyle(
            //     fontSize: 14,
            //     fontWeight: FontWeight.w600,
            //     letterSpacing: 1.5,
            //     color: Colors.black, // white/80
            //   ),
            // ),
            // const SizedBox(height: 16),
            Obx(() {
              if (controller.isLoadingPartners.value && controller.partnerList.isEmpty) {
                return const SizedBox(
                  height: 230,
                  child: Center(child: CircularProgressIndicator()),
                );
              }

              final allPartners = controller.partnerList
                  .expand((category) => category.partnerList)
                  .toList();

              if (allPartners.isEmpty) {
                return const SizedBox.shrink();
              }

              return LayoutBuilder(
                builder: (context, constraints) {
                  final double itemWidth = (constraints.maxWidth - 24) / 3.5;

                  return SizedBox(
                    height: 230,
                    child: GridView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: allPartners.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 8,
                        crossAxisSpacing: 8,
                        mainAxisExtent: itemWidth,
                      ),
                      itemBuilder: (context, index) {
                        return IgnorePointer(
                          child: PartnerItem(partner: allPartners[index]),
                        );
                      },
                    ),
                  );
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
