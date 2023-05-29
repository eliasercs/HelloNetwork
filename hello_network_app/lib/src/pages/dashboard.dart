import "package:flutter/material.dart";
import "package:hello_network_app/src/widgets/form.dart";
import "package:hello_network_app/src/widgets/navbar.dart";
import "package:hello_network_app/src/widgets/post.dart";
import "package:hello_network_app/src/widgets/tab.dart";

class Dashboard extends StatelessWidget {
  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          navbarDashboard("Eliaser", "Concha"),
          const Tabs(),
          const inputPost(),
          const Expanded(child: Posts())
        ]),
      ),
    );
  }
}
