import 'package:Krishivani/core/constants/app_colors.dart';
import 'package:Krishivani/core/constants/core_colors.dart';
import 'package:Krishivani/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class AppImageCarousel extends StatefulWidget {
  final List<String> images;
  final double height;
  final BorderRadius? borderRadius;

  const AppImageCarousel({
    super.key,
    required this.images,
    this.height = 320,
    this.borderRadius,
  });

  @override
  State<AppImageCarousel> createState() => AppImageCarouselState();
}

class AppImageCarouselState extends State<AppImageCarousel> {
  final PageController pageController = PageController();

  int currentPage = 0;

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.images.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      children: [
        SizedBox(
          height: widget.height,
          child: PageView.builder(
            controller: pageController,
            itemCount: widget.images.length,
            onPageChanged: (index) {
              setState(() {
                currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              return Padding(
                padding: context.padAllXS,
                child: ClipRRect(
                  borderRadius: widget.borderRadius ??
                      BorderRadius.circular(
                        context.scale(20),
                      ),
                  child: Image.asset(
                    widget.images[index],
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              );
            },
          ),
        ),

        if (widget.images.length > 1) ...[
          SizedBox(height: context.scaleH(8)),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              widget.images.length,
                  (index) => AnimatedContainer(
                duration: const Duration(
                  milliseconds: 200,
                ),
                margin: const EdgeInsets.symmetric(
                  horizontal: 4,
                ),
                width: currentPage == index ? 20 : 8,
                height: context.scaleH(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    context.scaleH(100),
                  ),
                  color: currentPage == index
                      ? AppColors.blacktext
                      : CoreColors.grey300,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}