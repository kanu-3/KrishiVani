import 'package:Krishivani/core/constants/app_colors.dart';
import 'package:Krishivani/core/constants/assets_paths.dart';
import 'package:Krishivani/core/constants/core_colors.dart';
import 'package:Krishivani/core/extensions/context_extensions.dart';
import 'package:Krishivani/core/widgets/buttons/app_elevated_button.dart';
import 'package:flutter/material.dart';

class ModelSettingsHeader extends StatelessWidget {
  const ModelSettingsHeader({
    super.key,
    required this.onChangeModel,
  });

  final VoidCallback onChangeModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Image(
            image: AssetImage(AssetPaths.model,),
            width: context.scaleW(100),
            height: context.scaleW(100),
            fit: BoxFit.contain,
          ),
        ),

        SizedBox(height: context.spacingS),

        Text(
          'Vanni AI',
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(
            color: AppColors.blacktext,
            fontWeight: FontWeight.w700,
          ),
        ),

        SizedBox(height: context.spacingXXS),

        Text(
          'Version: 2.3.0',
          style: Theme.of(context)
              .textTheme
              .bodySmall
              ?.copyWith(
            color: CoreColors.grey700,
          ),
        ),

        SizedBox(height: context.spacingS),

        SizedBox(
          // width: context.scaleW(180),
          child: AppElevatedButton(
            height: context.scaleH(56),
            text: 'Change model',
            onPressed: onChangeModel,
          ),
        ),
      ],
    );
  }
}