import 'package:flutter/material.dart';
import 'package:hello_network_app/src/widgets/button.dart';
import 'package:hello_network_app/src/widgets/containerBackground.dart';
import 'package:hello_network_app/src/widgets/wave.dart';

// Este widget corresponde a la vista principal con la imagen y los imputs

class IndexApp extends StatelessWidget {
  const IndexApp({super.key});

  @override
  Widget build(BuildContext context) {
    var textStyle = const TextStyle(
        fontFamily: "PoppinsMedium", fontSize: 30, color: Color(0xff273469));

    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        children: [
          ContainerBackground(
              "https://images.pexels.com/photos/16056937/pexels-photo-16056937.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
              0.4,
              const Color(0xff273469)),
          Expanded(
              child: Container(
            padding: const EdgeInsets.all(10.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(
                        "HelloNetwork",
                        style: textStyle,
                      ),
                      const Text(
                        "Conecta y mejora tu productividad.",
                        style: TextStyle(fontFamily: "Poppins", fontSize: 18),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Button("Iniciar Sesión", const Color(0xff1E2749), () {
                        Navigator.pushNamed(context, "/test");
                      }),
                      Button("Crea una cuenta", const Color(0xff30343F), () {
                        print("Crea una cuenta");
                      }),
                    ],
                  ),
                  const Text(
                    "Al registrarte, estás aceptando nuestros términos y condiciones de servicio.",
                    textAlign: TextAlign.center,
                  ),
                ]),
          )),
          FooterWave(),
        ],
      ),
    );
  }
}
