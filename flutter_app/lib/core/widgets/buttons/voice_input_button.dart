import 'package:Krishivani/core/constants/assets_paths.dart';
import 'package:Krishivani/core/extensions/context_extensions.dart';
import 'package:Krishivani/core/widgets/buttons/app_outline_button.dart';
import 'package:flutter/material.dart';
import '../../constants/app_colors.dart';

class VoiceInputButton extends StatelessWidget {
  const VoiceInputButton({
    super.key,
    required this.onPressed,
    this.text = 'Ask Vanni using your voice',
  });

  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return AppOutlineButton(
      text: text,
      onPressed: onPressed,
      width: double.infinity,
      height: context.scaleH(58),
      icon: Icon(
        AssetPaths.logo_light as IconData?,
        color: AppColors.main,
        size: context.spacingL,
      ),
    );
  }
}