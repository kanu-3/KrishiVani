import 'package:Krishivani/core/constants/assets_paths.dart';
import 'package:Krishivani/core/widgets/common/onboardingbottom_card.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<String> bgImages = [
    AssetPaths.bg01,
    AssetPaths.bg02,
    AssetPaths.bg03,
  ];

  final List<Map<String, String>> onboardText = [
    {
      "title": "Empowering Farmers with AI Insight.",
      "subtitle": "Scan, detect, and decide — all in one powerful farming assistant",
    },
    {
      "title": "From Symptoms to Solutions in Seconds.",
      "subtitle": "Use camera, voice, or text to instantly identify plant diseases.",
    },
    {
      "title": "Diagnose Smart. Sell Smarter.",
      "subtitle": "Get real-time crop health insights and smart selling suggestions.",
    },
  ];

  void _next() {
    if (_currentIndex < 2) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeOut,
      );
    } else {
      context.go("/login");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: bgImages.length,
            onPageChanged: (index) => setState(() => _currentIndex = index),
            itemBuilder: (_, index) {
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(bgImages[index]),
                    fit: BoxFit.cover,
                  ),
                ),
              );
            },
          ),

          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: OnboardingBottomCard(
                      title: onboardText[_currentIndex]["title"]!,
                      subTitle: onboardText[_currentIndex]["subtitle"]!,
                      index: _currentIndex,
                      total: bgImages.length,
                      next: _next,
                  ),
                  //
                  // context.gapM,
                  //
                  // if (_currentIndex != bgImages.length-1)
                  //   GestureDetector(
                  //     onTap: () => context.go("/login"),
                  //     child: Text(
                  //       "Skip",
                  //       style: Theme.of(context)
                  //           .textTheme
                  //           .bodyMedium
                  //           ?.copyWith(color: AppColors.disabled),
                  //     ),
                  //   ),

              ),

        ],
      ),
    );
  }
}
