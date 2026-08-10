import 'package:Krishivani/core/constants/app_colors.dart';
import 'package:Krishivani/core/extensions/context_extensions.dart';
import 'package:Krishivani/core/theme/custom_themes/text_theme.dart';
import 'package:flutter/material.dart';

class AppElevatedButtonTheme {
  AppElevatedButtonTheme._();

  static ElevatedButtonThemeData light(BuildContext context){
  return ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.main,
      foregroundColor: AppColors.whitetext,
      elevation: 0,
      textStyle: AppTextTheme.textTheme.titleLarge!.copyWith(color: AppColors.whitetext),
      shape: RoundedRectangleBorder(
        borderRadius: context.borderRadiusM ,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: context.spacingM,
        vertical: context.spacingXS*0.3,),
      minimumSize: Size(double.infinity, context.buttonHeight),
    ),
  );
  }

  static ElevatedButtonThemeData dark(BuildContext context) {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
      backgroundColor: AppColors.main,
      foregroundColor: AppColors.blacktext,
      elevation: 0,
      textStyle: AppTextTheme.textTheme.titleLarge!.copyWith(color: AppColors.blacktext),
      shape: RoundedRectangleBorder(
        borderRadius: context.borderRadiusS,
      ),
      padding: EdgeInsets.symmetric(
          horizontal: context.spacingM,
          vertical: context.spacingXS*0.3 ),
      minimumSize:  Size(double.infinity, context.buttonHeight)
    ),
  );
}
}