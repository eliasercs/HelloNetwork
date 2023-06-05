import "package:http/http.dart" as http;
import 'dart:convert' as convert;

class ApiServices {
  Future<Map<String, dynamic>> addNewUser(
      String name, String lastname, String email, String password) async {
    var data = convert.jsonEncode(<String, String>{
      "name": name,
      "lastname": lastname,
      "email": email,
      "password": password
    });
    var url = Uri.parse("http://10.0.2.2:8000/api/users/signup");
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
}
