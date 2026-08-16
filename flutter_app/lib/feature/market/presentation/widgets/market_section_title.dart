import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/extensions/context_extensions.dart';

class MarketSectionTitle extends StatelessWidget {
  const MarketSectionTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: context.spacingS,
      ),
      child: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .titleSmall
            ?.copyWith(
          color: AppColors.blacktext,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}