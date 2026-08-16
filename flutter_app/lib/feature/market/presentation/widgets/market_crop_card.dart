import 'package:Krishivani/core/constants/assets_paths.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/core_colors.dart';
import '../../../../core/extensions/context_extensions.dart';

class MarketCropCard extends StatelessWidget {
  const MarketCropCard({
    super.key,
    required this.cropName,
    required this.wholesalePrice,
    required this.retailPrice,
    required this.image,
    this.onTap,
  });

  final String cropName;
  final String wholesalePrice;
  final String retailPrice;
  final Widget image;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: CoreColors.white,
      borderRadius: context.borderRadiusM,
      child: InkWell(
        onTap: onTap,
        borderRadius: context.borderRadiusM,
        child: SizedBox(
          height: context.scaleH(152),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.only(
                  topLeft: context.borderRadiusM.topLeft,
                  bottomLeft: context.borderRadiusM.bottomLeft,
                ),
                child: SizedBox(
                  width: context.scaleW(100),
                  height: double.infinity,
                  child: image,
                ),
              ),

              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.spacingM,
                    vertical: context.spacingS,
                  ),
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    mainAxisAlignment:
                    MainAxisAlignment.center,
                    children: [
                      Text(
                        cropName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(
                          color: AppColors.blacktext,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      SizedBox(
                        height: context.spacingXS,
                      ),

                      Text(
                        wholesalePrice,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(
                          color: AppColors.blacktext,
                        ),
                      ),

                      Text(
                        retailPrice,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .bodySmall
                            ?.copyWith(
                          color: AppColors.blacktext
                              .withOpacity(0.6),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Padding(
                padding: EdgeInsets.only(
                  right: context.spacingM,
                ),
                child: Icon(
                  AssetPaths.forward,
                  size: context.scale(18),
                  color: AppColors.blacktext
                      .withOpacity(0.6),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}