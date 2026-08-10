import 'package:Krishivani/core/constants/app_colors.dart';
import 'package:Krishivani/core/constants/core_colors.dart';
import 'package:Krishivani/core/extensions/context_extensions.dart';
import 'package:Krishivani/core/theme/custom_themes/text_theme.dart';
import 'package:Krishivani/core/utils/app_snackbar.dart';
import 'package:Krishivani/core/widgets/buttons/app_elevated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddressEditOverlay extends StatefulWidget {
  final String initialAddress;

  final Future<bool> Function({
  required String column,
  required dynamic value,
  }) onSave;

  const AddressEditOverlay({
    super.key,
    required this.initialAddress,
    required this.onSave,
  });

  static void show(
      BuildContext context, {
        required String initialAddress,
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
        return AddressEditOverlay(
          initialAddress: initialAddress,
          onSave: onSave,
        );
      },
    );
  }

  @override
  State<AddressEditOverlay> createState() =>
      _AddressEditOverlayState();
}

class _AddressEditOverlayState
    extends State<AddressEditOverlay> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _addressController;
  late final TextEditingController _cityController;
  late final TextEditingController _pincodeController;

  String? _selectedState;

  bool _isSaving = false;

  final List<String> _indianStates = [
    'Andhra Pradesh',
    'Arunachal Pradesh',
    'Assam',
    'Bihar',
    'Chhattisgarh',
    'Goa',
    'Gujarat',
    'Haryana',
    'Himachal Pradesh',
    'Jharkhand',
    'Karnataka',
    'Kerala',
    'Madhya Pradesh',
    'Maharashtra',
    'Manipur',
    'Meghalaya',
    'Mizoram',
    'Nagaland',
    'Odisha',
    'Punjab',
    'Rajasthan',
    'Sikkim',
    'Tamil Nadu',
    'Telangana',
    'Tripura',
    'Uttar Pradesh',
    'Uttarakhand',
    'West Bengal',
    'Delhi',
    'Jammu & Kashmir',
    'Ladakh',
  ];

  @override
  void initState() {
    super.initState();

    _addressController = TextEditingController();
    _cityController = TextEditingController();
    _pincodeController = TextEditingController();

    _parseInitialAddress();
  }

  void _parseInitialAddress() {
    if (widget.initialAddress.trim().isEmpty) {
      return;
    }

    final address = widget.initialAddress.trim();

    final pincodeMatch = RegExp(
      r'-\s*(\d{6})$',
    ).firstMatch(address);

    if (pincodeMatch != null) {
      _pincodeController.text =
      pincodeMatch.group(1)!;
    }

    final withoutPincode = address.replaceFirst(
      RegExp(r'\s*-\s*\d{6}$'),
      '',
    );

    final parts = withoutPincode
        .split(',')
        .map((value) => value.trim())
        .where((value) => value.isNotEmpty)
        .toList();

    if (parts.isNotEmpty) {
      _addressController.text = parts.first;
    }

    if (parts.length >= 2) {
      _cityController.text = parts[1];
    }

    if (parts.length >= 3) {
      final state = parts.sublist(2).join(', ');

      if (_indianStates.contains(state)) {
        _selectedState = state;
      }
    }
  }

  @override
  void dispose() {
    _addressController.dispose();
    _cityController.dispose();
    _pincodeController.dispose();

    super.dispose();
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
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
    );
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isSaving = true;
    });

    final formattedAddress = [
      _addressController.text.trim(),
      _cityController.text.trim(),
      _selectedState!,
    ].join(', ');

    final finalAddress =
        '$formattedAddress - ${_pincodeController.text.trim()}';

    final success = await widget.onSave(
      column: 'address',
      value: finalAddress,
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
        message: 'Failed to update address.',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset =
        MediaQuery.of(context).viewInsets.bottom;

    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
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
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Edit Address',
                style: AppTextTheme.textTheme.headlineMedium,
              ),

              SizedBox(height: context.spacingL),

              TextFormField(
                controller: _addressController,
                maxLines: 2,
                style: TextStyle(
                  color: AppColors.blacktext,
                ),
                decoration: _inputDecoration(
                  'Street Address / Apartment Details',
                ),
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty) {
                    return 'Required field';
                  }

                  return null;
                },
              ),

              SizedBox(height: context.spacingM),

              TextFormField(
                controller: _cityController,
                style: TextStyle(
                  color: AppColors.blacktext,
                ),
                decoration: _inputDecoration('City'),
                validator: (value) {
                  if (value == null ||
                      value.trim().isEmpty) {
                    return 'Required field';
                  }

                  return null;
                },
              ),

              SizedBox(height: context.spacingM),

              DropdownButtonFormField<String>(
                value: _selectedState,
                style: TextStyle(
                  color: AppColors.blacktext,
                ),
                dropdownColor: AppColors.whitetext,
                decoration: _inputDecoration(
                  'Select State',
                ),
                items: _indianStates.map(
                      (state) {
                    return DropdownMenuItem(
                      value: state,
                      child: Text(state),
                    );
                  },
                ).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedState = value;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'Please select a state';
                  }

                  return null;
                },
              ),

              SizedBox(height: context.spacingM),

              TextFormField(
                controller: _pincodeController,
                style: TextStyle(
                  color: AppColors.blacktext,
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(6),
                ],
                decoration: _inputDecoration(
                  'Pincode (6 digits)',
                ),
                validator: (value) {
                  if (value == null ||
                      value.length != 6) {
                    return 'Enter a valid 6-digit code';
                  }

                  return null;
                },
              ),

              SizedBox(height: context.spacingL),

              AppElevatedButton(
                width: double.infinity,
                height: context.scaleH(62),
                text: 'Save Address',
                isLoading: _isSaving,
                onPressed: _save,
              ),
            ],
          ),
        ),
      ),
    );
  }
}