import 'package:flutter/material.dart';
import 'package:hello_network_app/src/pages/dashboard.dart';
import 'package:hello_network_app/src/pages/index.dart';
import 'package:hello_network_app/src/pages/kanban.dart';
import 'package:hello_network_app/src/pages/profile.dart';
import 'package:hello_network_app/src/pages/slideshow.dart';
import 'package:hello_network_app/src/pages/test.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: <String, WidgetBuilder>{
        "/": (BuildContext context) {
          return const SlideShowPage();
        },
        "/home": (BuildContext context) {
          return const IndexApp();
        },
        "/dashboard": (BuildContext context) {
          return const Dashboard();
        },
        "/user": (context) {
          String id = "1";
          return profilePage(id);
        },
        "/kanban": (context) {
          return kanban("Tablero Personal");
        },
        "/test": (BuildContext context) {
          return const TestApp();
        }
      },
    );
  }
}
