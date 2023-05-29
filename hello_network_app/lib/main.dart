import 'package:flutter/material.dart';
import 'package:hello_network_app/src/models/project_model.dart';
import 'package:hello_network_app/src/models/tablero_model.dart';
import 'package:hello_network_app/src/pages/dashboard.dart';
import 'package:hello_network_app/src/pages/index.dart';
import 'package:hello_network_app/src/pages/kanban.dart';
import 'package:hello_network_app/src/pages/profile.dart';
import 'package:hello_network_app/src/pages/project.dart';
import 'package:hello_network_app/src/pages/slideshow.dart';

import "package:flutter/services.dart";
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TableroModel()),
        ChangeNotifierProvider(create: (_) => ProjectModel()),
        ChangeNotifierProvider(create: (_) => ProjectSelected())
      ],
      builder: (context, _) => _MyApp(),
    );
  }
}

class _MyApp extends StatelessWidget {
  const _MyApp({
    super.key,
  });

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
          return const Kanban("Tablero Personal");
        },
        "/select_project": (context) => const SelectProject(),
        "/view_project": (context) => const ViewProject(),
        "/select_sprint": (context) => const SprintView(),
      },
    );
  }
}
