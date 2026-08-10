import 'package:Krishivani/core/constants/app_colors.dart';
import 'package:Krishivani/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class ModelSettingsSection extends StatelessWidget {
  const ModelSettingsSection({
    super.key,
    required this.title,
    required this.child,
  });

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(
            color: AppColors.blacktext,
            fontWeight: FontWeight.w700,
          ),
        ),

        SizedBox(height: context.spacingS),

        Container(
          width: double.infinity,
          padding: EdgeInsets.all(context.spacingM),
          decoration: BoxDecoration(
            color: AppColors.whitetext,
            borderRadius: context.borderRadiusM,
          ),
          child: child,
        ),
      ],
    );
  }
}