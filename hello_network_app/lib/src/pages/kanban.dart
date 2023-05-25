import "package:flutter/material.dart";
import "package:hello_network_app/src/widgets/navbar.dart";

class _tasks extends StatefulWidget {
  const _tasks({super.key});

  @override
  State<_tasks> createState() => _tasksState();
}

class _tasksState extends State<_tasks> {
  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height,
      child: SizedBox(
        child: Scrollbar(
            thickness: 5,
            thumbVisibility: true,
            controller: controller,
            child: ListView.builder(
              controller: controller,
              itemCount: 30,
              itemBuilder: (context, index) => _task(),
            )),
      ),
    );
  }
}

class _task extends StatelessWidget {
  const _task({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(15),
        margin: EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(
            color: Colors.black12, borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Resolver alguna tarea.",
              style: TextStyle(fontFamily: "Poppins", fontSize: 18),
            ),
            Row(
              children: [
                Icon(
                  Icons.timelapse,
                  size: 24,
                ),
                Text(
                  "Fecha y hora",
                  style: TextStyle(fontFamily: "Poppins", fontSize: 12),
                )
              ],
            )
          ],
        ));
  }
}

class _kanbanModel extends StatelessWidget {
  const _kanbanModel({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      decoration: BoxDecoration(color: Color(0xff1E2749)),
      child: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: _StatusRows(size: size),
        ),
      ),
    );
  }
}

class _StatusRows extends StatelessWidget {
  const _StatusRows({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      _StatusKanban(
        size: size,
        status: "Por hacer",
      ),
      SizedBox(
        width: 15,
      ),
      _StatusKanban(size: size, status: "En proceso"),
      SizedBox(
        width: 15,
      ),
      _StatusKanban(size: size, status: "Completado"),
      SizedBox(
        width: 15,
      ),
      _StatusKanban(size: size, status: "Canceladas")
    ]);
  }
}

class _StatusKanban extends StatelessWidget {
  const _StatusKanban({super.key, required this.size, required this.status});

  final Size size;
  final String status;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 0.75,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Column(children: [
        Container(
          margin: EdgeInsets.only(bottom: 10),
          child: Text(
            status,
            style: TextStyle(fontFamily: "Poppins", fontSize: 20),
          ),
        ),
        Expanded(child: _tasks())
      ]),
    );
  }
}

class kanban extends StatelessWidget {
  final String title;

  const kanban(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [navbarRoute(title), Expanded(child: _kanbanModel())],
      )),
    );
  }
}
