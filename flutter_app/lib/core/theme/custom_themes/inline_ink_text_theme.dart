import 'package:Krishivani/core/constants/app_colors.dart';
import 'package:Krishivani/core/theme/custom_themes/text_theme.dart';
import 'package:flutter/material.dart';

class InlineLinkTextTheme {
  InlineLinkTextTheme._();

  static TextStyle lightNormal =
  AppTextTheme.textTheme.bodyLarge!.copyWith(
    color: AppColors.blacktext,
  );

  static TextStyle lightBold =
  AppTextTheme.textTheme.headlineSmall!.copyWith(
    color: AppColors.blacktext,
  );

  static TextStyle darkNormal =
  AppTextTheme.textTheme.bodyLarge!.copyWith(
    color: AppColors.whitetext,
  );

  static TextStyle darkBold =
  AppTextTheme.textTheme.headlineSmall!.copyWith(
    color: AppColors.whitetext,
  );
}
