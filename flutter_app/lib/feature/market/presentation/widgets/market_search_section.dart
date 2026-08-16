import 'package:Krishivani/core/widgets/navigation/app_search_bar.dart';
import 'package:flutter/material.dart';

class MarketSearchSection extends StatelessWidget {
  const MarketSearchSection({
    super.key,
    required this.controller,
    this.onChanged,
  });

  final TextEditingController controller;
  final ValueChanged<String>? onChanged;

  @override
  Widget build(BuildContext context) {
    return AppSearchBar(
      controller: controller,
      hintText: 'Search trends',
      onChanged: onChanged,
    );
  }
}