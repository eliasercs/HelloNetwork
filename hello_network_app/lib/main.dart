import 'package:flutter/material.dart';
import 'package:hello_network_app/src/models/form_model.dart';
import 'package:hello_network_app/src/models/project_model.dart';
import 'package:hello_network_app/src/models/tablero_model.dart';
import 'package:hello_network_app/src/models/user_model.dart';
import 'package:hello_network_app/src/pages/chat.dart';
import 'package:hello_network_app/src/pages/dashboard.dart';
import 'package:hello_network_app/src/pages/kanban.dart';
import 'package:hello_network_app/src/pages/profile.dart';
import 'package:hello_network_app/src/pages/project.dart';
import 'package:hello_network_app/src/pages/sign_up.dart';

import "package:flutter/services.dart";
import 'package:hello_network_app/src/utils/handle_routes.dart';
import 'package:hello_network_app/src/utils/preferences.dart';
import 'package:hello_network_app/src/utils/sockets.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';

Preferences _p = Preferences();

StreamSocket streamSocket = StreamSocket();
Socket socket = io('http://10.0.2.2:8000',
    OptionBuilder().setTransports(['websocket']).build());

void connectAndListen() {
  socket.onConnect((_) {
    socket.on("send-message", (data) {
      //print(data);
      streamSocket.addResponse(data);
    });

    /*
    socket.emit("send-message", {
      "name": "Eliaser",
      "lastname": "Concha",
      "message": "Hola mundo desde flutter"
    });
    */
  });

  //When an event recieved from server, data is added to the stream
  //socket.on('event', (data) => streamSocket.addResponse);
  socket.onDisconnect((_) => print('disconnect'));
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _p.initPrefs();
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: <String, WidgetBuilder>{
        "/": (BuildContext context) => checkOnBoarding(context),
        "/home": (BuildContext context) => checkAuth(Dashboard(), context),
        "/dashboard": (BuildContext context) {
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
        "/splash": (context) => Loading(),
        "/chat": (context) => UserChat()
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
