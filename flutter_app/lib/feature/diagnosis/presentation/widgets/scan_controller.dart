import 'dart:typed_data';
import 'package:Krishivani/feature/diagnosis/providers/diagnosis_provider.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

class ScanController extends ChangeNotifier
    with WidgetsBindingObserver {
  final Ref ref;

  ScanController(this.ref) {
    WidgetsBinding.instance.addObserver(this);
    initializeCamera();
  }

  final ImagePicker imagePicker = ImagePicker();

  CameraController? cameraController;

  bool cameraLoading = true;
  String? cameraError;

  Future<void> initializeCamera() async {
    try {
      final cameras = await availableCameras();

      if (cameras.isEmpty) {
        throw Exception('No camera available.');
      }

      final camera = cameras.firstWhere(
            (camera) =>
        camera.lensDirection == CameraLensDirection.back,
        orElse: () => cameras.first,
      );

      final controller = CameraController(
        camera,
        ResolutionPreset.high,
        enableAudio: false,
      );

      await controller.initialize();

      if (cameraController != null) {
        await cameraController!.dispose();
      }

      cameraController = controller;
      cameraLoading = false;
      cameraError = null;

      notifyListeners();
    } catch (e) {
      cameraLoading = false;
      cameraError = e.toString();

      notifyListeners();
    }
  }

  Future<void> captureImage() async {
    final controller = cameraController;

    if (controller == null ||
        !controller.value.isInitialized ||
        controller.value.isTakingPicture) {
      return;
    }

    try {
      final image = await controller.takePicture();

      final bytes = await image.readAsBytes();

      await predictImage(
        bytes: bytes,
        inputType: 'camera',
      );
    } catch (e) {
      ref.read(diagnosisProvider.notifier).setError(
        e.toString(),
      );
    }
  }

  Future<void> pickFromGallery() async {
    try {
      final image = await imagePicker.pickImage(
        source: ImageSource.gallery,
      );

      if (image == null) {
        return;
      }

      final bytes = await image.readAsBytes();

      await predictImage(
        bytes: bytes,
        inputType: 'gallery',
      );
    } catch (e) {
      ref.read(diagnosisProvider.notifier).setError(
        e.toString(),
      );
    }
  }

  Future<void> predictImage({
    required List<int> bytes,
    required String inputType,
  }) async {
    await ref.read(diagnosisProvider.notifier).predict(
      imageBytes: Uint8List.fromList(bytes),
      inputType: inputType,
    );
  }

  void clearDiagnosis() {
    ref.read(diagnosisProvider.notifier).clear();
  }

  @override
  void didChangeAppLifecycleState(
      AppLifecycleState state,
      ) {
    if (state == AppLifecycleState.inactive) {
      cameraController?.dispose();
      cameraController = null;

      notifyListeners();
    }

    if (state == AppLifecycleState.resumed) {
      cameraLoading = true;

      notifyListeners();

      initializeCamera();
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    cameraController?.dispose();

    super.dispose();
  }
}