import 'package:sukientotapp/core/utils/import/global.dart';

import 'dev_list_tile.dart';
import 'pages/page_lists_sheet.dart';

class PageActionGroup extends StatelessWidget {
  const PageActionGroup({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: ExpansionTile(
        leading: Icon(Icons.pages, color: AppColors.primary),
        title: Text(
          'Pages',
          style: (Theme.of(context).textTheme.titleMedium ?? const TextStyle())
              .copyWith(
                fontFamily: 'Lexend',
                color: Theme.of(context).textTheme.titleMedium?.color,
              ),
        ),
        children: [
          DevListTile(
            indented: true,
            icon: Icons.list_alt_outlined,
            title: 'List Pages',
            onTap: () => Get.bottomSheet(const PageListsSheet()),
          ),
        ],
      ),
    );
  }
}
