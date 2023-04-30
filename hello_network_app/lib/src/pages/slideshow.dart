import "package:flutter/material.dart";
import "package:hello_network_app/src/models/SliderModel.dart";
import "package:hello_network_app/src/widgets/button.dart";
import "package:provider/provider.dart";

class SlideShowPage extends StatelessWidget {
  const SlideShowPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => SliderModel())],
        builder: (context, _) {
          return Scaffold(
            body: Center(
              child: Column(children: <Widget>[
                Expanded(child: _Slider()),
                _Dots(),
                Container(
                  margin: EdgeInsets.all(10),
                  child: Button("Empezar", Color(0xff273469),
                      () => {print("Hola Mundo")}),
                ),
              ]),
            ),
          );
        });
  }
}

class _Slider extends StatefulWidget {
  const _Slider({super.key});

  @override
  State<_Slider> createState() => _SliderState();
}

// Colección de slides
class _SliderState extends State<_Slider> {
  final pageViewController = new PageController();

  @override
  void initState() {
    // TODO: implement initState
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
    return Container(
      child: PageView(
        controller: pageViewController,
        children: <Widget>[
          _Slide(
              "Ofrecemos comunicación segura con otros usuarios de tu red.",
              "Respetamos la privacidad de nuestros usuarios, es por eso que cada conversación está cifrada de extremo a extremo.",
              "https://images.pexels.com/photos/15443094/pexels-photo-15443094.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load"),
          _Slide(
              "Medimos el progreso de cada una de tus actividades.",
              "Te ofrecemos tableros en los que puedes medir el progreso de tus tareas de manera visual.",
              "https://images.pexels.com/photos/16325656/pexels-photo-16325656.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"),
          _Slide(
              "La solución perfecta a la gestión de tu trabajo.",
              "Te notificamos con anticipación cada vez que tienes trabajo o actividades pendientes.",
              "https://images.pexels.com/photos/12903578/pexels-photo-12903578.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1")
        ],
      ),
    );
  }
}

// Diapositiva o slide deslizable
class _Slide extends StatelessWidget {
  final String title;
  final String description;
  final String imageURL;
  _Slide(this.title, this.description, this.imageURL);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      //crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        _CircleBackground(imageURL),
        Container(
          margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(16),
          child: Text(
            title,
            maxLines: 3,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'Poppins', fontSize: 25, color: Color(0xff03045E)),
          ),
        ),
        Container(
          //margin: EdgeInsets.all(10),
          padding: EdgeInsets.all(16),
          child: Text(
            description,
            textAlign: TextAlign.justify,
            style: TextStyle(fontFamily: "Poppins", fontSize: 15),
          ),
        )
      ],
    ));
  }
}

// Colección de puntos
class _Dots extends StatelessWidget {
  const _Dots({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[_Dot(0), _Dot(1), _Dot(2)],
      ),
    );
  }
}

// Punto que hace referencia a la diapositiva o pantalla
class _Dot extends StatelessWidget {
  final int index;

  _Dot(this.index);

  @override
  Widget build(BuildContext context) {
    final pageViewIndex = Provider.of<SliderModel>(context).currentPage;

    return AnimatedContainer(
      duration: Duration(milliseconds: 200),
      width: 20,
      height: 20,
      margin: EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
        color: (pageViewIndex >= (index - 0.5) && pageViewIndex < (index + 0.5))
            ? Color(0xffFFC700)
            : Color(0xff273469),
        shape: BoxShape.circle,
      ),
    );
  }
}

// Circulo con una imagen de fondo
class _CircleBackground extends StatelessWidget {
  final String image;

  _CircleBackground(this.image);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height * 0.5,
      decoration: BoxDecoration(
        color: Color(0xff273469),
        image: DecorationImage(image: NetworkImage(image), fit: BoxFit.cover),
        borderRadius: BorderRadius.vertical(
          bottom: Radius.elliptical(200.0, 80.0),
        ),
        boxShadow: [
          BoxShadow(
              color: Color(0xff273469), blurRadius: 0, offset: Offset(0, 6)),
        ],
      ),
    );
  }
}
