import 'package:Krishivani/core/constants/assets_paths.dart';
import 'package:Krishivani/core/extensions/context_extensions.dart';
import 'package:Krishivani/core/widgets/app_logo.dart';
import 'package:Krishivani/core/widgets/buttons/app_elevated_button.dart';
import 'package:Krishivani/core/widgets/buttons/app_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/fields/app_form_field.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _confirmPasswordController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _resetPassword() {
    context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: context.spacingS, vertical: context.spacingV),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppIconButton(
                  icon: Icon(AssetPaths.back),
                  onPressed: ()=> context.go('/otpScreen'),
              ),
              context.gapS,
              Center(
                child: AppLogo(
                  height: context.spacingXXL,
                  width: context.logoWidth,
                ),
              ),
              SizedBox(height: context.scale(100),),
              Text(
                "Reset Password",
                style: theme.titleLarge,
              ),
              context.gapXXS,
              Text(
                "Enter a valid password",
                style: theme.bodyLarge,
              ),
              context.gapM,
              AppFormField(
                controller: _passwordController,
                labelText: "Enter new password",
                hintText: " ",
                icon: Icon( AssetPaths.mail),
                isPassword: false,
              ),
              SizedBox(height: context.spacingM),
              AppFormField(
                controller: _confirmPasswordController,
                labelText: "Confirm password",
                hintText: " ",
                icon: Icon( AssetPaths.lock),
                isPassword: true,
              ),
              SizedBox(height: context.spacingXL),
              AppElevatedButton(
                text: "Submit",
                onPressed: _resetPassword,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
