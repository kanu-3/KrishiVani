import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../constants/assets_paths.dart';

class AppLogo extends StatelessWidget {
  final double width;
  final double height;

  const AppLogo({
    super.key,
    this.width = 240,
    this.height = 80,
  });

  @override
  Widget build(BuildContext context) {

    final logoAsset = Theme.of(context).brightness == Brightness.dark
        ? AssetPaths.logo_dark
        : AssetPaths.logo_light;

    return Image.asset(
      logoAsset,
      width: width,
      height: height,
    );
  }
}


