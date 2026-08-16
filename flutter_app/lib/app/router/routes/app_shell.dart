import 'package:Krishivani/app/router/route_paths.dart';
import 'package:Krishivani/core/constants/app_colors.dart';
import 'package:Krishivani/core/extensions/context_extensions.dart';
import 'package:Krishivani/core/widgets/navigation/app_bottom_nav.dart';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppShell extends StatefulWidget {

  final Widget child;

  const AppShell({
    super.key,
    required this.child,
  });

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  final NotchBottomBarController _controller =
  NotchBottomBarController();

  int getIndex(BuildContext context) {

    final location =
    GoRouterState.of(context).uri.toString();

    if(location.startsWith(RoutePaths.home)){
      return 0;
    }

    if(location.startsWith(RoutePaths.scan)){
      return 1;
    }

    if(location.startsWith(RoutePaths.market)){
      return 2;
    }

    if(location.startsWith(RoutePaths.chat)){
      return 3;
    }

    return 0;
  }

  @override
  void didChangeDependencies() {

    super.didChangeDependencies();
    final index = getIndex(context);
    _controller.index = index;
  }

  @override
  Widget build(BuildContext context) {
    final index = getIndex(context);

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: Column(
        children: [
          Expanded(
            child: widget.child,
          ),

          SafeArea(
            top: false,
            child: AppBottomNavbar(
              controller: _controller,
              currentIndex: index,
              onTap: (index) {
                switch (index) {
                  case 0:
                    context.go(RoutePaths.home);
                    break;
                  case 1:
                    context.go(RoutePaths.scan);
                    break;
                  case 2:
                    context.go(RoutePaths.market);
                    break;
                  case 3:
                    context.go(RoutePaths.chat);
                    break;
                }
              },
            ),
          ),

        ],
      ),
    );
  }
}
