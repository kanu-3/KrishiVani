import 'dart:typed_data';
import 'package:Krishivani/app/router/route_paths.dart';
import 'package:Krishivani/core/widgets/common/app_header.dart';
import 'package:Krishivani/feature/chat/providers/chat_provider.dart';
import 'package:Krishivani/feature/diagnosis/presentation/widgets/diagnosis_error_overlay.dart';
import 'package:Krishivani/feature/diagnosis/presentation/widgets/diagnosis_loading_overlay.dart';
import 'package:Krishivani/feature/diagnosis/presentation/widgets/diagnosis_result_overlay.dart';
import 'package:Krishivani/feature/diagnosis/presentation/widgets/scan_bottom_controls.dart';
import 'package:Krishivani/feature/diagnosis/presentation/widgets/scan_camera_view.dart';
import 'package:Krishivani/feature/diagnosis/presentation/widgets/scan_ovelay.dart';
import 'package:Krishivani/feature/diagnosis/providers/diagnosis_provider.dart';
import 'package:Krishivani/feature/diagnosis/providers/scan_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ScanScreen extends ConsumerWidget {
  const ScanScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scanController = ref.watch(
      scanControllerProvider,
    );

    final diagnosisState = ref.watch(
      diagnosisProvider,
    );

    return Scaffold(
      backgroundColor: Colors.black,

      appBar: const AppHeader(
        title: 'Scan Plant',
        showBackButton: false,
      ),

      body: Stack(
        fit: StackFit.expand,
        children: [
          if (diagnosisState.imageBytes != null)
            Image.memory(
              diagnosisState.imageBytes!,
              fit: BoxFit.cover,
            )
          else if (scanController.cameraController != null &&
              scanController.cameraController!.value.isInitialized)
            ScanCameraView(
              controller: scanController.cameraController!,
            )
          else if (scanController.cameraLoading)
              const Center(
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              )
            else
              Center(
                child: Text(
                  scanController.cameraError ??
                      'Unable to initialize camera.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),

          if (diagnosisState.diagnosis == null &&
              diagnosisState.imageBytes == null)
            const ScanOverlay(),

          if (diagnosisState.isLoading)
            const DiagnosisLoadingOverlay(),

          if (diagnosisState.diagnosis != null)
            DiagnosisResultOverlay(
              disease: diagnosisState.diagnosis!.diseaseName,
              confidence: diagnosisState.diagnosis!.confidence,
              onContinue: () {
                final diagnosisId =
                    diagnosisState.diagnosisId;

                if (diagnosisId == null) {
                  return;
                }

                context.push(
                  '${RoutePaths.chat}/new?diagnosisId=$diagnosisId',
                );
              },
            ),

          if (diagnosisState.error != null)
            DiagnosisErrorOverlay(
              error: diagnosisState.error!,
              onClose: scanController.clearDiagnosis,
            ),

          if (diagnosisState.diagnosis == null &&
              diagnosisState.error == null &&
              !diagnosisState.isLoading)
            ScanBottomControls(
              onCapture: scanController.captureImage,
              onGallery: scanController.pickFromGallery,
              isLoading: diagnosisState.isLoading,
            ),
        ],
      ),
    );
  }
}