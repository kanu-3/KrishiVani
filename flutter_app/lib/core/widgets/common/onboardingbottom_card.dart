import 'dart:ui';
import 'package:Krishivani/core/extensions/context_extensions.dart';
import 'package:Krishivani/core/theme/custom_themes/onboarding_card_theme.dart';
import 'package:Krishivani/core/widgets/buttons/app_elevated_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OnboardingBottomCard extends StatelessWidget {
  final String title;
  final String subTitle;
  final int index;
  final int total;
  final VoidCallback next;
  final OnboardingBottomCardStyle? style;

  const OnboardingBottomCard({
    super.key,
    required this.title,
    required this.subTitle,
    required this.index,
    required this.total,
    required this.next,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final theme = style ??
        (Theme.of(context).brightness == Brightness.dark
            ? OnboardingBottomCardTheme.dark(context)
            : OnboardingBottomCardTheme.light(context));

    return Container(
      width: context.screenWidth,
      height: context.scale(360),
      padding: theme.padding,
      decoration: BoxDecoration(
        color: theme.bg_color,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(theme.borderRadius),
          topRight: Radius.circular(theme.borderRadius),
        ),
        boxShadow: theme.boxShadow,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(subTitle,
                style: theme.titleStyle,
                textAlign: TextAlign.center, ),
            SizedBox(height: context.spacingXS),
            Text(subTitle,
                style: theme.subTitleStyle,
                textAlign: TextAlign.center,),
            SizedBox(height: context.spacingS),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(total, (i) => _dot(i == index, theme, context)),
            ),
            SizedBox(height: context.spacingL),
            // SizedBox(height: context.spacingL),
            SizedBox(
              width: double.infinity,
              child: AppElevatedButton(
                text: index == total - 1 ? "Get Started" : "Next",
                onPressed: next,
              ),
            ),
          ],
        ),);
  }
}
Widget _dot(bool active, OnboardingBottomCardStyle theme, BuildContext context) {
  return Container(
    margin: EdgeInsets.symmetric(horizontal: context.spacingXS * 0.3),
    width: active ? theme.dotActiveSize : theme.dotInactiveSize,
    height: active ? theme.dotActiveSize : theme.dotInactiveSize,
    decoration: BoxDecoration(
      color: active ? theme.dotActiveColor : theme.dotInactiveColor,
      shape: BoxShape.circle,
    ),
  );
}


