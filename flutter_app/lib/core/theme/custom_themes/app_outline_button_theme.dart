import 'package:Krishivani/core/constants/app_colors.dart';
import 'package:Krishivani/core/extensions/context_extensions.dart';
import 'package:Krishivani/core/theme/custom_themes/text_theme.dart';
import 'package:flutter/material.dart';

class AppOutlineButtonTheme {
  AppOutlineButtonTheme._();

  static OutlinedButtonThemeData light(BuildContext context) {
    return OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        backgroundColor: AppColors.whitetext,
        foregroundColor: AppColors.main,
        elevation: 0,
        textStyle: AppTextTheme.textTheme.titleLarge!
            .copyWith(color: AppColors.main),
        shape: RoundedRectangleBorder(
          borderRadius: context.borderRadiusM,
        ),
        padding: EdgeInsets.symmetric(
          horizontal: context.spacingM,
          vertical: context.spacingXS,
        ),
        minimumSize: Size(double.infinity, context.buttonHeight),
      ),
    );
  }

  static OutlinedButtonThemeData dark(BuildContext context){
    return OutlinedButtonThemeData(

    );
  }

}