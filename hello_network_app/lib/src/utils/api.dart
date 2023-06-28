import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:hello_network_app/src/models/user_model.dart';
import 'package:hello_network_app/src/utils/preferences.dart';
import 'package:hello_network_app/src/widgets/dialog.dart';
import "package:http/http.dart" as http;
import 'dart:convert' as convert;

import 'package:provider/provider.dart';

final _p = Preferences();
final String _prodAPI = "https://hellonetwork-production.up.railway.app";

class ApiServices {
  Future<Map<String, dynamic>> addNewUser(
      String name, String lastname, String email, String password) async {
    var data = convert.jsonEncode(<String, String>{
      "name": name,
      "lastname": lastname,
      "email": email,
      "password": password
    });
    var url = Uri.parse("$_prodAPI/api/users/signup");
    final response = await http.post(url, body: data, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    });

    var status = response.statusCode;

    if (status == 400 || status == 200) {
      return convert.jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw Exception("[STATUS $status]");
    }
  }

  Future<dynamic> getUser(String email, String password) async {
    var url = Uri.parse("$_prodAPI/api/auth/signin");
    var data = convert.jsonEncode({"email": email, "password": password});
    final response = await http.post(url, body: data, headers: <String, String>{
      'Content-Type': 'application/json',
    });

    if (response.statusCode == 200 || response.statusCode == 400) {
      return convert.jsonDecode(response.body);
    } else {
      throw Exception("Error al realizar petición.");
    }
  }

  Future<void> getAvatar() async {
    var url = Uri.parse("$_prodAPI/api/users/get_avatar");
    await http.get(url, headers: <String, String>{"auth-token": _p.tokenAuth});
  }

  Future<Map<String, dynamic>> getUserAuth() async {
    var url = Uri.parse("$_prodAPI/api/users/user_auth");
    final response = await http
        .get(url, headers: <String, String>{"auth-token": _p.tokenAuth});

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = convert.jsonDecode(response.body);
      return data;
      //Provider.of<UserModel>(context, listen: false).setAuthUser(data);
    } else {
      throw Exception("Error");
    }
  }

  Future<Map<String, dynamic>> getAllUsers() async {
    var url = Uri.parse("$_prodAPI/api/users/all_users");
    final response = await http.get(url, headers: <String, String>{
      "Content-Type": "application/json",
      "auth-token": _p.tokenAuth
    });
    if (response.statusCode == 200) {
      final Map<String, dynamic> data = convert.jsonDecode(response.body);
      return data;
    } else {
      throw Exception("Error");
    }
  }

  Future<dynamic> addNewTask(Map<String, dynamic> data) async {
    var url = Uri.parse("$_prodAPI/api/tasks/add");
    print(data);
    final response = await http.post(url,
        headers: <String, String>{
          "Content-Type": "application/json",
          "auth-token": _p.tokenAuth
        },
        body: convert.jsonEncode(data));
    if (response.statusCode == 200) {
      return convert.jsonDecode(response.body);
    } else {
      throw Exception("Ocurrió un error al agregar una nueva tarea");
    }
  }

  Future<dynamic> getAllTasks() async {
    var url = Uri.parse("$_prodAPI/api/tasks/personal");
    final response = await http.get(url, headers: <String, String>{
      "Content-Type": "application/json",
      "auth-token": _p.tokenAuth
    });
    if (response.statusCode == 200) {
      return convert.jsonDecode(response.body);
    }
    return {};
  }

  Future<dynamic> addNewPost(String content) async {
    var url = Uri.parse("$_prodAPI/api/posts/add");
    final date = DateTime.now();
    Map<String, dynamic> data = {"content": content, "date": date.toString()};

    final response = await http.post(url,
        headers: <String, String>{
          "Content-Type": "application/json",
          "auth-token": _p.tokenAuth
        },
        body: convert.jsonEncode(data));

    if (response.statusCode == 200) {
      return convert.jsonDecode(response.body);
    } else {
      throw Exception("Ha ocurrido un error");
    }
  }

  Future<dynamic> getAllPosts() async {
    var url = Uri.parse("$_prodAPI/api/posts/all");
    final response =
        await http.get(url, headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      return convert.jsonDecode(response.body);
    } else {
      throw Exception("Ha ocurrido un error");
    }
  }

  Future<dynamic> addExperience(Map<String, dynamic> data) async {
    var url = Uri.parse("$_prodAPI/api/users/add_experience");
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "auth-token": _p.tokenAuth
        },
        body: convert.jsonEncode(data));

    if (response.statusCode == 200) {
      return convert.jsonDecode(response.body);
    } else {
      throw Exception("Ocurrió un error");
    }
  }

  Future<dynamic> addEducationHistory(Map<String, dynamic> data) async {
    var url = Uri.parse("$_prodAPI/api/users/add_education");
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "auth-token": _p.tokenAuth
        },
        body: convert.jsonEncode(data));

    if (response.statusCode == 200) {
      return convert.jsonDecode(response.body);
    } else {
      throw Exception("Ocurrió un error");
    }
  }

  Future<dynamic> updateDescription(String data) async {
    var url = Uri.parse("$_prodAPI/api/users/description");
    final response = await http.put(url,
        headers: {
          "Content-Type": "application/json",
          "auth-token": _p.tokenAuth
        },
        body: convert.jsonEncode({"description": data}));

    if (response.statusCode == 200) {
      return convert.jsonDecode(response.body);
    } else {
      throw Exception("Ocurrió un error");
    }
  }

  Future<dynamic> setAvatar(File image, String email) async {
    var url = Uri.parse("$_prodAPI/api/users/avatar");
    Map<String, dynamic> map = {};
    final request = http.MultipartRequest("POST", url);

    final file = await http.MultipartFile.fromPath("avatar", image.path);

    request.fields["email"] = email;
    request.files.add(file);

    final response = await request.send();
    if (response.statusCode == 200) {
      Map<String, dynamic> r = {"msg": "Imagen actualizada satisfactoriamente"};
      return r;
    } else {
      throw Exception("Error al actualizar avatar");
    }
  }

  Future<dynamic> countCommentsAndReactions(String id_post) async {
    var url = Uri.parse("$_prodAPI/api/posts/count?id_post=${id_post}");
    final response =
        await http.get(url, headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      return convert.jsonDecode(response.body);
    } else {
      throw Exception(
          "No se han podido contar las reacciones y/o comentarios.");
    }
  }

  Future<dynamic> addReaction(String id_post) async {
    var url = Uri.parse("$_prodAPI/api/posts/add_reaction");
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "auth-token": _p.tokenAuth
        },
        body: jsonEncode({"id_post": id_post}));
    if (response.statusCode == 200) {
      return convert.jsonDecode(response.body);
    } else {
      throw Exception(
          "No se ha podido agregar/eliminar la reacción a esta publicación.");
    }
  }

  Future<dynamic> addComment(String id_post, String content) async {
    var url = Uri.parse("$_prodAPI/api/posts/add_comment");
    final date = DateTime.now();
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "auth-token": _p.tokenAuth
        },
        body: jsonEncode({
          "id_post": id_post,
          "content": content,
          "datetime": date.toString()
        }));
    if (response.statusCode == 200) {
      return convert.jsonDecode(response.body);
    } else {
      throw Exception("No se ha podido agregar su comentario.");
    }
  }

  Future<dynamic> getComments(String id_post) async {
    var url = Uri.parse("$_prodAPI/api/posts/comments?id_post=${id_post}");
    final response =
        await http.get(url, headers: {"Content-Type": "application/json"});
    if (response.statusCode == 200) {
      return convert.jsonDecode(response.body);
    } else {
      throw Exception(
          "No se han podido contar las reacciones y/o comentarios.");
    }
  }
}
