import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class ScanCameraView extends StatelessWidget {
  const ScanCameraView({
    super.key,
    required this.controller,
  });

  final CameraController controller;

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return const SizedBox.expand(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return SizedBox.expand(
      child: CameraPreview(controller),
    );
  }
}