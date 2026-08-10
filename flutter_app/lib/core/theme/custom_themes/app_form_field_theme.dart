import 'package:Krishivani/core/constants/app_colors.dart';
import 'package:Krishivani/core/extensions/context_extensions.dart';
import 'package:Krishivani/core/theme/custom_themes/text_theme.dart';
import 'package:flutter/material.dart';

class AppFormFieldTheme {
  AppFormFieldTheme._();

  static InputDecorationTheme light ( BuildContext context){
    return InputDecorationTheme(
      iconColor: AppColors.blacktext,
      labelStyle: AppTextTheme.textTheme.bodyLarge!.copyWith(color: AppColors.blacktext),
      hintStyle: AppTextTheme.textTheme.bodySmall!.copyWith(color: AppColors.dark_bg),

      filled: true,
      fillColor: AppColors.whitetext,

      border: OutlineInputBorder(
        borderRadius: context.borderRadiusS,
        borderSide: BorderSide( color: AppColors.disabled),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: context.borderRadiusS,
        borderSide: BorderSide( color: AppColors.primaryA),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: context.borderRadiusS,
        borderSide: BorderSide( color: AppColors.main, width: context.spacingXXS*0.5),
      ),

      contentPadding: EdgeInsets.symmetric(
        horizontal: context.spacingM,
        vertical: context.spacingXS,),
    );
  }

  static InputDecorationTheme dark (BuildContext context){
    return InputDecorationTheme(
      iconColor: AppColors.whitetext,
      labelStyle: AppTextTheme.textTheme.bodyLarge!.copyWith(color: AppColors.whitetext),
      hintStyle: AppTextTheme.textTheme.bodySmall!.copyWith(color: AppColors.whitetext),

      filled: true,
      fillColor: AppColors.dark_bg,

      border: OutlineInputBorder(
        borderRadius: context.borderRadiusS,
        borderSide: BorderSide( color: AppColors.disabled),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: context.borderRadiusS,
        borderSide: BorderSide( color: AppColors.primaryA),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: context.borderRadiusS,
        borderSide: BorderSide( color: AppColors.main, width: context.spacingXXS*0.5),
      ),

      contentPadding: EdgeInsets.symmetric(
        horizontal: context.spacingM,
        vertical: context.spacingXS,),
    );
  }
}