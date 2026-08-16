import 'package:Krishivani/feature/diagnosis/presentation/widgets/scan_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final scanControllerProvider =
ChangeNotifierProvider.autoDispose<ScanController>((ref) {
  return ScanController(ref);
});