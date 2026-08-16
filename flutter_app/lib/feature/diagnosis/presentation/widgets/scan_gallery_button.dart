import 'package:Krishivani/core/constants/assets_paths.dart';
import 'package:Krishivani/core/extensions/context_extensions.dart';
import 'package:Krishivani/core/widgets/buttons/app_icon_button.dart';
import 'package:flutter/material.dart';

class ScanGalleryButton extends StatelessWidget {
  const ScanGalleryButton({
    super.key,
    required this.onPressed,
    this.isLoading = false,
  });

  final VoidCallback? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return AppIconButton(
      width: context.scale(56),
      height: context.scale(56),
      onPressed: isLoading ? null : onPressed,
      icon: Icon(
        AssetPaths.gallery,
        color: Colors.white,
        size: context.scale(26),
      ),
    );
  }
}