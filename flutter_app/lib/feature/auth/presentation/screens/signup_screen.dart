import 'package:Krishivani/core/constants/assets_paths.dart';
import 'package:Krishivani/core/extensions/context_extensions.dart';
import 'package:Krishivani/core/theme/custom_themes/text_theme.dart';
import 'package:Krishivani/core/utils/app_snackbar.dart';
import 'package:Krishivani/core/utils/validators.dart';
import 'package:Krishivani/core/widgets/app_logo.dart';
import 'package:Krishivani/core/widgets/buttons/app_elevated_button.dart';
import 'package:Krishivani/core/widgets/buttons/app_icon_button.dart';
import 'package:Krishivani/core/widgets/fields/app_form_field.dart';
import 'package:Krishivani/core/widgets/fields/inline_ink_text.dart';
import 'package:Krishivani/feature/auth/providers/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:Krishivani/feature/auth/providers/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() =>
      _SignupScreenState();
}

class _SignupScreenState
    extends ConsumerState<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _emailController =
  TextEditingController();

  final TextEditingController _passwordController =
  TextEditingController();

  final TextEditingController
  _confirmPasswordController =
  TextEditingController();

  final TextEditingController _nameController =
  TextEditingController();

  final TextEditingController _mobileController =
  TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nameController.dispose();
    _mobileController.dispose();
    super.dispose();
  }

  Future<void> _signup() async {
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      return;
    }

    await ref
        .read(authNotifierProvider.notifier)
        .signUp(
      email: _emailController.text.trim(),
      password:
      _passwordController.text.trim(),
      username: _emailController.text
          .trim()
          .split('@')
          .first
          .toLowerCase(),
      name: _nameController.text.trim(),
      phone: _mobileController.text.trim(),
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
        if (previous?.isLoading == true &&
            next.isLoading == false &&
            next.errorMessage == null) {
          AppSnackBar.show(
            context,
            message:
            "Account created successfully. Please verify your email before logging in.",
          );

          context.go("/login");
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
                AppIconButton(
                icon: Icon(AssetPaths.back),
                onPressed: () =>
                    context.go("/login"),
              ),

              context.gapS,

              Center(
                child: AppLogo(
                  height: context.spacingXXL,
                  width: context.logoWidth,
                ),
              ),

              SizedBox(
                height: context.scale(52),
              ),

              Text(
                "Welcome",
                style: theme.titleLarge,
              ),

              context.gapXXS,

              Text(
                "Create your account",
                style: theme.bodyLarge,
              ),

              context.gapM,

              AppFormField(
                controller: _nameController,
                labelText:
                "Enter your name",
                hintText: "Kanu",
                icon:
                Icon(AssetPaths.person),
                validator:
                AppValidators.name,
                textInputAction:
                TextInputAction.next,
              ),

              SizedBox(
                height: context.spacingM,
              ),

              AppFormField(
                controller:
                _mobileController,
                labelText:
                "Enter your mobile",
                hintText:
                "+91 95xxxxx593",
                icon:
                Icon(AssetPaths.mobile),
                keyboardType:
                TextInputType.phone,
                validator:
                AppValidators.phone,
                textInputAction:
                TextInputAction.next,
              ),

              SizedBox(
                height: context.spacingM,
              ),

              AppFormField(
                controller:
                _emailController,
                labelText:
                "Enter your mail",
                hintText:
                "kanu@gmail.com",
                icon:
                Icon(AssetPaths.mail),
                keyboardType:
                TextInputType
                    .emailAddress,
                validator:
                AppValidators.email,
                textInputAction:
                TextInputAction.next,
              ),

              SizedBox(
                height: context.spacingM,
              ),

              AppFormField(
                controller:
                _passwordController,
                labelText:
                "Enter password",
                hintText:
                "********",
                icon:
                Icon(AssetPaths.lock),
                isPassword: true,
                validator: AppValidators
                    .strongPassword,
                textInputAction:
                TextInputAction.next,
              ),

              SizedBox(
                height: context.spacingM,
              ),
                      AppFormField(
                        controller: _confirmPasswordController,
                        labelText: "Confirm password",
                        hintText: "********",
                        icon: Icon(AssetPaths.lock),
                        isPassword: true,
                        validator: (value) =>
                            AppValidators.confirmPassword(
                              value,
                              _passwordController.text,
                            ),
                        textInputAction: TextInputAction.done,
                      ),

                      SizedBox(
                        height: context.spacingXL,
                      ),

                      AppElevatedButton(
                        text: authState.isLoading
                            ? "Creating Account..."
                            : "Sign Up",
                        onPressed: authState.isLoading
                            ? null
                            : _signup,
                      ),

                      SizedBox(
                        height: context.spacingXS,
                      ),

                      Text(
                        "By creating an account, you agree to the KrishiVani Conditions of Use and Privacy Policy.",
                        style: AppTextTheme
                            .textTheme.bodySmall,
                        textAlign: TextAlign.center,
                      ),

                      SizedBox(
                        height: context.spacingM,
                      ),

                      Center(
                        child: InlineLinkText(
                          normalText:
                          "Already have an account? ",
                          boldText: "LOG IN",
                          onTap: () =>
                              context.go("/login"),
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
