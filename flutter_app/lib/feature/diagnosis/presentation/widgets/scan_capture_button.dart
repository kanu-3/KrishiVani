import 'package:Krishivani/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class ScanCaptureButton extends StatelessWidget {
  const ScanCaptureButton({
    super.key,
    required this.onPressed,
    this.isLoading = false,
  });

  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onPressed,
      child: Container(
        width: context.scale(40),
        height: context.scale(40),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white,
            width: 4,
          ),
        ),
        child: Center(
          child: Container(
            width: context.scale(28),
            height: context.scale(28),
            decoration: BoxDecoration(
              color: isLoading
                  ? Colors.grey
                  : Colors.white,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}