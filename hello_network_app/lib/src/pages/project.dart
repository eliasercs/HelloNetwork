import "dart:math";
import 'package:blur/blur.dart';

import "package:flutter/material.dart";
import "package:hello_network_app/src/models/project_model.dart";
import "package:hello_network_app/src/models/tablero_model.dart";
import "package:hello_network_app/src/pages/profile.dart";
import "package:hello_network_app/src/widgets/button.dart";
import 'package:hello_network_app/src/widgets/container_background.dart';
import "package:hello_network_app/src/widgets/navbar.dart";
import "package:provider/provider.dart";

class SelectProject extends StatefulWidget {
  const SelectProject({super.key});

  @override
  State<SelectProject> createState() => _SelectProjectState();
}

class _SelectProjectState extends State<SelectProject> {
  ScrollController controller = ScrollController();

  void SelectProject(projects, index) {
    Provider.of<ProjectSelected>(context, listen: false)
        .selectProject(projects[index]);
    Navigator.pushNamed(context, "/view_project");
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final projects = Provider.of<ProjectModel>(context, listen: true).projects;

    int num_projects = projects.length;

    return Scaffold(
      body: SafeArea(
          child: Column(children: [
        navbarRouteAction(
            title: "Seleccione un proyecto",
            icon: Icons.plus_one,
            action: () {
              var imgValue = Random().nextInt(8) + 1;
              Map<String, dynamic> project = {
                "name": "Proyecto $num_projects",
                "description": "Aquí va la descripción.",
                "img": "graphics/bg/$imgValue.jpg"
              };
              Provider.of<ProjectModel>(context, listen: false)
                  .addProject(project);
            }),
        Expanded(
            child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          width: size.width,
          height: size.height,
          decoration: const BoxDecoration(color: Color(0xff1E2749)),
          child: LayoutBuilder(
              builder: (context, constraints) => SizedBox(
                    child: Scrollbar(
                      controller: controller,
                      thickness: 5,
                      thumbVisibility: false,
                      child: ListView.builder(
                          controller: controller,
                          itemCount: num_projects,
                          itemBuilder: (context, index) {
                            //var imgValue = Random().nextInt(8) + 1;
                            return GestureDetector(
                              onTap: () => SelectProject(projects, index),
                              child: _ProjectThumbnail(
                                size: size,
                                image: projects[index]["img"],
                                title: projects[index]["name"],
                              ),
                            );
                          }),
                    ),
                  )),
        ))
      ])),
    );
  }
}

class ImageCard extends StatelessWidget {
  final String image;
  final String title;

  const ImageCard({super.key, required this.image, required this.title});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: _ProjectThumbnail(
        size: size,
        image: image,
        title: title,
      ),
    );
  }
}

class _ProjectThumbnail extends StatelessWidget {
  const _ProjectThumbnail(
      {required this.size, required this.image, required this.title});

  final Size size;
  final String image;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      width: size.width,
      height: size.height * 0.15,
      decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: AssetImage(image),
            fit: BoxFit.cover,
          )),
      child: Center(
          child: Text(
        title,
        style: const TextStyle(
            fontFamily: "Poppins", fontSize: 20, color: Colors.white),
      ).frosted(
              blur: 5,
              padding: const EdgeInsets.all(10),
              width: size.width,
              height: size.height,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              frostColor: Colors.black)),
    );
  }
}

class ViewProject extends StatelessWidget {
  const ViewProject({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    Map<String, dynamic> project_selected =
        Provider.of<ProjectSelected>(context, listen: true).project_selected;
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          Stack(children: [
            ContainerBackground(project_selected["img"], 0.3, Colors.black),
            IconBtn(Colors.transparent, Colors.amber, Icons.arrow_back, () {
              Navigator.pop(context, true);
            })
          ]),
          Expanded(
              child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: _ViewProjectBody(
                title: project_selected["name"],
                description: project_selected["description"],
                size: size),
          ))
        ]),
      ),
    );
  }
}

class _ViewProjectBody extends StatelessWidget {
  const _ViewProjectBody(
      {required this.size, required this.title, required this.description});

  final Size size;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final h = description.length;
    /*
    */

    return OrientationBuilder(
        builder: (context, orientation) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              width: size.width,
              height: size.height * 0.65,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: TextStyle(fontFamily: "Poppins", fontSize: 25),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Button(
                      "Miembros",
                      const Color(0xff273469),
                      () {},
                      width: size.width,
                      height: orientation == Orientation.portrait
                          ? size.height * 0.05
                          : size.height * 0.1,
                    ),
                    const SizedBox(
                      height: 2.5,
                    ),
                    Button(
                      "Tareas del proyecto",
                      const Color(0xff273469),
                      () {
                        Navigator.pushNamed(context, "/select_sprint");
                      },
                      width: size.width,
                    ),
                  ]),
            ));
  }
}

class SprintView extends StatelessWidget {
  const SprintView({super.key});

  @override
  Widget build(BuildContext context) {
    //final size = MediaQuery.of(context).size;

    List tablero =
        Provider.of<TableroModel>(context, listen: true).tableroSprint;

    int size_tablero = tablero.length;

    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          navbarRouteAction(
              title: "Seleccione un periodo",
              icon: Icons.plus_one,
              action: () {
                Provider.of<TableroModel>(context, listen: false)
                    .appendTablero("Tablero $size_tablero");
              }),
          Expanded(
              child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: const BoxDecoration(color: Color(0xff1E2749)),
            child: GridView.count(
              crossAxisCount: 2,
              children: List.generate(tablero.length, (index) {
                var intValue = Random().nextInt(8) + 1;
                return GestureDetector(
                  onTap: () => Navigator.pushNamed(context, "/kanban"),
                  child: ImageCard(
                      image: 'graphics/bg/$intValue.jpg',
                      title: tablero[index]),
                );
              }),
            ),
          ))
        ],
      )),
    );
  }
}
