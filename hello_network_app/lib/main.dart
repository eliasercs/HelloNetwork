import 'dart:convert';
import 'dart:io';

import 'package:hello_network_app/src/models/post_model.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

import 'package:flutter/material.dart';
import 'package:hello_network_app/src/models/form_model.dart';
import 'package:hello_network_app/src/models/project_model.dart';
import 'package:hello_network_app/src/models/tablero_model.dart';
import 'package:hello_network_app/src/models/task_model.dart';
import 'package:hello_network_app/src/models/user_model.dart';
import 'package:hello_network_app/src/pages/chat.dart';
import 'package:hello_network_app/src/pages/dashboard.dart';
import 'package:hello_network_app/src/pages/kanban.dart';
import 'package:hello_network_app/src/pages/profile.dart';
import 'package:hello_network_app/src/pages/project.dart';
import 'package:hello_network_app/src/pages/sign_up.dart';

import "package:flutter/services.dart";
import 'package:hello_network_app/src/utils/handle_routes.dart';
import 'package:hello_network_app/src/utils/notification_services.dart';
import 'package:hello_network_app/src/utils/preferences.dart';
import 'package:hello_network_app/src/utils/sockets.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';

Preferences _p = Preferences();
final String _prodAPI = "https://hellonetwork-production.up.railway.app";

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

StreamSocket streamSocket = StreamSocket();
Socket socket = io(
    '$_prodAPI',
    OptionBuilder().setTransports(['websocket']).setExtraHeaders(
        {"auth-token": _p.tokenAuth}).build());

void connectAndListen() {
  socket.onConnect((_) {
    socket.on("get-messages", (data) {
      streamSocket.addResponse(data);
    });

    socket.on("active-users", (data) {
      streamSocket.updateActiveUsers(data);
    });
  });

  //When an event recieved from server, data is added to the stream
  //socket.on('event', (data) => streamSocket.addResponse);
  //socket.onDisconnect((_) => print('disconnect'));
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  tz.initializeTimeZones();
  await _p.initPrefs();
  await initNotifications();
  HttpOverrides.global = MyHttpOverrides();
  connectAndListen();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    /*
    if (_p.tokenAuth.toString().isNotEmpty) {
      try {
        Provider.of<UserModel>(context).initUserAuth();
      } on Exception catch (e) {
        print(e);
      }
    }
    */

    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TableroModel()),
        ChangeNotifierProvider(create: (_) => ProjectModel()),
        ChangeNotifierProvider(create: (_) => ProjectSelected()),
        ChangeNotifierProvider(create: (_) => UserFormModel()),
        ChangeNotifierProvider(create: (_) => ErrorModel()),
        ChangeNotifierProvider(create: (_) => UserModel()),
        ChangeNotifierProvider(create: (_) => TaskModel()),
        ChangeNotifierProvider(create: (_) => PostModel())
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: <String, WidgetBuilder>{
        "/": (BuildContext context) {
          return checkOnBoarding(context);
        },
        "/home": (BuildContext context) {
          return checkAuth(Dashboard(), context);
        },
        "/dashboard": (BuildContext context) {
          return const Dashboard();
        },
        "/user": (context) {
          final user = Provider.of<UserModel>(context).authUser;
          return profilePage(user: user);
        },
        "/kanban": (context) {
          return Kanban("Tablero Personal", false);
        },
        "/select_project": (context) => const SelectProject(),
        "/view_project": (context) => const ViewProject(),
        "/select_sprint": (context) => const SprintView(),
        "/signup": (context) => SignUp(),
        "/signin": (context) => LogIn(),
        "/splash": (context) => Loading(),
        "/chat_user": (context) => SelectUser()
      },
    );
  }
}

class Load extends StatefulWidget {
  const Load({super.key});

  @override
  State<Load> createState() => _LoadState();
}

class _LoadState extends State<Load> with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500))
          ..addListener(() {
            setState(() {});
          });
    controller.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      value: controller.value,
      strokeWidth: 4,
      color: Colors.amber,
      backgroundColor: Colors.black,
    );
  }
}

class Loading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> user = Provider.of<UserModel>(context).authUser;

    if (user.isNotEmpty) {
      return Dashboard();
    }

    return SafeArea(
        child: Scaffold(
      body: Center(child: Load()),
    ));
  }
}
