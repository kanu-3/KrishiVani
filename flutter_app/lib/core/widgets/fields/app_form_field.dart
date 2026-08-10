import 'package:Krishivani/core/constants/assets_paths.dart';
import 'package:Krishivani/core/extensions/context_extensions.dart';
import 'package:Krishivani/core/theme/custom_themes/app_form_field_theme.dart';
import 'package:flutter/material.dart';

class AppFormField extends StatefulWidget {
  final String? labelText;
  final String hintText;
  final double? height;
  final double? width;
  final Widget? icon;
  final String? Function(String?)? validator;
  final bool isPassword;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onFieldSubmitted;

  const AppFormField({
    super.key,
    this.labelText,
    required this.hintText,
    this.icon,
    this.height,
    this.width,
    this.validator,
    this.isPassword = false,
    this.controller,
    this.keyboardType,
    this.textInputAction,
    this.onFieldSubmitted,
  });

  @override
  State<AppFormField> createState() => _AppFormFieldState();
}

class _AppFormFieldState extends State<AppFormField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).brightness == Brightness.dark
        ? AppFormFieldTheme.dark(context)
        : AppFormFieldTheme.light(context);

    return SizedBox(
      height: widget.height ?? context.inputFieldHeight,
      width: widget.width ?? double.infinity,
      child: TextFormField(
        controller: widget.controller,
        validator: widget.validator,
        keyboardType: widget.keyboardType,
        textInputAction: widget.textInputAction,
        obscureText: widget.isPassword ? _obscureText : false,
        decoration: InputDecoration()
            .applyDefaults(theme)
            .copyWith(
          prefixIcon: widget.icon != null
              ? Padding(
            padding: EdgeInsets.all(context.spacingXS),
            child: widget.icon,
          )
              : null,
          labelText: widget.labelText,
          hintText: widget.hintText,
          suffixIcon: widget.isPassword
              ? IconButton(
            icon: Icon(
              _obscureText
                  ? AssetPaths.eye_close
                  : AssetPaths.eye_visible,
            ),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          )
              : null,
        ),
        onFieldSubmitted: widget.onFieldSubmitted,
      ),
    );
  }
}