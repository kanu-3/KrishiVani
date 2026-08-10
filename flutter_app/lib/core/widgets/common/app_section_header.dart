import 'package:Krishivani/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class AppSectionHeader extends StatelessWidget {
  const AppSectionHeader({
    super.key,
    required this.title,
    this.actionText,
    this.onTap,
  });

  final String title;
  final String? actionText;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
              color: AppColors.blacktext,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),

        if (actionText != null && onTap != null)
          GestureDetector(
            onTap: onTap,
            child: Text(
              actionText!,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppColors.main,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
      ],
    );
  }
}