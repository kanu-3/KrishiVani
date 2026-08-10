import 'package:Krishivani/core/constants/app_colors.dart';
import 'package:Krishivani/core/constants/assets_paths.dart';
import 'package:Krishivani/core/extensions/context_extensions.dart';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';

class AppBottomNavbar extends StatelessWidget {

  const AppBottomNavbar({
    super.key,
    required this.currentIndex,
    required this.onTap,
    required this.controller,
  });

  final int currentIndex;
  final Function(int) onTap;
  final NotchBottomBarController controller;

  @override
  Widget build(BuildContext context) {
    return AnimatedNotchBottomBar(
      notchBottomBarController: controller,
      color: AppColors.main,
      kIconSize: context.spacingL,
      kBottomRadius: context.spacingL,
      bottomBarItems: [
        BottomBarItem(
          inActiveItem:
          Icon(
            AssetPaths.home,
            color: AppColors.bg,
          ),

          activeItem:
          Icon(
            AssetPaths.home,
            color: AppColors.main,
          ),

          itemLabel: 'Home',
        ),
        BottomBarItem(
          inActiveItem:
          Icon(
            AssetPaths.camera,
            color: AppColors.bg,
          ),
          activeItem:
          Icon(
            AssetPaths.camera,
            color: AppColors.main,
          ),
          itemLabel: 'Scan',
        ),
        BottomBarItem(
          inActiveItem:
          Icon(
            AssetPaths.market,
            color: AppColors.bg,
          ),
          activeItem:
          Icon(
            AssetPaths.market,
            color: AppColors.main,
          ),
          itemLabel: 'Market',
        ),
        BottomBarItem(
          inActiveItem:
          Icon(
            AssetPaths.chat,
            color: AppColors.bg,
          ),
          activeItem:
          Icon(
            AssetPaths.chat,
            color: AppColors.main,
          ),
          itemLabel: 'Chat',
        ),
      ],
      onTap: onTap,
    );
  }
}