import 'package:Krishivani/app/router/routes/app_shell.dart';
import 'package:Krishivani/app/router/route_paths.dart';
import 'package:Krishivani/app/router/routes/auth_routes.dart';
import 'package:Krishivani/app/router/routes/common_routes.dart';
import 'package:Krishivani/app/router/routes/other_routes.dart';
import 'package:Krishivani/feature/chat/presentation/screens/chat_screen.dart';
import 'package:Krishivani/feature/home/presentation/screens/home_screen.dart';
import 'package:Krishivani/feature/market/presentation/screens/market_screen.dart';
import 'package:Krishivani/feature/scan/presentation/screens/scan_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return AppRouter.router;
});


class AppRouter {

  static final router = GoRouter(
    debugLogDiagnostics: kDebugMode,
    initialLocation: RoutePaths.splash,

    routes: [

      ...CommonRoutes.routes,
      ...AuthRoutes.routes,
      ...OtherRoutes.routes,

      ShellRoute(
        builder: (context, state, child) {
          return AppShell(
            child: child,
          );
        },

        routes: [

          GoRoute(
            path: RoutePaths.home,
            name: 'home',
            builder: (_, __) => const HomeScreen(),
          ),


          GoRoute(
            path: RoutePaths.scan,
            name: 'scan',
            builder: (_, __) => const ScanScreen(),
          ),


          GoRoute(
            path: RoutePaths.market,
            name: 'market',
            builder: (_, __) => const MarketScreen(),
          ),


          GoRoute(
            path: RoutePaths.chat,
            name: 'chat',
            builder: (_, __) => const ChatScreen(),
          ),
        ],
      ),
    ],
  );
}