import "package:flutter/material.dart";
import "package:hello_network_app/src/models/task_model.dart";
import "package:hello_network_app/src/utils/api.dart";
import "package:hello_network_app/src/widgets/navbar.dart";
import "package:provider/provider.dart";

class _Tasks extends StatefulWidget {
  final List<dynamic> data;

  _Tasks({required this.data});

  @override
  State<_Tasks> createState() => _TasksState();
}

class _TasksState extends State<_Tasks> {
  final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width,
      height: size.height,
      child: SizedBox(
        child: Scrollbar(
            thickness: 5,
            thumbVisibility: true,
            controller: controller,
            child: ListView.builder(
              controller: controller,
              itemCount: widget.data.length,
              itemBuilder: (context, index) => _Task(
                  title: widget.data[index]["title"],
                  date: widget.data[index]["title"]),
            )),
      ),
    );
  }
}

class _Task extends StatelessWidget {
  final String title;
  final String date;

  const _Task({required this.title, required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.only(bottom: 5),
        decoration: BoxDecoration(
            color: Colors.black12, borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontFamily: "Poppins", fontSize: 18),
            ),
            Row(
              children: [
                const Icon(
                  Icons.timelapse,
                  size: 24,
                ),
                Text(
                  date,
                  style: TextStyle(fontFamily: "Poppins", fontSize: 12),
                )
              ],
            )
          ],
        ));
  }
}

class _KanbanModel extends StatelessWidget {
  const _KanbanModel();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      decoration: const BoxDecoration(color: Color(0xff1E2749)),
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
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    final tasks = Provider.of<TaskModel>(context, listen: true).tasks;

    return Row(children: [
      _StatusKanban(
        size: size,
        status: "Por hacer",
        data: tasks["planificado"] ?? [],
      ),
      const SizedBox(
        width: 15,
      ),
      _StatusKanban(
        size: size,
        status: "En proceso",
        data: tasks["proceso"] ?? [],
      ),
      const SizedBox(
        width: 15,
      ),
      _StatusKanban(
        size: size,
        status: "Completado",
        data: tasks["completado"] ?? [],
      ),
      const SizedBox(
        width: 15,
      ),
      _StatusKanban(
        size: size,
        status: "Canceladas",
        data: tasks["cancelado"] ?? [],
      )
    ]);
  }
}

class _StatusKanban extends StatelessWidget {
  const _StatusKanban(
      {required this.size, required this.status, required this.data});

  final Size size;
  final String status;
  final List<dynamic> data;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 0.75,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10)),
      child: Column(children: [
        Container(
          margin: const EdgeInsets.only(bottom: 10),
          child: Text(
            status,
            style: const TextStyle(fontFamily: "Poppins", fontSize: 20),
          ),
        ),
        Expanded(child: _Tasks(data: data))
      ]),
    );
  }
}

class Kanban extends StatelessWidget {
  final String title;
  final bool group;

  Kanban(this.title, this.group, {super.key});

  Map<String, dynamic> data = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          navbarRouteAction(
              title: title,
              icon: Icons.add_box,
              action: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => _AddTask()));
              }),
          const Expanded(child: _KanbanModel())
        ],
      )),
    );
  }
}

class _AddTask extends StatelessWidget {
  const _AddTask({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(body: navbarRoute("Agregar nueva tarea")),
    );
  }
}

class _TaskAddForm extends StatefulWidget {
  const _TaskAddForm({super.key});

  @override
  State<_TaskAddForm> createState() => __TaskAddFormState();
}

class __TaskAddFormState extends State<_TaskAddForm> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Expanded(
          child: Container(
        width: size.width,
        height: size.height,
      )),
    );
  }
}
