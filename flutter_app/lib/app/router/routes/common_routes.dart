import 'package:Krishivani/app/router/route_paths.dart';
import 'package:Krishivani/feature/onboarding/presentation/onboarding_screen.dart';
import 'package:Krishivani/feature/onboarding/presentation/splash_screen.dart';
import 'package:go_router/go_router.dart';

class CommonRoutes {
  static final List<GoRoute> routes = [
    GoRoute(
      path: RoutePaths.splash,
      name: 'splash',
      builder: (_, __) => const SplashScreen(),
    ),

    GoRoute(
      path: RoutePaths.onboard,
      name: 'onboarding',
      builder: (_, __) => const OnboardingScreen(),
    ),
  ];
}