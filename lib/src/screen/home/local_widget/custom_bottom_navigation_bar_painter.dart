import 'package:daily_client/src/application.dart';

class CustomBottomNavigationBarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint();
    paint.color = Colors.white;
    paint.style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, size.height);
    path.quadraticBezierTo(0, 0, size.width * 0.1, 0);
    path.lineTo(size.width * 0.35, 0);
    path.quadraticBezierTo(
      size.width * 0.4,
      0,
      size.width * 0.4,
      size.height * 0.2,
    );
    path.arcToPoint(
      Offset(size.width * 0.6, size.height * 0.2),
      radius: const Radius.circular(10),
      clockwise: false,
    );
    path.quadraticBezierTo(size.width * 0.6, 0, size.width * 0.65, 0);
    path.lineTo(size.width * 0.9, 0);
    path.quadraticBezierTo(size.width, 0, size.width, size.height);
    canvas.drawShadow(path, Colors.black, 10, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
