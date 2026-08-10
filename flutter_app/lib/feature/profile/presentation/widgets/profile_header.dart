import 'package:Krishivani/core/constants/app_colors.dart';
import 'package:Krishivani/core/extensions/context_extensions.dart';
import 'package:Krishivani/core/widgets/buttons/app_outline_button.dart';
import 'package:Krishivani/core/widgets/common/app_network_image.dart';
import 'package:Krishivani/feature/profile/data/models/profile_model.dart';
import 'package:flutter/material.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
    required this.profile,
    required this.onEdit,
  });

  final ProfileModel profile;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipOval(
          child: AppNetworkImage(
            imageUrl: profile.avatarUrl ?? '',
            width: context.scaleW(64),
            height: context.scaleW(64),
          ),
        ),

        SizedBox(width: context.spacingXS),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                profile.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: AppColors.blacktext,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: context.spacingXXS),
              Text(
                '@${profile.username}',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: AppColors.blacktext.withOpacity(0.6),
                ),
              ),
            ],
          ),
        ),

        SizedBox(width: context.spacingS),

        AppOutlineButton(
          text: 'Edit',
          width: context.scaleW(84),
          height: context.scaleH(56),
          onPressed: onEdit,
        ),
      ],
    );
  }
}