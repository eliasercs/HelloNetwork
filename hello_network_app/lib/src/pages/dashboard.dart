import "package:flutter/material.dart";
import "package:hello_network_app/src/models/form_model.dart";
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
    final error = Provider.of<ErrorModel>(context).error;
    print(error);

    Map<String, dynamic> user = Provider.of<UserModel>(context).authUser;

    /*
    if (user.isEmpty) {
      Navigator.pushNamed(context, "/splash");
    }
    */

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
