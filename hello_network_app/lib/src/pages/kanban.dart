import "package:flutter/material.dart";
import "package:hello_network_app/src/models/form_model.dart";
import "package:hello_network_app/src/models/task_model.dart";
import "package:hello_network_app/src/utils/api.dart";
import "package:hello_network_app/src/utils/validate.dart";
import "package:hello_network_app/src/widgets/button.dart";
import "package:hello_network_app/src/widgets/dialog.dart";
import "package:hello_network_app/src/widgets/form.dart";
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
                itemBuilder: (context, index) {
                  final date = DateTime.parse(widget.data[index]["date"]);
                  final day = date.day;
                  final month = date.month;
                  final year = date.year;
                  final hour = date.hour;
                  final minute = date.minute;

                  return _Task(
                      title: widget.data[index]["title"],
                      date: "$day/$month/$year - $hour:$minute");
                })),
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
                Provider.of<ErrorModel>(context, listen: false)
                    .setStateErrorForm("addTask");
                Provider.of<ErrorModel>(context, listen: false).setError();
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
    final error = Provider.of<ErrorModel>(context).error;
    final size = MediaQuery.of(context).size;
    print(error);
    return SafeArea(
      child: Scaffold(
          body: Column(
        children: [
          navbarRoute("Agregar nueva tarea"),
          Flexible(child: _TaskAddForm())
        ],
      )),
    );
  }
}

class _TaskAddForm extends StatefulWidget {
  const _TaskAddForm({super.key});

  @override
  State<_TaskAddForm> createState() => __TaskAddFormState();
}

class __TaskAddFormState extends State<_TaskAddForm> {
  final _formKey = GlobalKey<FormState>();
  DateTime? dateStr;
  TimeOfDay? timeStr;
  String? dropdown_value = "Por hacer";
  var status = ["Por hacer", "En proceso", "Completado", "Cancelado"];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height - (size.height * 0.1),
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InputWithIcon(
                  placeholder: "Ingrese un título para la actividad ...",
                  icon: Icon(Icons.abc),
                  inputType: TextInputType.text,
                  label: "Título de la tarea",
                  attribute: "titleTask",
                  validator: (value) {
                    if (validateString(value)) {
                      Provider.of<ErrorModel>(context, listen: false)
                          .addError("titleTask", []);
                      Provider.of<TaskModel>(context, listen: false)
                          .setTaskForm("title", value);
                    } else {
                      Provider.of<ErrorModel>(context, listen: false).addError(
                          "titleTask", [
                        "El título de la tarea no puede ser una cadena vacía"
                      ]);
                    }
                  }),
              SizedBox(
                height: 10,
              ),
              InputWithIcon(
                  placeholder: "Ingrese una descripción para su tarea ...",
                  icon: Icon(Icons.pending),
                  inputType: TextInputType.text,
                  label: "Descripción de la tarea",
                  validator: (value) {
                    if (validateString(value)) {
                      Provider.of<ErrorModel>(context, listen: false)
                          .addError("descriptionTask", []);
                      Provider.of<TaskModel>(context, listen: false)
                          .setTaskForm("description", value);
                    } else {
                      Provider.of<ErrorModel>(context, listen: false).addError(
                          "descriptionTask",
                          ["La descripción de la tarea no puede estar vacía."]);
                    }
                  },
                  attribute: "descriptionTask"),
              SizedBox(
                height: 10,
              ),
              Button(
                "Seleccione una hora",
                Colors.black,
                () {
                  final time = showTimePicker(
                      context: context, initialTime: TimeOfDay.now());
                  time.then((value) {
                    if (value != null) {
                      print(value);
                      timeStr = value;
                      setState(() {});
                    }
                  });
                },
                width: size.width,
              ),
              DropdownButton(
                  value: dropdown_value,
                  items: status
                      .map((String e) =>
                          DropdownMenuItem(value: e, child: Text(e)))
                      .toList(),
                  onChanged: (String? value) {
                    if (validateString(value!)) {
                      Provider.of<ErrorModel>(context, listen: false)
                          .addError("statusTask", []);
                      Provider.of<TaskModel>(context, listen: false)
                          .setTaskForm("status", value);
                    } else {
                      Provider.of<ErrorModel>(context, listen: false).addError(
                          "statusTask",
                          ["El estado de la tarea no puede estar vacío."]);
                    }
                  }),
              Button(
                "Seleccione una fecha",
                Colors.black,
                () {
                  final date = showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)));

                  date.then((value) {
                    if (value != null) {
                      print(value);
                      dateStr = value;
                      setState(() {});
                    }
                  });
                },
                width: size.width,
              ),
              SizedBox(
                height: 10,
              ),
              Text(dateStr != null ? dateStr!.toString() : ""),
              SizedBox(
                height: 10,
              ),
              Button(
                "Agregar Tarea",
                Colors.black,
                () async {
                  if (dateStr != null && timeStr != null) {
                    dateStr = dateStr!.add(Duration(
                        hours: timeStr!.hour, minutes: timeStr!.minute));
                    setState(() {});
                    Provider.of<TaskModel>(context, listen: false)
                        .setTaskForm("date", dateStr.toString());
                    if (_formKey.currentState!.validate()) {
                      print(dateStr.toString());
                      final newTask =
                          Provider.of<TaskModel>(context, listen: false)
                              .taskForm;
                      try {
                        final data = await ApiServices().addNewTask(newTask);
                        newDialog(
                            context: context,
                            title: "Información",
                            content: data["msg"]);

                        Provider.of<TaskModel>(context, listen: false)
                            .resetTaskForm();
                      } on Exception catch (e) {
                        newDialog(
                            context: context,
                            title: "Exception",
                            content: e.toString());
                      }
                    } else {
                      newDialog(
                          context: context,
                          title: "Advertencia",
                          content: "Aún te faltan campos por llenar.");
                    }
                  } else {
                    newDialog(
                        context: context,
                        title: "Advertencia",
                        content: "Debes seleccionar fecha y hora");
                  }
                },
                width: size.width,
              )
            ],
          )),
    );
  }
}
