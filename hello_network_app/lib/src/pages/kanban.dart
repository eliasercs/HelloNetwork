import "package:flutter/material.dart";
import "package:hello_network_app/src/widgets/navbar.dart";

class _Tasks extends StatefulWidget {
  const _Tasks();

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
              itemCount: 30,
              itemBuilder: (context, index) => const _Task(),
            )),
      ),
    );
  }
}

class _Task extends StatelessWidget {
  const _Task();

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
            const Text(
              "Resolver alguna tarea.",
              style: TextStyle(fontFamily: "Poppins", fontSize: 18),
            ),
            Row(
              children: const [
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
    return Row(children: [
      _StatusKanban(
        size: size,
        status: "Por hacer",
      ),
      const SizedBox(
        width: 15,
      ),
      _StatusKanban(size: size, status: "En proceso"),
      const SizedBox(
        width: 15,
      ),
      _StatusKanban(size: size, status: "Completado"),
      const SizedBox(
        width: 15,
      ),
      _StatusKanban(size: size, status: "Canceladas")
    ]);
  }
}

class _StatusKanban extends StatelessWidget {
  const _StatusKanban({required this.size, required this.status});

  final Size size;
  final String status;

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
        const Expanded(child: _Tasks())
      ]),
    );
  }
}

class Kanban extends StatelessWidget {
  final String title;

  const Kanban(this.title, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [navbarRoute(title), const Expanded(child: _KanbanModel())],
      )),
    );
  }
}
