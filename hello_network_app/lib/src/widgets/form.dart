import "package:flutter/material.dart";
import "package:hello_network_app/src/widgets/button.dart";

class inputText extends StatelessWidget {
  inputText();

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
          hintText: "¿Qué estás pensando?",
          hintStyle: TextStyle(color: Colors.white)),
    );
  }
}

class inputPost extends StatelessWidget {
  const inputPost({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: 80,
      //color: const Color(0xffe5e5e5),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(child: inputText()),
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
  const InputWithIcon(
      {super.key,
      required this.placeholder,
      required this.icon,
      required this.inputType,
      required this.label});

  @override
  State<InputWithIcon> createState() => _InputWithIconState();
}

class _InputWithIconState extends State<InputWithIcon> {
  TextEditingController controller = TextEditingController();
  Color prefColor = Colors.white;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
              cursorColor: Color(0xffF9A826),
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
            ))
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
      ),
      _SeparatorInputs(),
      InputWithIcon(
        placeholder: "Doe",
        icon: Icon(Icons.person),
        inputType: TextInputType.name,
        label: "Apellido",
      ),
      _SeparatorInputs(),
      InputWithIcon(
        placeholder: "jhondoe@mail.com",
        icon: Icon(Icons.email),
        inputType: TextInputType.emailAddress,
        label: "Correo Electrónico",
      ),
      _SeparatorInputs(),
      InputWithIcon(
        placeholder: "*********",
        icon: Icon(Icons.password),
        inputType: TextInputType.visiblePassword,
        label: "Contraseña",
      ),
      _SeparatorInputs(),
      InputWithIcon(
        placeholder: "********",
        icon: Icon(Icons.password),
        inputType: TextInputType.visiblePassword,
        label: "Repetir Contraseña",
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
        ),
        _SeparatorInputs(),
        InputWithIcon(
          placeholder: "*********",
          icon: Icon(Icons.password),
          inputType: TextInputType.visiblePassword,
          label: "Contraseña",
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
