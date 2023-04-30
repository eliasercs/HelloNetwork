import 'package:flutter/material.dart';
import 'package:hello_network_app/src/pages/slideshow.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SlideShowPage(),
    );
  }
}
