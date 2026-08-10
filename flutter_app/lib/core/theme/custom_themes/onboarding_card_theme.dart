import 'package:Krishivani/core/constants/app_colors.dart';
import 'package:Krishivani/core/extensions/context_extensions.dart';
import 'package:Krishivani/core/theme/custom_themes/text_theme.dart';
import 'package:flutter/material.dart';

class OnboardingBottomCardTheme  {
  OnboardingBottomCardTheme._();

  static OnboardingBottomCardStyle light(BuildContext context) {
    return OnboardingBottomCardStyle(
      padding: EdgeInsets.symmetric(
        horizontal: context.spacingS,
        vertical: context.buttonHeight,
      ),
      titleStyle: AppTextTheme.textTheme.headlineMedium!.copyWith(color: AppColors.blacktext),
      subTitleStyle: AppTextTheme.textTheme.bodyLarge!.copyWith(color: AppColors.blacktext,fontWeight: FontWeight.w200),
      dotActiveColor: AppColors.primaryA,
      dotInactiveColor: AppColors.disabled,
      dotActiveSize: context.scale(16),
      dotInactiveSize: context.scale(14),
      bg_color: AppColors.whitetext,
      borderRadius: 40,
      boxShadow: [
        BoxShadow(
          color: AppColors.whitetext,
        ),
      ],
    );
  }
  //to be done
  static OnboardingBottomCardStyle dark(BuildContext context) {
    return OnboardingBottomCardStyle(
      padding: EdgeInsets.symmetric(
        horizontal: context.spacingS,
        vertical: context.buttonHeight,
      ),
      titleStyle: AppTextTheme.textTheme.headlineMedium!.copyWith(color: AppColors.whitetext),
      subTitleStyle: AppTextTheme.textTheme.bodyLarge!.copyWith(color: AppColors.whitetext,fontWeight: FontWeight.w200),
      dotActiveColor: AppColors.primaryA,
      dotInactiveColor: AppColors.disabled,
      dotActiveSize: context.scale(16),
      dotInactiveSize: context.scale(14),
      bg_color: AppColors.blacktext,
      borderRadius: 40,
      boxShadow: [
        BoxShadow(
          color: AppColors.dark_bg,
        ),
      ],
    );
  }

}

class OnboardingBottomCardStyle {
  final EdgeInsets padding;
  final TextStyle titleStyle;
  final TextStyle subTitleStyle;
  final Color dotActiveColor;
  final Color dotInactiveColor;
  final double dotActiveSize;
  final double dotInactiveSize;
  final Color bg_color;
  final double borderRadius;
  final List<BoxShadow>? boxShadow;

  OnboardingBottomCardStyle({
    required this.padding,
    required this.titleStyle,
    required this.subTitleStyle,
    required this.dotActiveColor,
    required this.dotInactiveColor,
    required this.dotActiveSize,
    required this.dotInactiveSize,
    required this.bg_color,
    this.borderRadius = 40,
    this.boxShadow,
  });
}
