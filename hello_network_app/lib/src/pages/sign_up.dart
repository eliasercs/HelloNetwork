import "package:flutter/material.dart";
import "package:hello_network_app/src/widgets/button.dart";
import "package:hello_network_app/src/widgets/form.dart";
import "package:fluttericon/font_awesome5_icons.dart";

class _BackgroundPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final pencil = Paint();
    pencil.color = const Color(0xff273469);
    pencil.style = PaintingStyle.fill;
    pencil.strokeWidth = 40.0;

    final path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height * 0.6);
    path.lineTo(size.width, size.height * 0.45);
    path.lineTo(size.width, 0);

    canvas.drawPath(path, pencil);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class _Background extends StatelessWidget {
  const _Background({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      width: size.width,
      child: CustomPaint(painter: _BackgroundPainter()),
    );
  }
}

class _Body extends StatelessWidget {
  final Widget widgets;

  const _Body({super.key, required this.widgets});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
        width: size.width,
        //height: size.height * 0.75,
        margin: EdgeInsets.symmetric(horizontal: 10),
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 5),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        child: Center(
          child: widgets,
        ));
  }
}

class _View extends StatelessWidget {
  final String title;
  final Widget inputs;
  final String btnTitle;
  final Function btnAction;
  final double? heightForm;
  _View(
      {super.key,
      required this.title,
      required this.inputs,
      required this.btnTitle,
      required this.btnAction,
      this.heightForm});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.only(left: 5),
              child: Text(
                title,
                style: TextStyle(fontFamily: "PoppinsMedium", fontSize: 25),
              ),
            ),
            IconBtn(Colors.white, Colors.black, Icons.close,
                () => Navigator.pop(context, true))
          ],
        ),
        FormOf(
          widgets: inputs,
          height: heightForm,
        ),
        Button(
          btnTitle,
          Colors.black,
          btnAction,
          width: size.width,
        ),
        _OSeparator(),
        SocialIcon(
          icon: Icon(
            FontAwesome5.google,
            color: Colors.red,
          ),
          text: "Iniciar Sesión con Google",
        )
      ],
    );
  }
}

class _OSeparator extends StatelessWidget {
  const _OSeparator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Text(
      "---- o ----",
      style: TextStyle(fontFamily: "PoppinsMedium", fontSize: 15),
    );
  }
}

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(
          color: Colors.black12,
          child: _Background(),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _Body(
                widgets: _View(
              title: "Registro",
              inputs: SignUpInputs(),
              btnTitle: "Registrarse",
              btnAction: () {},
            ))
          ],
        )
      ]),
    );
  }
}

class LogIn extends StatelessWidget {
  const LogIn({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(children: [
        Container(
          color: Colors.black12,
          child: _Background(),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _Body(
                widgets: _View(
              title: "Inicia sesión",
              inputs: SignInInputs(),
              btnTitle: "Iniciar sesión",
              heightForm: size.height * 0.2,
              btnAction: () {},
            ))
          ],
        )
      ]),
    );
  }
}
