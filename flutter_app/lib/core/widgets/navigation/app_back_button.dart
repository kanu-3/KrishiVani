import 'package:Krishivani/core/constants/app_colors.dart';
import 'package:Krishivani/core/constants/assets_paths.dart';
import 'package:Krishivani/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({
    super.key,
    this.onPressed,
    this.icon,
  });

  final VoidCallback? onPressed;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.scale(28),
      height: context.scale(28),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: onPressed ?? () => Navigator.pop(context),
          child: Center(
            child: Icon(
              icon ?? AssetPaths.back,
              color: AppColors.whitetext,
              size: context.scaleH(28),
            ),
          ),
        ),
      ),
    );
  }
}