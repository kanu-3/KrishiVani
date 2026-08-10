import 'package:Krishivani/core/constants/app_colors.dart';
import 'package:Krishivani/core/constants/assets_paths.dart';
import 'package:Krishivani/core/extensions/context_extensions.dart';
import 'package:Krishivani/core/widgets/common/app_network_image.dart';
import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
    required this.name,
    this.avatarUrl,
    this.onProfileTap,
    this.onNotificationTap,
  });

  final String name;
  final String? avatarUrl;
  final VoidCallback? onProfileTap;
  final VoidCallback? onNotificationTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: onProfileTap,
          child: AppNetworkImage(
            imageUrl: avatarUrl ?? '',
            width: context.scaleW(48),
            height: context.scaleW(48),
            borderRadius: BorderRadius.circular(100),
          ),
        ),

        SizedBox(width: context.spacingS),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome back',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.blacktext.withOpacity(0.6),
                ),
              ),

              SizedBox(height: context.spacingXS),

              Text(
                name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.blacktext,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),

        IconButton(
          onPressed: onNotificationTap,
          icon: Icon(
            AssetPaths.bell,
            color: AppColors.blacktext,
            size: context.spacingL,
          ),
        ),
      ],
    );
  }
}