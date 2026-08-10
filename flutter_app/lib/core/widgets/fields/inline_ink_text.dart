import 'package:Krishivani/core/theme/custom_themes/inline_ink_text_theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class InlineLinkText extends StatelessWidget {
  final String normalText;
  final String boldText;
  final VoidCallback onTap;

  const InlineLinkText({
    super.key,
    required this.normalText,
    required this.boldText,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final normalStyle = isDark
        ? InlineLinkTextTheme.darkNormal
        : InlineLinkTextTheme.lightNormal;

    final boldStyle = isDark
        ? InlineLinkTextTheme.darkBold
        : InlineLinkTextTheme.lightBold;

    return RichText(
      text: TextSpan(
        text: normalText,
        style: normalStyle,
        children: [
          TextSpan(
            text: boldText,
            style: boldStyle,
            recognizer: TapGestureRecognizer()..onTap = onTap,
          ),
        ],
      ),
    );
  }
}



