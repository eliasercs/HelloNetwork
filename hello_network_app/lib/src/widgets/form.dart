import "package:flutter/material.dart";
import "package:hello_network_app/src/models/form_model.dart";
//import "package:hello_network_app/src/widgets/button.dart";
import "package:provider/provider.dart";

import "../utils/validate.dart";

class inputText extends StatelessWidget {
  final String placeholder;
  inputText({required this.placeholder});

  @override
  Widget build(BuildContext context) {
    return const TextField(
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
          filled: true,
          fillColor: Color(0xff273469),
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xff273469)),
              borderRadius: BorderRadius.all(Radius.circular(50.0))),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0xff273469)),
              borderRadius: BorderRadius.all(Radius.circular(50.0))),
          hintText: "",
          hintStyle: TextStyle(color: Colors.white)),
    );
  }
}

class inputPost extends StatelessWidget {
  final String placeholder;
  final double padding;

  const inputPost(
      {super.key, required this.placeholder, required this.padding});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: 80,
      //color: const Color(0xffe5e5e5),
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
              child: inputText(
            placeholder: placeholder,
          )),
          TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: Color(0xff273469),
                  shape: CircleBorder(),
                  fixedSize: Size(60, 60)),
              onPressed: () {
                print("Publicar");
              },
              child: const Icon(
                Icons.send,
                color: Color(0xfffca311),
              ))
        ],
      ),
    );
  }
}

class InputWithIcon extends StatefulWidget {
  final String placeholder;
  final Icon icon;
  final TextInputType inputType;
  final String label;
  final String attribute;
  final Function validator;
  const InputWithIcon(
      {super.key,
      required this.placeholder,
      required this.icon,
      required this.inputType,
      required this.label,
      required this.validator,
      required this.attribute});

  @override
  State<InputWithIcon> createState() => _InputWithIconState();
}

class _InputWithIconState extends State<InputWithIcon> {
  TextEditingController controller = TextEditingController();
  Color prefColor = Colors.white;
  late List error;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    /*
    Provider.of<ErrorModel>(context).addListener(() {
      Provider.of<ErrorModel>(context, listen: false)
          .setErrorSignUp(widget.attribute, []);
    });
    */
  }

  @override
  void dispose() {
    controller.dispose();
    //Provider.of<ErrorModel>(context).dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    error = Provider.of<ErrorModel>(context, listen: true)
        .getError(widget.attribute);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: TextStyle(fontFamily: "Poppins", fontSize: 14),
        ),
        Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                color: Color(0xff273469),
                borderRadius: BorderRadius.circular(50)),
            child: TextFormField(
              keyboardType: widget.inputType,
              controller: controller,
              obscureText: widget.inputType == TextInputType.visiblePassword
                  ? true
                  : false,
              cursorColor: Color(0xffF9A826),
              onSaved: (value) {
                print(value);
              },
              validator: (value) {
                widget.validator(value);
              },
              style: TextStyle(color: Color(0xffF9A826)),
              onChanged: (text) {
                if (text.isNotEmpty) {
                  prefColor = Color(0xffF9A826);
                } else {
                  prefColor = Colors.white;
                }
                setState(() {});
              },
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: widget.placeholder,
                  hintStyle: TextStyle(color: Colors.white),
                  focusColor: Color(0xffF9A826),
                  prefixIcon: widget.icon,
                  prefixIconColor: prefColor),
            )),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
              error.length,
              (index) => Text(
                    error[index],
                    style: const TextStyle(
                        fontFamily: "PoppinsMedium",
                        fontSize: 12,
                        color: Colors.red),
                  )),
        )
      ],
    );
  }
}

class FormOf extends StatefulWidget {
  final Widget widgets;
  final dynamic height;

  const FormOf({super.key, required this.widgets, this.height});

  @override
  State<FormOf> createState() => _FormState();
}

class _FormState extends State<FormOf> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      //color: Colors.amber,
      height: widget.height ?? size.height * 0.4,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: widget.widgets,
      ),
    );
  }
}

class SignUpInputs extends StatelessWidget {
  const SignUpInputs({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      InputWithIcon(
        placeholder: "Jhon",
        icon: Icon(Icons.person),
        inputType: TextInputType.name,
        label: "Nombre",
        attribute: "name",
        validator: (String value) {
          if (validateString(value)) {
            Provider.of<UserFormModel>(context, listen: false)
                .setProperty("name", value);
            Provider.of<ErrorModel>(context, listen: false)
                .addError("name", []);
          } else {
            Provider.of<ErrorModel>(context, listen: false).addError(
                "name", ["El campo nombre no debe ser una cadena vacía."]);
          }
        },
      ),
      _SeparatorInputs(),
      InputWithIcon(
        placeholder: "Doe",
        icon: Icon(Icons.person),
        inputType: TextInputType.name,
        label: "Apellido",
        attribute: "lastname",
        validator: (String value) {
          if (validateString(value)) {
            Provider.of<UserFormModel>(context, listen: false)
                .setProperty("lastname", value);
            Provider.of<ErrorModel>(context, listen: false)
                .addError("lastname", []);
          } else {
            Provider.of<ErrorModel>(context, listen: false).addError(
                "lastname", ["El campo nombre no debe ser una cadena vacía."]);
          }
        },
      ),
      _SeparatorInputs(),
      InputWithIcon(
        placeholder: "jhondoe@mail.com",
        icon: Icon(Icons.email),
        inputType: TextInputType.emailAddress,
        label: "Correo Electrónico",
        attribute: "email",
        validator: (value) {
          if (validateEmail(value)) {
            Provider.of<UserFormModel>(context, listen: false)
                .setProperty("email", value);
            Provider.of<ErrorModel>(context, listen: false)
                .addError("email", []);
          } else {
            Provider.of<ErrorModel>(context, listen: false)
                .addError("email", ["Correo Electrónico no válido."]);
          }
        },
      ),
      _SeparatorInputs(),
      InputWithIcon(
        placeholder: "*********",
        icon: Icon(Icons.password),
        inputType: TextInputType.visiblePassword,
        label: "Contraseña",
        attribute: "password",
        validator: (value) {
          List<String> error = [];
          bool isPassword = validatePassword(value, 8, error);
          if (isPassword) {
            Provider.of<UserFormModel>(context, listen: false)
                .setProperty("password", value);
            Provider.of<ErrorModel>(context, listen: false)
                .addError("password", []);
          } else {
            Provider.of<ErrorModel>(context, listen: false)
                .addError("password", error);
          }
        },
      ),
      _SeparatorInputs(),
      InputWithIcon(
        placeholder: "********",
        icon: Icon(Icons.password),
        inputType: TextInputType.visiblePassword,
        label: "Repetir Contraseña",
        attribute: "repeat_password",
        validator: (value) {
          List<String> error = [];
          bool isPassword = validatePassword(value, 8, error);
          if (isPassword) {
            Provider.of<UserFormModel>(context, listen: false)
                .setProperty("repeat_password", value);
            Provider.of<ErrorModel>(context, listen: false)
                .addError("repeat_password", []);
          } else {
            Provider.of<ErrorModel>(context, listen: false)
                .addError("repeat_password", error);
          }
        },
      ),
    ]);
  }
}

class SignInInputs extends StatelessWidget {
  const SignInInputs({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InputWithIcon(
          placeholder: "jhondoe@mail.com",
          icon: Icon(Icons.email),
          inputType: TextInputType.emailAddress,
          label: "Correo Electrónico",
          attribute: "email",
          validator: (value) {
            if (validateEmail(value)) {
              Provider.of<UserFormModel>(context, listen: false)
                  .setProperty("email", value);
              Provider.of<ErrorModel>(context, listen: false)
                  .addError("email", []);
            } else {
              Provider.of<ErrorModel>(context, listen: false)
                  .addError("email", ["Correo Electrónico no válido."]);
            }
          },
        ),
        _SeparatorInputs(),
        InputWithIcon(
          placeholder: "*********",
          icon: Icon(Icons.password),
          inputType: TextInputType.visiblePassword,
          label: "Contraseña",
          attribute: "password",
          validator: (value) {
            List<String> error = [];
            bool isPassword = validatePassword(value, 8, error);
            if (isPassword) {
              Provider.of<UserFormModel>(context, listen: false)
                  .setProperty("password", value);
              Provider.of<ErrorModel>(context, listen: false)
                  .addError("password", []);
            } else {
              Provider.of<ErrorModel>(context, listen: false)
                  .addError("password", error);
            }
          },
        )
      ],
    );
  }
}

class _SeparatorInputs extends StatelessWidget {
  const _SeparatorInputs({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 10,
    );
  }
}
