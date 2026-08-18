import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../extensions/context_extensions.dart';

class AppOutlineButton extends StatelessWidget {
  const AppOutlineButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
    this.width,
    this.height,
    this.borderRadius,
  });

  final String text;
  final VoidCallback onPressed;
  final Widget? icon;
  final bool isLoading;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? context.buttonHeight,
      child: OutlinedButton(
        onPressed: isLoading ? null : onPressed,
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.symmetric(
            horizontal: context.spacingM,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: borderRadius ?? context.borderRadiusM,
          ),
        ),
        child: isLoading
            ? SizedBox(
          height: context.spacingM,
          width: context.spacingM,
          child: const CircularProgressIndicator(
            strokeWidth: 2,
          ),
        )
            : Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              icon!,
              SizedBox(width: context.spacingXS),
            ],
            Flexible(
              child: Text(
                text,
                style: const TextStyle(
                  height: 1.1,
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}