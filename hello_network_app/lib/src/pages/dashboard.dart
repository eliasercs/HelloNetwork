import "package:flutter/material.dart";
import "package:hello_network_app/src/models/form_model.dart";
import "package:hello_network_app/src/models/user_model.dart";
import "package:hello_network_app/src/utils/api.dart";
import "package:hello_network_app/src/utils/preferences.dart";
import "package:hello_network_app/src/widgets/form.dart";
import "package:hello_network_app/src/widgets/navbar.dart";
import "package:hello_network_app/src/widgets/post.dart";
import "package:hello_network_app/src/widgets/tab.dart";
import "package:provider/provider.dart";

import 'package:socket_io_client/socket_io_client.dart';

Preferences _p = Preferences();

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> user = Provider.of<UserModel>(context).authUser;

    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          navbarDashboard(user["name"], user["lastname"], user["buff"]),
          const Tabs(),
          const inputPost(
            padding: 20,
          ),
          const Expanded(child: Posts())
        ]),
      ),
    );
  }
}
