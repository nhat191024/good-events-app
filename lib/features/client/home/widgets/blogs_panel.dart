import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:sukientotapp/features/components/common/blog_card.dart';

class ClientBlogPanel extends StatelessWidget {
  const ClientBlogPanel({Key? key, required this.blogs}) : super(key: key);

  final List<BlogCard> blogs;

  static const double panelHeight = 300.0;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
        height: panelHeight,
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          scrollDirection: Axis.horizontal,
          itemCount: blogs.length,
          separatorBuilder: (context, index) => const SizedBox(width: 12),
          itemBuilder: (context, index) {
            return SizedBox(
              width: MediaQuery.of(context).size.width * 0.7,
              child: blogs[index],
            );
          },
        ),
      ).animate(delay: 500.ms).fadeIn(duration: 200.ms),
    );
  }
}
