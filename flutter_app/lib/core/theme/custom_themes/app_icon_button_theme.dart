import 'package:Krishivani/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class AppIconButtonTheme {
  AppIconButtonTheme._();

  static Color iconColorLight = AppColors.blacktext;
  static Color iconColorDark = AppColors.whitetext;

  static Color rippleColorLight = AppColors.blacktext.withOpacity(0.1);
  static Color rippleColorDark = AppColors.whitetext.withOpacity(0.1);

  static Color getIconColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? iconColorDark
        : iconColorLight;
  }

  static Color getRippleColor(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark
        ? rippleColorDark
        : rippleColorLight;
  }
}
