import 'package:flutter/material.dart';

class ScanOverlay extends StatelessWidget {
  const ScanOverlay({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: CustomPaint(
        painter: ScanOverlayPainter(),
        size: Size.infinite,
      ),
    );
  }
}

class ScanOverlayPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final scanSize = size.width * 0.78;

    final left = (size.width - scanSize) / 2;
    final top = (size.height - scanSize) / 2;

    final scanRect = Rect.fromLTWH(
      left,
      top,
      scanSize,
      scanSize,
    );

    final overlayPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.45)
      ..style = PaintingStyle.fill;

    final backgroundPath = Path()
      ..addRect(
        Rect.fromLTWH(
          0,
          0,
          size.width,
          size.height,
        ),
      );

    final scanPath = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          scanRect,
          const Radius.circular(24),
        ),
      );

    final overlayPath = Path.combine(
      PathOperation.difference,
      backgroundPath,
      scanPath,
    );

    canvas.drawPath(
      overlayPath,
      overlayPaint,
    );

    final borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;

    canvas.drawRRect(
      RRect.fromRectAndRadius(
        scanRect,
        const Radius.circular(24),
      ),
      borderPaint,
    );
  }

  @override
  bool shouldRepaint(
      covariant ScanOverlayPainter oldDelegate,
      ) {
    return false;
  }
}