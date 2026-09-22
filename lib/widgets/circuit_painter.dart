import 'package:flutter/material.dart';

/// Draws a simple series RC circuit: voltage source -> resistor -> capacitor -> back to source.
/// This is the pattern every future circuit diagram in the app follows —
/// pure vector drawing, so it's crisp on any screen and easy to correct
/// if a label or value is ever wrong (just edit the code, no image to redraw).
class RcCircuitPainter extends CustomPainter {
  final Color lineColor;
  final Color labelColor;

  RcCircuitPainter({required this.lineColor, required this.labelColor});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = lineColor
      ..strokeWidth = 2.2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final textStyle = TextStyle(color: labelColor, fontSize: 13, fontWeight: FontWeight.w600);

    void drawLabel(String text, Offset pos) {
      final tp = TextPainter(
        text: TextSpan(text: text, style: textStyle),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, pos);
    }

    final double left = 40, right = size.width - 40, top = 30, bottom = size.height - 30;
    final double midX = (left + right) / 2;

    // Top wire: source -> resistor start
    canvas.drawLine(Offset(left, top), Offset(midX - 40, top), paint);

    // Resistor (zigzag), roughly at the top-middle of the loop
    final path = Path()..moveTo(midX - 40, top);
    const zigzagCount = 6;
    final segmentWidth = 80 / zigzagCount;
    for (int i = 0; i < zigzagCount; i++) {
      final dx = (midX - 40) + segmentWidth * (i + 1);
      final dy = top + (i.isEven ? -10 : 10);
      path.lineTo(dx, dy);
    }
    canvas.drawPath(path, paint);
    drawLabel('R', Offset(midX - 8, top - 30));

    // Top wire: resistor end -> right corner
    canvas.drawLine(Offset(midX + 40, top), Offset(right, top), paint);

    // Right wire: down to capacitor
    canvas.drawLine(Offset(right, top), Offset(right, bottom - 20), paint);

    // Capacitor plates (two short horizontal lines) on the right side
    canvas.drawLine(Offset(right - 12, bottom - 20), Offset(right + 12, bottom - 20), paint);
    canvas.drawLine(Offset(right - 12, bottom - 12), Offset(right + 12, bottom - 12), paint);
    drawLabel('C', Offset(right + 16, bottom - 22));

    // Right wire: capacitor -> bottom corner
    canvas.drawLine(Offset(right, bottom - 12), Offset(right, bottom), paint);

    // Bottom wire
    canvas.drawLine(Offset(right, bottom), Offset(left, bottom), paint);

    // Left wire: bottom -> source (+ terminal gap for the source symbol)
    canvas.drawLine(Offset(left, bottom), Offset(left, top + 20), paint);
    canvas.drawCircle(Offset(left, top + 10), 10, paint);
    drawLabel('+', Offset(left - 20, top + 2));
    drawLabel('Vs', Offset(left - 34, top + 16));
    canvas.drawLine(Offset(left, top + 20), Offset(left, top), paint);
  }

  @override
  bool shouldRepaint(covariant RcCircuitPainter oldDelegate) =>
      oldDelegate.lineColor != lineColor || oldDelegate.labelColor != labelColor;
}

/// Drop this widget anywhere to show the diagram — sizing is controlled
/// by the parent, the painter just fills whatever box it's given.
class RcCircuitDiagram extends StatelessWidget {
  const RcCircuitDiagram({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return AspectRatio(
      aspectRatio: 1.6,
      child: CustomPaint(
        painter: RcCircuitPainter(
          lineColor: isDark ? Colors.white70 : Colors.black87,
          labelColor: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}
