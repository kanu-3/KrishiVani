import 'package:Krishivani/core/widgets/buttons/app_outline_button.dart';
import 'package:flutter/material.dart';

class DiagnosisResultOverlay extends StatelessWidget {
  const DiagnosisResultOverlay({
    super.key,
    required this.disease,
    required this.confidence,
    required this.onContinue,
  });

  final String disease;
  final double confidence;
  final VoidCallback onContinue;

  @override
  Widget build(BuildContext context) {
    final percentage = confidence * 100;

    return Positioned(
      left: 20,
      right: 20,
      bottom: 30,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.25),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Results',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 16),

            Text(
              'Plant detected :',
              style: Theme.of(context).textTheme.bodyMedium,
            ),

            const SizedBox(height: 4),

            Text(
              disease,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 12),

            Text(
              'Confidence :',
              style: Theme.of(context).textTheme.bodyMedium,
            ),

            const SizedBox(height: 4),

            Text(
              '${percentage.toStringAsFixed(2)}%',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),

            const SizedBox(height: 20),

            AppOutlineButton(
              text: 'Continue to Chat',
              onPressed: onContinue,
            ),
          ],
        ),
      ),
    );
  }
}