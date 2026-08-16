import 'package:Krishivani/core/constants/app_colors.dart';
import 'package:Krishivani/core/constants/assets_paths.dart';
import 'package:Krishivani/core/constants/core_colors.dart';
import 'package:Krishivani/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class AppSearchBar extends StatelessWidget {
  const AppSearchBar({
    super.key,
    this.hintText = 'Search',
    this.controller,
    this.onChanged,
    this.onTap,
    this.readOnly = false,
  });

  final String hintText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      readOnly: readOnly,
      onChanged: onChanged,
      onTap: onTap,
      style: TextStyle(
        color: AppColors.blacktext,
      ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(
          color: AppColors.blacktext.withOpacity(0.5),
        ),
        prefixIcon: Icon(
          AssetPaths.search,
          color: AppColors.blacktext.withOpacity(0.6),
        ),
        filled: true,
        fillColor: CoreColors.white,
        contentPadding: EdgeInsets.symmetric(
          horizontal: context.spacingS,
          vertical: context.spacingS,
        ),
        border: OutlineInputBorder(
          borderRadius: context.borderRadiusM,
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: context.borderRadiusM,
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: context.borderRadiusM,
          borderSide: BorderSide(
            color: AppColors.main,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}