import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hello_network_app/src/models/form_model.dart';
import 'package:hello_network_app/src/models/project_model.dart';
import 'package:hello_network_app/src/models/tablero_model.dart';
import 'package:hello_network_app/src/models/user_model.dart';
import 'package:hello_network_app/src/pages/dashboard.dart';
import 'package:hello_network_app/src/pages/index.dart';
import 'package:hello_network_app/src/pages/kanban.dart';
import 'package:hello_network_app/src/pages/profile.dart';
import 'package:hello_network_app/src/pages/project.dart';
import 'package:hello_network_app/src/pages/sign_up.dart';
import 'package:hello_network_app/src/pages/slideshow.dart';

import "package:flutter/services.dart";
import 'package:hello_network_app/src/utils/api.dart';
import 'package:hello_network_app/src/utils/handle_routes.dart';
import 'package:hello_network_app/src/utils/preferences.dart';
import 'package:hello_network_app/src/widgets/dialog.dart';
import 'package:provider/provider.dart';

Preferences _p = Preferences();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _p.initPrefs();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    if (_p.tokenAuth.toString().isNotEmpty) {
      ApiServices().getUserAuth(context);
    }

    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TableroModel()),
        ChangeNotifierProvider(create: (_) => ProjectModel()),
        ChangeNotifierProvider(create: (_) => ProjectSelected()),
        ChangeNotifierProvider(create: (_) => UserFormModel()),
        ChangeNotifierProvider(create: (_) => ErrorModel()),
        ChangeNotifierProvider(create: (_) => UserModel())
      ],
      builder: (context, _) => _MyApp(),
    );
  }
}

class _MyApp extends StatefulWidget {
  const _MyApp({
    super.key,
  });

  @override
  State<_MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<_MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_p.tokenAuth.toString().isNotEmpty) {
      ApiServices().getUserAuth(context);
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: <String, WidgetBuilder>{
        "/": (BuildContext context) => checkOnBoarding(context),
        "/home": (BuildContext context) => checkAuth(Dashboard(), context),
        "/dashboard": (BuildContext context) {
          if (_p.tokenAuth.toString().isNotEmpty) {
            ApiServices().getUserAuth(context);
          }
          return const Dashboard();
        },
        "/user": (context) {
          final user = Provider.of<UserModel>(context).authUser;
          return profilePage(
            image: user["buff"],
          );
        },
        "/kanban": (context) {
          return const Kanban("Tablero Personal");
        },
        "/select_project": (context) => const SelectProject(),
        "/view_project": (context) => const ViewProject(),
        "/select_sprint": (context) => const SprintView(),
        "/signup": (context) => SignUp(),
        "/signin": (context) => LogIn(),
        "/splash": (context) => Scaffold(
              body: Center(
                child: Text("Splash Screen"),
              ),
            )
      },
    );
  }
}
