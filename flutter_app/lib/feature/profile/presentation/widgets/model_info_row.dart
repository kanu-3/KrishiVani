import 'package:Krishivani/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class ModelInfoRow extends StatelessWidget {
  const ModelInfoRow({
    super.key,
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '$label: ',
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(
              color: AppColors.blacktext,
              fontWeight: FontWeight.w600,
            ),
          ),
          TextSpan(
            text: value,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(
              color: AppColors.blacktext,
            ),
          ),
        ],
      ),
    );
  }
}