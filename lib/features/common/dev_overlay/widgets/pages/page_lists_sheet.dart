import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:sukientotapp/core/routes/pages.dart';

import '../dev_list_tile.dart';

class PageListsSheet extends StatelessWidget {
  const PageListsSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.75,
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DevListTile(
                icon: Icons.supervised_user_circle_outlined,
                title: 'Payment result',
                onTap: () => Get.toNamed(Routes.paymentResult),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
