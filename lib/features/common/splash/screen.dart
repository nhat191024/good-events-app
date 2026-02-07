import 'package:flutter/material.dart';
import 'package:get/get.dart';

//Styling package
import 'package:forui/forui.dart';
import 'package:video_player/video_player.dart';

import 'controller.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const colorizeColors = [
      Colors.purple,
      Colors.blue,
      Colors.yellow,
      Colors.red,
    ];

    const colorizeTextStyle = TextStyle(fontSize: 40.0, fontFamily: 'Lexend');

    return FScaffold(
      childPad: false,
      child: Stack(
        children: [
          Obx(() {
            if (controller.isVideoInitialized.value) {
              return SizedBox.expand(
                child: FittedBox(
                  fit: BoxFit.cover,
                  child: SizedBox(
                    width: controller.videoPlayerController.value.size.width,
                    height: controller.videoPlayerController.value.size.height,
                    child: VideoPlayer(controller.videoPlayerController),
                  ),
                ),
              );
            }
            return Center(
              child: Image.asset(
                'assets/images/logo.png', // Replace with your actual logo path
                width: 150,
              ),
            );
          }),
        ],
      ),
    );
  }
}
