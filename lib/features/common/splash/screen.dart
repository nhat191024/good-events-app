import 'package:flutter/material.dart';
import 'package:get/get.dart';

//Styling package
import 'package:forui/forui.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

import 'controller.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const colorizeColors = [Colors.purple, Colors.blue, Colors.yellow, Colors.red];

    const colorizeTextStyle = TextStyle(fontSize: 40.0, fontFamily: 'Lexend');

    return FScaffold(
      child: Center(
        child: AnimatedTextKit(
          animatedTexts: [
            ColorizeAnimatedText(
              'Sự kiện tốt',
              textStyle: colorizeTextStyle,
              colors: colorizeColors,
            ),
            ColorizeAnimatedText(
              'Tổ chức sự kiện dễ dàng',
              textStyle: colorizeTextStyle,
              colors: colorizeColors,
            ),
            ColorizeAnimatedText(
              'Thiết bị sự kiện',
              textStyle: colorizeTextStyle,
              colors: colorizeColors,
            ),
            ColorizeAnimatedText(
              'Thuê thiết bị, loa đài ánh sáng',
              textStyle: colorizeTextStyle,
              colors: colorizeColors,
            ),
            ColorizeAnimatedText(
              'Kho thiết kế',
              textStyle: colorizeTextStyle,
              colors: colorizeColors,
            ),
            ColorizeAnimatedText(
              'Trải nghiệm kho thiết kế',
              textStyle: colorizeTextStyle,
              colors: colorizeColors,
            ),
          ],
          isRepeatingAnimation: true,
          repeatForever: true,
          onTap: null,
        ),
      ),
    );
  }
}
