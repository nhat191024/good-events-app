import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dev_list_tile.dart';

import 'package:sukientotapp/features/common/auth/login/login_controller.dart';

class UserLoginSheet extends StatelessWidget {
  const UserLoginSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.75),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DevListTile(
                icon: Icons.supervised_user_circle_outlined,
                title: 'Partner',
                onTap: () {
                  if (Get.isRegistered<LoginController>()) {
                    final loginController = Get.find<LoginController>();

                    loginController.usernameController.text = 'partner@example.com';
                    loginController.passwordController.text = 'password';

                    Get.snackbar(
                      'Success',
                      "Injected partner credentials",
                      duration: const Duration(seconds: 2),
                    );
                  } else {
                    Get.snackbar('Warning', 'You are not in login page');
                  }
                },
              ),
              DevListTile(
                icon: Icons.supervised_user_circle_outlined,
                title: 'Client',
                onTap: () {
                  if (Get.isRegistered<LoginController>()) {
                    final loginController = Get.find<LoginController>();

                    loginController.usernameController.text = 'client@example.com';
                    loginController.passwordController.text = 'password';

                    Get.snackbar(
                      'Success',
                      "Injected client credentials",
                      duration: const Duration(seconds: 2),
                    );
                  } else {
                    Get.snackbar('Warning', 'You are not in login page');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
