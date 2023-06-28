import 'package:flutter/material.dart';
import 'package:hello_network_app/src/models/user_model.dart';
import 'package:hello_network_app/src/utils/api.dart';
import 'package:hello_network_app/src/widgets/button.dart';
import 'package:hello_network_app/src/widgets/dialog.dart';
import 'package:hello_network_app/src/widgets/navbar.dart';
import 'package:provider/provider.dart';

Future<void> editDescription(BuildContext context) async {
  String text = "";
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Actualizar descripción"),
          content: EditInput(
            placeholder: "Descripción",
            icon: Icon(Icons.people),
            callback: (value) {
              text = value;
            },
          ),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context, "Cancel"),
                child: Text("Cancelar")),
            TextButton(
                onPressed: () async {
                  if (text.isNotEmpty) {
                    try {
                      final response =
                          await ApiServices().updateDescription(text);
                      Provider.of<UserModel>(context, listen: false)
                          .setAuthUser(response["user"]);
                      newDialog(
                          context: context,
                          title: "Información",
                          content: response["msg"]);
                    } on Exception catch (e) {
                      newDialog(
                          context: context,
                          title: "Exception",
                          content: e.toString());
                    }
                  }
                },
                child: Text("Actualizar"))
          ],
        );
      });
}

class EditExperience extends StatefulWidget {
  const EditExperience({super.key});

  @override
  State<EditExperience> createState() => _EditExperienceState();
}

class _EditExperienceState extends State<EditExperience> {
  DateTime? date_start;
  DateTime? date_end;
  String place = "";
  String position = "";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          navbarRoute("Agregar Experiencia"),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(children: [
              EditInput(
                icon: Icon(Icons.map),
                placeholder: "Ingrese el lugar de trabajo",
                callback: (value) {
                  place = value;
                  setState(() {});
                },
              ),
              EditInput(
                icon: Icon(Icons.work),
                placeholder: "Ingrese su posición o cargo",
                callback: (value) {
                  position = value;
                  setState(() {});
                },
              ),
              Button("Seleccionar Fecha", Colors.black, () async {
                final date = await showDateRangePicker(
                    context: context,
                    firstDate:
                        DateTime.now().subtract(Duration(days: (20 * 365))),
                    lastDate: DateTime.now().add(Duration(days: 20 * 365)));

                if (date != null) {
                  setState(() {
                    date_start = date.start;
                    date_end = date.end;
                  });
                }
              }),
              Button("Agregar", Colors.black, () async {
                if (position == "" || place == "") {
                  newDialog(
                      context: context,
                      title: "Advertencia",
                      content:
                          "El campo posición/lugar no puede quedar vacío.");
                } else if (date_start == null || date_end == null) {
                  newDialog(
                      context: context,
                      title: "Advertencia",
                      content:
                          "El rango de fecha seleccionado no puede estar vacío.");
                } else {
                  try {
                    Map<String, dynamic> data = {
                      "place": place,
                      "position": position,
                      "date_start": date_start.toString(),
                      "date_end": date_end.toString()
                    };
                    final response = await ApiServices().addExperience(data);
                    // ignore: use_build_context_synchronously
                    Provider.of<UserModel>(context, listen: false)
                        .setAuthUser(response["user"]);
                    newDialog(
                        context: context,
                        title: "Información",
                        content: response["msg"]);
                  } on Exception catch (e) {
                    newDialog(
                        context: context,
                        title: "Exception",
                        content: e.toString());
                  }
                }
              })
            ]),
          )
        ],
      ),
    ));
  }
}

class EditEducationHistory extends StatefulWidget {
  const EditEducationHistory({super.key});

  @override
  State<EditEducationHistory> createState() => _EditEducationHistoryState();
}

class _EditEducationHistoryState extends State<EditEducationHistory> {
  DateTime? date_start;
  DateTime? date_end;
  String place = "";
  String position = "";
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          navbarRoute("Agregar Historial Académico"),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Column(children: [
              EditInput(
                icon: Icon(Icons.map),
                placeholder: "Ingrese el lugar de estudio",
                callback: (value) {
                  place = value;
                  setState(() {});
                },
              ),
              EditInput(
                icon: Icon(Icons.work),
                placeholder: "Ingrese su posición o cargo",
                callback: (value) {
                  position = value;
                  setState(() {});
                },
              ),
              Button("Seleccionar Fecha", Colors.black, () async {
                final date = await showDateRangePicker(
                    context: context,
                    firstDate:
                        DateTime.now().subtract(Duration(days: (20 * 365))),
                    lastDate: DateTime.now().add(Duration(days: 20 * 365)));

                if (date != null) {
                  setState(() {
                    date_start = date.start;
                    date_end = date.end;
                  });
                }
              }),
              Button("Agregar", Colors.black, () async {
                if (position == "" || place == "") {
                  newDialog(
                      context: context,
                      title: "Advertencia",
                      content:
                          "El campo posición/lugar no puede quedar vacío.");
                } else if (date_start == null || date_end == null) {
                  newDialog(
                      context: context,
                      title: "Advertencia",
                      content:
                          "El rango de fecha seleccionado no puede estar vacío.");
                } else {
                  try {
                    Map<String, dynamic> data = {
                      "place": place,
                      "position": position,
                      "date_start": date_start.toString(),
                      "date_end": date_end.toString()
                    };
                    final response =
                        await ApiServices().addEducationHistory(data);
                    // ignore: use_build_context_synchronously
                    Provider.of<UserModel>(context, listen: false)
                        .setAuthUser(response["user"]);
                    newDialog(
                        context: context,
                        title: "Información",
                        content: response["msg"]);
                  } on Exception catch (e) {
                    newDialog(
                        context: context,
                        title: "Exception",
                        content: e.toString());
                  }
                }
              })
            ]),
          )
        ],
      ),
    ));
  }
}

class EditInput extends StatefulWidget {
  final Icon icon;
  final String placeholder;
  final Function callback;
  const EditInput({
    super.key,
    required this.icon,
    required this.placeholder,
    required this.callback,
  });

  @override
  State<EditInput> createState() => _EditInputState();
}

class _EditInputState extends State<EditInput> {
  TextEditingController controller = TextEditingController();
  Color prefColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
          color: Color(0xff273469), borderRadius: BorderRadius.circular(50)),
      child: TextFormField(
          controller: controller,
          cursorColor: Color(0xffF9A826),
          style: TextStyle(color: Color(0xffF9A826)),
          onChanged: (text) {
            if (text.isNotEmpty) {
              prefColor = Color(0xffF9A826);
            } else {
              prefColor = Colors.white;
            }
            setState(() {});
            widget.callback(text);
          },
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: widget.placeholder,
              hintStyle: TextStyle(color: Colors.white),
              focusColor: Color(0xffF9A826),
              prefixIcon: widget.icon,
              prefixIconColor: prefColor)),
    );
  }
}
