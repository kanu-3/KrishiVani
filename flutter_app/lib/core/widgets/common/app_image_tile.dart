import 'package:Krishivani/core/constants/app_colors.dart';
import 'package:Krishivani/core/constants/core_colors.dart';
import 'package:Krishivani/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class AppImageTitleCard extends StatelessWidget {
  const AppImageTitleCard({
    super.key,
    required this.image,
    required this.title,
    this.width,
    this.height,
    this.onTap,
  });

  final Widget image;
  final String title;
  final double? width;
  final double? height;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: InkWell(
        onTap: onTap,
        borderRadius: context.borderRadiusM,
        child: ClipRRect(
          borderRadius: context.borderRadiusM,
          child: Column(
            children: [
              Expanded(
                child: image,
              ),

              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: context.spacingS,
                  vertical: context.spacingS,
                ),
                color: CoreColors.white,
                child: Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.blacktext,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}