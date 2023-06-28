import "package:flutter/material.dart";
import 'package:hello_network_app/src/models/slider_model.dart';
import "package:hello_network_app/src/utils/preferences.dart";
import "package:hello_network_app/src/widgets/button.dart";
import "package:provider/provider.dart";

Preferences _pref = Preferences();

class SlideShowPage extends StatelessWidget {
  const SlideShowPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => SliderModel())],
        builder: (context, _) {
          return Scaffold(
            body: Center(
              child: Column(children: <Widget>[
                const Expanded(child: _Slider()),
                const _Dots(),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: Button("Empezar", const Color(0xff273469), () {
                    _pref.setBoarding(true);
                    Navigator.pushNamed(context, "/home");
                  }, width: size.width, height: size.height * 0.05),
                ),
              ]),
            ),
          );
        });
  }
}

class _Slider extends StatefulWidget {
  const _Slider();

  @override
  State<_Slider> createState() => _SliderState();
}

// Colección de slides
class _SliderState extends State<_Slider> {
  final pageViewController = PageController();
  final List<Map> data = [
    {
      "title": "Ofrecemos comunicación segura con otros usuarios de tu red.",
      "description":
          "Respetamos la privacidad de nuestros usuarios, es por eso que cada conversación está cifrada de extremo a extremo.",
      "url":
          "https://images.pexels.com/photos/12903578/pexels-photo-12903578.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
    },
    {
      "title": "Medimos el progreso de cada una de tus actividades.",
      "description":
          "Te ofrecemos tableros en los que puedes medir el progreso de tus tareas de manera visual.",
      "url":
          "https://images.pexels.com/photos/12903578/pexels-photo-12903578.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
    },
    {
      "title": "La solución perfecta a la gestión de tu trabajo.",
      "description":
          "Te notificamos con anticipación cada vez que tienes trabajo o actividades pendientes.",
      "url":
          "https://images.pexels.com/photos/12903578/pexels-photo-12903578.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"
    }
  ];

  @override
  void initState() {
    super.initState();
    //Provider.of<SliderModel>(context, listen: false)
    //.setCurrentPage(pageViewController.page);

    pageViewController.addListener(() {
      //print(pageViewController.page);
      // Actualizar el provider
      Provider.of<SliderModel>(context, listen: false)
          .setCurrentPage(pageViewController.page);
    });
  }

  @override
  void dispose() {
    pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
        controller: pageViewController,
        itemCount: data.length,
        itemBuilder: (context, index) => _Slide(data[index]["title"],
            data[index]["description"], data[index]["url"]));
  }
}

// Diapositiva o slide deslizable
class _Slide extends StatelessWidget {
  final String title;
  final String description;
  final String imageURL;
  const _Slide(this.title, this.description, this.imageURL);

  @override
  Widget build(BuildContext context) {
    return Column(
      //crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _CircleBackground(imageURL),
        Expanded(
            child: Container(
                //color: Colors.black,
                padding: const EdgeInsets.all(16),
                child: Center(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            title,
                            maxLines: 3,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontFamily: 'Poppins',
                                fontSize: 25,
                                color: Color(0xff03045E)),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            description,
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                                fontFamily: "Poppins", fontSize: 15),
                          )
                        ]),
                  ),
                ))),
      ],
    );
  }
}

// Colección de puntos
class _Dots extends StatelessWidget {
  const _Dots();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const <Widget>[_Dot(0), _Dot(1), _Dot(2)],
      ),
    );
  }
}

// Punto que hace referencia a la diapositiva o pantalla
class _Dot extends StatelessWidget {
  final int index;

  const _Dot(this.index);

  @override
  Widget build(BuildContext context) {
    final pageViewIndex = Provider.of<SliderModel>(context).currentPage;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      width: 20,
      height: 20,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: (pageViewIndex >= (index - 0.5) && pageViewIndex < (index + 0.5))
            ? const Color(0xffFFC700)
            : const Color(0xff273469),
        shape: BoxShape.circle,
      ),
    );
  }
}

// Circulo con una imagen de fondo
class _CircleBackground extends StatelessWidget {
  final String image;

  const _CircleBackground(this.image);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height * 0.5,
      decoration: BoxDecoration(
        color: const Color(0xff273469),
        image: DecorationImage(image: NetworkImage(image), fit: BoxFit.cover),
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.elliptical(300, 200),
        ),
        boxShadow: const [
          BoxShadow(
              color: Color(0xff273469), blurRadius: 0, offset: Offset(0, 6)),
        ],
      ),
    );
  }
}
