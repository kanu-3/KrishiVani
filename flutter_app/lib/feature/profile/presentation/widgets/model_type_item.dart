import 'package:Krishivani/core/constants/app_colors.dart';
import 'package:Krishivani/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class ModelTypeItem extends StatelessWidget {
  const ModelTypeItem({
    super.key,
    required this.number,
    required this.text,
  });

  final String number;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: context.spacingXS,
      ),
      child: Text(
        '$number $text',
        style: Theme.of(context)
            .textTheme
            .bodyMedium
            ?.copyWith(
          color: AppColors.blacktext,
        ),
      ),
    );
  }
}