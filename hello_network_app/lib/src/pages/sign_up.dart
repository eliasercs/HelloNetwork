import "package:flutter/material.dart";
import "package:hello_network_app/src/models/form_model.dart";
import "package:hello_network_app/src/widgets/button.dart";
import "package:hello_network_app/src/widgets/dialog.dart";
import "package:hello_network_app/src/widgets/form.dart";
import "package:fluttericon/font_awesome5_icons.dart";
import "package:provider/provider.dart";

import "../models/user_model.dart";
import "../utils/api.dart";
import "../utils/preferences.dart";

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

class Background extends StatelessWidget {
  const Background({super.key});

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
            IconBtn(Colors.white, Colors.black, Icons.close, () {
              Navigator.pop(context, true);
              Provider.of<ErrorModel>(context, listen: false).setError();
            })
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

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(children: [
        Container(
          color: Colors.black12,
          child: Background(),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
              key: _formKey,
              child: _Body(
                  widgets: _View(
                title: "Registro",
                inputs: SignUpInputs(),
                btnTitle: "Registrarse",
                btnAction: () async {
                  if (_formKey.currentState!.validate()) {
                    final newUser =
                        Provider.of<UserFormModel>(context, listen: false)
                            .newUser;
                    // Si tienes los 5 datos
                    if (newUser.length == 5) {
                      if (newUser["password"] != newUser["repeat_password"]) {
                        return newDialog(
                            context: context,
                            title: "Advertencia",
                            content: "Las contraseñas no coinciden.");
                      }

                      try {
                        Map<String, dynamic> data = await ApiServices()
                            .addNewUser(newUser["name"], newUser["lastname"],
                                newUser["email"], newUser["password"]);
                        // ignore: use_build_context_synchronously
                        newDialog(
                            context: context,
                            title: "Información",
                            content: data["msg"]);
                        // ignore: use_build_context_synchronously
                        Provider.of<UserFormModel>(context, listen: false)
                            .reset();
                      } on Exception catch (e) {
                        newDialog(
                            context: context,
                            title: "Exception",
                            content: e.toString());
                      }
                    } else {
                      return newDialog(
                          context: context,
                          title: "Advertencia",
                          content: "Aún te falta campos por llenar.");
                    }
                  }
                },
              )),
            )
          ],
        )
      ]),
    );
  }
}

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(children: [
        Container(
          color: Colors.black12,
          child: Background(),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Form(
                key: _formKey,
                child: _Body(
                    widgets: _View(
                  title: "Inicia sesión",
                  inputs: SignInInputs(),
                  btnTitle: "Iniciar sesión",
                  heightForm: size.height * 0.2,
                  btnAction: () async {
                    if (_formKey.currentState!.validate()) {
                      final getUser =
                          Provider.of<UserFormModel>(context, listen: false)
                              .newUser;
                      if (getUser.length == 2) {
                        try {
                          final data = await ApiServices()
                              .getUser(getUser["email"], getUser["password"]);
                          if (data["statusCode"] == 400) {
                            // ignore: use_build_context_synchronously
                            newDialog(
                                context: context,
                                title: "Información",
                                content: data["msg"]);
                          } else {
                            final token = data["token"];
                            final pref = Preferences();
                            pref.setTokenAuth(token);
                            final auth = await ApiServices().getUserAuth();
                            Provider.of<UserModel>(context, listen: false)
                                .setAuthUser(auth);
                            // ignore: use_build_context_synchronously
                            Navigator.pushReplacementNamed(
                                context, "/dashboard");
                          }
                          Provider.of<UserFormModel>(context, listen: false)
                              .reset();
                        } on Exception catch (e) {
                          return newDialog(
                              context: context,
                              title: "Exception",
                              content: e.toString());
                        }
                      } else {
                        return newDialog(
                            context: context,
                            title: "Advertencia",
                            content: "Aún te falta campos por llenar.");
                      }
                    }
                  },
                )))
          ],
        )
      ]),
    );
  }
}
