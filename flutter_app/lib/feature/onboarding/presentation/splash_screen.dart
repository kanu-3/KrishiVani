import 'package:Krishivani/app/router/route_paths.dart';
import 'package:Krishivani/core/constants/assets_paths.dart';
import 'package:Krishivani/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {});
    });
    Future.delayed(const Duration(seconds: 5), () {
      context.go(RoutePaths.onboard);
    });
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final logo = brightness == Brightness.dark
        ? AssetPaths.main_logo_dark
        : AssetPaths.main_logo_light;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(logo, width: context.scale(300), height: context.scale(110),),
            SizedBox(
              height: context.scale(76),
            ),
          ],
        ),
      ),
    );
  }
}

