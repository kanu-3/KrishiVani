import 'package:Krishivani/core/extensions/context_extensions.dart';
import 'package:Krishivani/core/theme/custom_themes/text_theme.dart';
import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';

class AppSuccessDialog extends StatelessWidget {
  const AppSuccessDialog({
    super.key,
    required this.title,
    required this.subtitle,
    required this.primaryText,
    required this.secondaryText,
    required this.onPrimaryTap,
    required this.onSecondaryTap,
  });

  final String title;
  final String subtitle;
  final String primaryText;
  final String secondaryText;
  final VoidCallback onPrimaryTap;
  final VoidCallback onSecondaryTap;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          context.spacingL,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(
          context.spacingL,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            Text(
              title,
              style: AppTextTheme
                  .textTheme
                  .headlineMedium
                  ?.copyWith(
                color: AppColors.main,
                fontWeight: FontWeight.w700,
              ),
            ),

            context.gapS,

            Text(
              subtitle,
            ),

            context.gapS,

            Image.asset(
              'assets/images/success.gif',
              height: context.scaleH(160),
            ),

            context.gapS,

            GestureDetector(
              onTap: onPrimaryTap,
              child: Text(
                primaryText,
                style: AppTextTheme
                    .textTheme
                    .headlineSmall,
              ),
            ),

            context.gapS,

            Row(
              children: [

                const Expanded(
                  child: Divider(),
                ),

                Padding(
                  padding:
                  EdgeInsets.symmetric(
                    horizontal:
                    context.spacingM,
                  ),
                  child: const Text(
                    'OR',
                  ),
                ),

                const Expanded(
                  child: Divider(),
                ),
              ],
            ),

            context.gapS,

            GestureDetector(
              onTap: onSecondaryTap,
              child: Text(
                secondaryText,
                style: AppTextTheme
                    .textTheme
                    .headlineSmall,
              ),
            ),
          ],
        ),
      ),
    );
  }
}