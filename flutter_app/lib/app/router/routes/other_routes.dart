import 'package:Krishivani/app/router/route_paths.dart';
import 'package:Krishivani/feature/diagnosis/presentation/screens/diagnosis_history_screen.dart';
import 'package:Krishivani/feature/profile/presentation/screens/model_settings_screen.dart';
import 'package:Krishivani/feature/profile/presentation/screens/my_profile_screen.dart';
import 'package:Krishivani/feature/profile/presentation/screens/profile_screen.dart';
import 'package:go_router/go_router.dart';

class OtherRoutes {
  static final List<GoRoute> routes = [
    GoRoute(
      path: RoutePaths.profile,
      name: 'profile',
      builder: (_, __) => const ProfileScreen(),
    ),

    GoRoute(
      path: RoutePaths.myProfile,
      name: 'myProfile',
      builder: (_, __) => const MyProfileScreen(),
    ),

    GoRoute(
      path: RoutePaths.modelSettings,
      name: 'modelSettings',
      builder: (_, __) => const ModelSettingsScreen(),
    ),

    GoRoute(
      path: RoutePaths.history,
      name: 'history',
      builder: (context, state) {
        return const DiagnosisHistoryScreen();
      },
    ),


  ];
}