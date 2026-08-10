import 'package:Krishivani/core/constants/assets_paths.dart';
import 'package:Krishivani/core/constants/core_colors.dart';
import 'package:Krishivani/core/extensions/context_extensions.dart';
import 'package:Krishivani/core/theme/custom_themes/text_theme.dart';
import 'package:Krishivani/core/utils/app_snackbar.dart';
import 'package:Krishivani/core/widgets/buttons/app_elevated_button.dart';
import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class ProfileEditOverlay extends StatefulWidget {
  final String title;
  final String initialValue;
  final String column;

  final Future<bool> Function({
  required String column,
  required dynamic value,
  }) onSave;

  const ProfileEditOverlay({
    super.key,
    required this.title,
    required this.initialValue,
    required this.column,
    required this.onSave,
  });

  static void show(
      BuildContext context, {
        required String title,
        required String initialValue,
        required String column,
        required Future<bool> Function({
        required String column,
        required dynamic value,
        }) onSave,
      }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return ProfileEditOverlay(
          title: title,
          initialValue: initialValue,
          column: column,
          onSave: onSave,
        );
      },
    );
  }

  @override
  State<ProfileEditOverlay> createState() =>
      _ProfileEditOverlayState();
}

class _ProfileEditOverlayState extends State<ProfileEditOverlay> {
  late final TextEditingController _controller;

  bool _isSaving = false;

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController(
      text: widget.initialValue,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final value = _controller.text.trim();

    if (value.isEmpty) {
      AppSnackBar.show(
        context,
        message: '${widget.title} cannot be empty.',
      );
      return;
    }

    setState(() {
      _isSaving = true;
    });

    final success = await widget.onSave(
      column: widget.column,
      value: value,
    );

    if (!mounted) return;

    setState(() {
      _isSaving = false;
    });

    if (success) {
      Navigator.pop(context);
    } else {
      AppSnackBar.show(
        context,
        message: 'Failed to update ${widget.title.toLowerCase()}.',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset =
        MediaQuery.of(context).viewInsets.bottom;

    return Container(
      padding: EdgeInsets.fromLTRB(
        context.spacingL,
        context.spacingL,
        context.spacingL,
        bottomInset + context.spacingL,
      ),
      decoration: const BoxDecoration(
        color: AppColors.whitetext,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Edit ${widget.title}',
                  style: AppTextTheme.textTheme.titleLarge?.copyWith(
                    color: AppColors.blacktext,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              if (_controller.text.isNotEmpty)
                IconButton(
                  onPressed: () {
                    _controller.clear();
                    setState(() {});
                  },
                  icon: Icon(
                    AssetPaths.cross,
                    color: AppColors.blacktext,
                    size: context.scaleH(20),
                  ),
                ),
            ],
          ),

          SizedBox(height: context.spacingM),

          TextField(
            controller: _controller,
            autofocus: true,
            style: TextStyle(
              color: AppColors.blacktext,
            ),
            decoration: InputDecoration(
              hintText:
              'Enter your ${widget.title.toLowerCase()}',
              filled: true,
              fillColor: CoreColors.grey200,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: AppColors.main,
                  width: 1.5,
                ),
              ),
            ),
            onChanged: (_) {
              setState(() {});
            },
          ),

          SizedBox(height: context.spacingL),

          AppElevatedButton(
            width: double.infinity,
            height: context.scaleH(58),
            text: 'Save Changes',
            isLoading: _isSaving,
            onPressed: _save,
          ),
        ],
      ),
    );
  }
}