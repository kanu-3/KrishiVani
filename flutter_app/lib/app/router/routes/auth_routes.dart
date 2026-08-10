import 'package:Krishivani/app/router/route_paths.dart';
import 'package:Krishivani/feature/auth/presentation/screens/signup_screen.dart';
import 'package:Krishivani/feature/others/presentation/screens/forgetpassword_screen.dart';
import 'package:Krishivani/feature/others/presentation/screens/otp_screen.dart';
import 'package:Krishivani/feature/others/presentation/screens/resetpassword_screen.dart';
import 'package:go_router/go_router.dart';
import '../../../feature/auth/presentation/screens/login_screen.dart';

class AuthRoutes {
  static final List<GoRoute> routes = [
    GoRoute(
      path: RoutePaths.login,
      name: 'login',
      builder: (_, __) => const LoginScreen(),
    ),

    GoRoute(
      path: RoutePaths.signup,
      name: 'signup',
      builder: (_, __) => const SignupScreen(),
    ),

    GoRoute(
      path: RoutePaths.forgetPassword,
      name: 'forgetPassword',
      builder: (_, __) => const ForgetPasswordScreen(),
    ),

    GoRoute(
      path: RoutePaths.resetPassword,
      name: 'resetPassword',
      builder: (_, __) => const ResetPasswordScreen(),
    ),

    GoRoute(
      path: RoutePaths.otp,
      name: 'otp',
      builder: (_, __) => const OTPScreen(),
    ),
  ];
}