import 'package:Krishivani/core/constants/app_colors.dart';
import 'package:Krishivani/core/constants/core_colors.dart';
import 'package:Krishivani/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class HomeSearchBar extends StatelessWidget {
  const HomeSearchBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.scaleH(54),
      padding: EdgeInsets.symmetric(
        horizontal: context.spacingM,
      ),
      decoration: BoxDecoration(
        color: AppColors.whitetext,
        borderRadius: context.borderRadiusM,
      ),
      child: Row(
        children: [
          Icon(
            Icons.search,
            color: CoreColors.grey600,
          ),

          SizedBox(width: context.spacingS),

          Expanded(
            child: Text(
              'Search plants, diseases, markets...',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(
                color: CoreColors.grey600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}