import 'package:flutter_driver/driver_extension.dart';
import 'package:flutter_driver/src/driver/driver.dart' as find;
import 'package:flutter_driver/flutter_driver.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("dashboard", () {
    // En esta sección localizamos los widgets a testear utilizando una propiedad Key
    final usernameFinder = find.find.byValueKey("username");

    FlutterDriver? driver;

    // Permite conectarse al driver de Flutter antes de ejecutar cualquier prueba
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    // Cerrar la conexión de los driver de Flutter después de completar las pruebas
    tearDownAll(() async {
      if (driver != null) {
        driver!.close();
      }
    });

    test("user name and lastname", () async {
      expect(await driver!.getText(usernameFinder), "");
    });
  });
}
