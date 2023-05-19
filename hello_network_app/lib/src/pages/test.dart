import "package:flutter/material.dart";
import "package:hello_network_app/src/widgets/wave.dart";

class TestApp extends StatelessWidget {
  const TestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FooterWave(),
    );
  }
}
