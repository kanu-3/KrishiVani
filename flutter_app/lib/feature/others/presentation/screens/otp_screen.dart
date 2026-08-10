import 'package:Krishivani/core/constants/assets_paths.dart';
import 'package:Krishivani/core/extensions/context_extensions.dart';
import 'package:Krishivani/core/widgets/app_logo.dart';
import 'package:Krishivani/core/widgets/buttons/app_elevated_button.dart';
import 'package:Krishivani/core/widgets/buttons/app_icon_button.dart';
import 'package:Krishivani/core/widgets/fields/inline_ink_text.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  final List<TextEditingController> _controllers =
  List.generate(4, (index) => TextEditingController());

  void _verifyOTP() {
    String otp = _controllers.map((c) => c.text).join();
    print("Entered OTP: $otp");
    context.go('/resetPassword');
  }
  void _resendOTP() {
    print("Resend OTP tapped");
    context.go('/forgetPassword');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: context.spacingS, vertical: context.spacingV),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppIconButton(
                icon: Icon(AssetPaths.back),
                onPressed: () => context.go('/forgetPassword'),
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
                "Enter OTP",
                style: theme.titleLarge,
              ),
              context.gapXXS,
              Text(
                "Enter the OTP received on your mail.",
                style: theme.bodyLarge,
              ),
              SizedBox(height: context.scale(62)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  4,
                      (index) => SizedBox(
                    width: context.scale(66),
                    child: TextField(
                      controller: _controllers[index],
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      style: theme.titleLarge,
                      decoration: InputDecoration(
                        counterText: '',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty && index < 3) {
                          FocusScope.of(context).nextFocus();
                        }
                        if (value.isEmpty && index > 0) {
                          FocusScope.of(context).previousFocus();
                        }
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(height: context.spacingXL),
              AppElevatedButton(
                text: "Verify",
                onPressed: _verifyOTP,
              ),
              SizedBox(height: context.spacingM),
              Center(
                child: InlineLinkText(
                  normalText: "Didn't receive the code? ",
                  boldText: "Resend OTP",
                  onTap: () {
                    _resendOTP();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

