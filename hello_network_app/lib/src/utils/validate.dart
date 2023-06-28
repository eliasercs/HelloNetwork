import 'package:email_validator/email_validator.dart';

// Este archivo contiene funciones para realizar diferentes validaciones

bool validateString(String value) {
  if (value.isNotEmpty) {
    return true;
  }
  return false;
}

bool validatePassword(String value, int size, List<String> error) {
  RegExp upperStr = RegExp(r'[A-Z]{1,}');
  RegExp lowerStr = RegExp(r'[a-z]{1,}');

  RegExp digit = RegExp(r'[0-9]{1,}');

  RegExp symbols = RegExp(r'[#&%]{1,}');

  if (value.length < size) {
    error.add("La contraseña debe contener $size carácteres como mínimo.");
  }
  if (!upperStr.hasMatch(value)) {
    error.add("La contraseña debe contener al menos una letra en mayúscula");
  }
  if (!lowerStr.hasMatch(value)) {
    error.add("La contraseña debe contener al menos una letra en minúscula.");
  }
  if (!digit.hasMatch(value)) {
    error.add("La contraseña debe contener al menos un número.");
  }
  if (!symbols.hasMatch(value)) {
    error.add(
        "La contraseña debe contener al menos uno de los siguientes símbolos (#, &, %).");
  }

  return error.isEmpty ? true : false;
}

bool validateEmail(String email) {
  return EmailValidator.validate(email);
}
