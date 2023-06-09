import "package:flutter/material.dart";
import "package:hello_network_app/src/models/user_model.dart";
import "package:hello_network_app/src/utils/api.dart";
import "package:hello_network_app/src/widgets/form.dart";
import "package:hello_network_app/src/widgets/navbar.dart";
import "package:hello_network_app/src/widgets/post.dart";
import "package:hello_network_app/src/widgets/tab.dart";
import "package:provider/provider.dart";

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> user = Provider.of<UserModel>(context).authUser;
    print(user);

    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          navbarDashboard(user["name"], user["lastname"], user["buff"]),
          const Tabs(),
          const inputPost(),
          const Expanded(child: Posts())
        ]),
      ),
    );
  }
}
