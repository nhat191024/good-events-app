import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart'; // Import GetX for RxString and Obx
import 'package:sukientotapp/core/utils/import/global.dart';

class FakeSearchBar extends StatefulWidget {
  const FakeSearchBar({
    super.key,
    required this.onTap,
    this.readOnly = true,
  });

  final Function() onTap;
  final bool readOnly;

  @override
  State<FakeSearchBar> createState() => _FakeSearchBarState();
}

class _FakeSearchBarState extends State<FakeSearchBar> {
  // Use RxString to keep reactive UI updates with Obx
  RxString searchHint = ''.obs;
  Timer? _timer;
  int hintIndex = 0;

  List<String> hints = [
    'search_hint_1'.tr,
    'search_hint_2'.tr,
    'search_hint_3'.tr,
  ];

  @override
  void initState() {
    super.initState();
    // Initialize first hint
    if (hints.isNotEmpty) {
      searchHint.value = hints[0];
    }
    _startDynamicHintText();
  }

  void _startDynamicHintText() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      if (mounted) {
        hintIndex = (hintIndex + 1) % hints.length;
        searchHint.value = hints[hintIndex];
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.centerLeft,
      children: [
        SearchBar(
              readOnly: widget.readOnly,
              padding: const WidgetStatePropertyAll(EdgeInsets.symmetric(horizontal: 16)),
              leading: const Icon(Icons.search),
              elevation: const WidgetStatePropertyAll(0),
              side: WidgetStatePropertyAll(BorderSide(color: AppColors.primary.withAlpha(20))),
              onTap: () => widget.onTap(),
            )
            .animate(onPlay: (c) => c.repeat(reverse: true))
            .boxShadow(
              begin: const BoxShadow(color: Colors.transparent, blurRadius: 0),
              end: BoxShadow(
                color: AppColors.primary.withAlpha(90), // Fixed deprecated withAlpha
                blurRadius: 8,
                spreadRadius: 1,
              ),
              duration: const Duration(seconds: 1),
              borderRadius: BorderRadius.circular(36),
            ),

        IgnorePointer(
          child: Padding(
            padding: const EdgeInsets.only(left: 48.0),
            child: Obx(
              () =>
                  Text(
                        searchHint.value,
                        style: context.typography.sm.copyWith(
                          color: context.fTheme.colors.mutedForeground,
                        ),
                      )
                      // CRITICAL FIX: Use .value for the key so animation triggers on change
                      .animate(key: ValueKey(searchHint.value))
                      .fadeIn(duration: 400.ms)
                      .slideX(begin: 0.2, end: 0, curve: Curves.easeOutCubic),
            ),
          ),
        ),
      ],
    ).animate(delay: 100.ms).fadeIn(duration: 500.ms);
  }
}
