import 'package:Krishivani/core/constants/assets_paths.dart';
import 'package:Krishivani/core/extensions/context_extensions.dart';
import 'package:Krishivani/core/widgets/app_logo.dart';
import 'package:Krishivani/core/widgets/buttons/app_elevated_button.dart';
import 'package:Krishivani/core/widgets/buttons/app_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/widgets/fields/app_form_field.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();

  void _sendOtp() {
    context.go('/otp');
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
                    onPressed: () => context.go('/login'),
                ),
                context.gapS,
                Center(
                  child: AppLogo(
                    height: context.spacingXXL,
                    width: context.logoWidth,
                  ),
                ),
                SizedBox(height: context.scale(116),),
                Text(
                  "Restore Password",
                  style: theme.titleLarge,
                ),
                context.gapXXS,
                Text(
                  "Enter the email address provided upon the time of registration.",
                  style: theme.bodyLarge,
                ),
                SizedBox(height: context.inputFieldHeight,),
                AppFormField(
                  controller: _emailController,
                  labelText: "Enter email",
                  hintText: "kanu@gmail.com",
                  icon: Icon( AssetPaths.mail),
                  isPassword: false,
                ),
                SizedBox(height: context.spacingXL),
                AppElevatedButton(
                  text: "Send OTP",
                  onPressed: _sendOtp,
                ),
              ],
            ),
          )
      ),
    );
  }
}
