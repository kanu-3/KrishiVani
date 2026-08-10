import 'package:Krishivani/core/constants/app_colors.dart';
import 'package:flutter/material.dart';

class ModelPermissionTile extends StatelessWidget {
  const ModelPermissionTile({
    super.key,
    required this.title,
    required this.value,
    required this.onChanged,
  });

  final String title;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(
              color: AppColors.blacktext,
            ),
          ),
        ),

        Switch(
          value: value,
          activeColor: AppColors.main,
          onChanged: onChanged,
        ),
      ],
    );
  }
}