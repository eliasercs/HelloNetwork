import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:hello_network_app/src/models/user_model.dart';
import 'package:hello_network_app/src/utils/api.dart';
import 'package:hello_network_app/src/widgets/button.dart';
import 'package:hello_network_app/src/widgets/dialog.dart';
import 'package:hello_network_app/src/widgets/navbar.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class TakePictureScreen extends StatefulWidget {
  final CameraDescription camera;
  const TakePictureScreen({super.key, required this.camera});

  @override
  State<TakePictureScreen> createState() => _TakePictureScreenState();
}

class _TakePictureScreenState extends State<TakePictureScreen> {
  late CameraController _cameraController;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cameraController = CameraController(widget.camera, ResolutionPreset.high);
    _initializeControllerFuture = _cameraController.initialize();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(children: [
        navbarRoute("Capturar"),
        FutureBuilder(
          future: _initializeControllerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return CameraPreview(_cameraController);
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
        Button("Capturar", Colors.black, () async {
          try {
            await _initializeControllerFuture;
            final tmp = await getTemporaryDirectory();
            final path = join(tmp.path, '${DateTime.now()}.png');
            final data = await _cameraController.takePicture();
            data.saveTo(path);

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => _DisplayImage(imagePath: path)));
          } catch (e) {
            newDialog(
                context: context, title: "Peligro", content: e.toString());
          }
        })
      ]),
    ));
  }
}

class _DisplayImage extends StatelessWidget {
  final String imagePath;
  const _DisplayImage({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final image = File(imagePath);
    final user = Provider.of<UserModel>(context).authUser;
    return SafeArea(
        child: Scaffold(
      body: Column(children: [
        navbarRoute("Mostrar Imagen"),
        Image.file(
          image,
          fit: BoxFit.cover,
        ),
        Button("Cargar Imagen", Colors.black, () async {
          final email = user["email"];
          try {
            final event = await ApiServices().setAvatar(image, email);
            newDialog(
                context: context, title: "Información", content: event["msg"]);
            Provider.of<UserModel>(context, listen: false).initUserAuth();
            ApiServices().getAllPosts();
          } on Exception catch (e) {
            newDialog(
                context: context, title: "Información", content: e.toString());
          }
        })
      ]),
    ));
  }
}
