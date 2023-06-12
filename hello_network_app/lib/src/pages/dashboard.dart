import "package:flutter/material.dart";
import "package:hello_network_app/src/models/user_model.dart";
import "package:hello_network_app/src/utils/api.dart";
import "package:hello_network_app/src/widgets/form.dart";
import "package:hello_network_app/src/widgets/navbar.dart";
import "package:hello_network_app/src/widgets/post.dart";
import "package:hello_network_app/src/widgets/tab.dart";
import "package:provider/provider.dart";

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> user = Provider.of<UserModel>(context).authUser;

    /*
    if (user.isEmpty) {
      Navigator.pushNamed(context, "/splash");
    }
    */

    print(user);

    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          navbarDashboard(user["name"], user["lastname"], user["buff"]),
          const Tabs(),
          const inputPost(
            placeholder: "¿Qué estás pensando?",
            padding: 20,
          ),
          const Expanded(child: Posts())
        ]),
      ),
    );
  }
}
