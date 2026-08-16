import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/core_colors.dart';
import '../../../../core/extensions/context_extensions.dart';

class MarketResultActions extends StatelessWidget {
  const MarketResultActions({
    super.key,
    required this.onSave,
    required this.onRegenerate,
    required this.isRegenerating,
  });

  final VoidCallback onSave;
  final VoidCallback onRegenerate;
  final bool isRegenerating;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed:
            isRegenerating ? null : onSave,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.main,
              foregroundColor:
              CoreColors.white,
              padding: EdgeInsets.symmetric(
                vertical: context.spacingM,
              ),
              shape: RoundedRectangleBorder(
                borderRadius:
                context.borderRadiusM,
              ),
            ),
            child: const Text(
              'Save',
            ),
          ),
        ),

        SizedBox(
          height: context.spacingS,
        ),

        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: isRegenerating
                ? null
                : onRegenerate,
            style: OutlinedButton.styleFrom(
              foregroundColor:
              AppColors.main,
              padding: EdgeInsets.symmetric(
                vertical: context.spacingM,
              ),
              shape: RoundedRectangleBorder(
                borderRadius:
                context.borderRadiusM,
              ),
              side: BorderSide(
                color: AppColors.main,
              ),
            ),
            child: isRegenerating
                ? SizedBox(
              height: context.scale(20),
              width: context.scale(20),
              child:
              CircularProgressIndicator(
                strokeWidth: 2,
                color: AppColors.main,
              ),
            )
                : const Text(
              'Regenerate',
            ),
          ),
        ),
      ],
    );
  }
}