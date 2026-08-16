import 'package:flutter/material.dart';
import 'scan_capture_button.dart';
import 'scan_gallery_button.dart';

class ScanBottomControls extends StatelessWidget {
  const ScanBottomControls({
    super.key,
    required this.onCapture,
    required this.onGallery,
    this.isLoading = false,
  });

  final VoidCallback onCapture;
  final VoidCallback onGallery;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 30,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScanGalleryButton(
            onPressed: onGallery,
            isLoading: isLoading,
          ),

          const SizedBox(width: 50),

          ScanCaptureButton(
            onPressed: onCapture,
            isLoading: isLoading,
          ),
        ],
      ),
    );
  }
}