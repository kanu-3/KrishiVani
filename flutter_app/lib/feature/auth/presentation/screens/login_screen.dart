import 'package:Krishivani/core/constants/app_colors.dart';
import 'package:Krishivani/core/constants/assets_paths.dart';
import 'package:Krishivani/core/extensions/context_extensions.dart';
import 'package:Krishivani/core/utils/app_snackbar.dart';
import 'package:Krishivani/core/utils/validators.dart';
import 'package:Krishivani/core/widgets/app_logo.dart';
import 'package:Krishivani/core/widgets/buttons/app_elevated_button.dart';
import 'package:Krishivani/core/widgets/buttons/app_icon_button.dart';
import 'package:Krishivani/core/widgets/buttons/toggle_button.dart';
import 'package:Krishivani/core/widgets/fields/app_form_field.dart';
import 'package:Krishivani/core/widgets/fields/inline_ink_text.dart';
import 'package:Krishivani/feature/auth/providers/auth_provider.dart';
import 'package:Krishivani/feature/auth/providers/auth_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() =>
      _LoginScreenState();
}

class _LoginScreenState
    extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController =
  TextEditingController();

  final TextEditingController
  _passwordController =
  TextEditingController();

  bool isChecked = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      return;
    }

    await ref
        .read(authNotifierProvider.notifier)
        .login(
      email: _emailController.text.trim(),
      password:
      _passwordController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    final authState =
    ref.watch(authNotifierProvider);

    ref.listen<AuthState>(
      authNotifierProvider,
          (previous, next) {
        if (next.user != null) {
          AppSnackBar.show(
            context,
            message: "Welcome back!",
          );

          context.go("/home");
        }

        if (next.errorMessage != null) {
          AppSnackBar.show(
            context,
            message: next.errorMessage!,
            isError: true,
          );
        }
      },
    );

    return Scaffold(
        body: SafeArea(
            child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: context.spacingS,
                  vertical: context.spacingV,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                    Row(
                    mainAxisAlignment:
                    MainAxisAlignment
                    .spaceBetween,
                    children: [
                      AppIconButton(
                        icon: Icon(
                          AssetPaths.back,
                        ),
                        onPressed: () =>
                            context.go(
                                "/onboard"),
                      ),
                      ThemeToggleButton(),
                    ],
                  ),

                  context.gapS,

                  Center(
                    child: AppLogo(
                      height:
                      context.spacingXXL,
                      width:
                      context.logoWidth,
                    ),
                  ),

                  SizedBox(
                    height:
                    context.scale(100),
                  ),

                  Text(
                    "Welcome Back!",
                    style: theme.titleLarge,
                  ),

                  context.gapXXS,

                  Text(
                    "Log In to continue",
                    style: theme.bodyLarge,
                  ),

                  context.gapM,

                  AppFormField(
                    controller:
                    _emailController,
                    labelText:
                    "Enter email",
                    hintText:
                    "kanu@gmail.com",
                    icon: Icon(
                      AssetPaths.mail,
                    ),
                    validator:
                    AppValidators.email,
                    keyboardType:
                    TextInputType
                        .emailAddress,
                    textInputAction:
                    TextInputAction.next,
                  ),

                  SizedBox(
                    height:
                    context.spacingM,
                  ),

                  AppFormField(
                    controller:
                    _passwordController,
                    labelText:
                    "Password",
                    hintText:
                    "Enter password",
                    icon: Icon(
                      AssetPaths.lock,
                    ),
                    isPassword: true,
                    validator:
                    AppValidators.password,
                    textInputAction:
                    TextInputAction.done,
                  ),

                  SizedBox(
                    height:
                    context.spacingXL,
                  ),

                  AppElevatedButton(
                    text: authState.isLoading
                        ? "Logging In..."
                        : "Log In",
                    onPressed:
                    authState.isLoading
                        ? null
                        : _login,
                  ),

                  context.gapXXS,
                      Row(
                        mainAxisAlignment:
                        MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: isChecked,
                                onChanged: (value) {
                                  setState(() {
                                    isChecked = value ?? false;
                                  });
                                },
                              ),

                              context.gapXXS,

                              Text(
                                "Remember me",
                                style: theme.bodyLarge,
                              ),
                            ],
                          ),

                          TextButton(
                            onPressed: () =>
                                context.go("/forgetPassword"),
                            child: Text(
                              "Forgot Password?",
                              style: theme.bodyLarge!.copyWith(
                                color: AppColors.onError,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(
                        height: context.inputFieldHeight,
                      ),

                      Center(
                        child: InlineLinkText(
                          normalText:
                          "Don't have an account? ",
                          boldText: "SIGN UP",
                          onTap: () =>
                              context.go("/signup"),
                        ),
                      ),
                    ],
                  ),
                ),
            ),
        ),
    );
  }
}