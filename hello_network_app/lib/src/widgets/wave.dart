import "package:flutter/material.dart";
import "dart:ui" as ui show Image;

class FooterWave extends StatelessWidget {
  const FooterWave({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      height: 100,
      width: size.width,
      //color: Color(0xffce8147),
      child: CustomPaint(
        painter: FooterWavePainter(),
      ),
    );
  }
}

class FooterWavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final pencil = Paint();
    pencil.color = const Color(0xff273469);
    pencil.style = PaintingStyle.fill;
    pencil.strokeWidth = 40.0;

    final path = Path();
    path.moveTo(0, size.height);
    path.lineTo(0, size.height * 0.25);
    path.quadraticBezierTo(size.width * 0.10, size.height * -0.25,
        size.width * 0.25, size.height * 0.15);
    path.quadraticBezierTo(
        size.width * 0.70, size.height, size.width, size.height * 0.15);
    //path.quadraticBezierTo(
    //    size.width * 0.9, size.height * 0.0025, size.width, size.height * 0.15);
    path.lineTo(size.width, size.height);

    canvas.drawPath(path, pencil);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class HeaderRounded extends StatelessWidget {
  //final String image;
  final ui.Image myBackground;
  const HeaderRounded({super.key, required this.myBackground});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height * 0.5,
      width: size.width,
      //color: Color(0xffce8147),

      child: CustomPaint(
        painter: HeaderCirclePainter(),
      ),
    );
  }
}

class HeaderCirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final pencil = Paint();
    pencil.color = const Color(0xff273469);
    pencil.style = PaintingStyle.fill;
    pencil.strokeWidth = 40.0;

    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height * 0.5);
    path.quadraticBezierTo(
        size.width * 0.5, size.height * 0.7, size.width, size.height * 0.5);
    path.lineTo(size.width, 0);

    canvas.drawPath(path, pencil);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
