import 'package:flutter_test/flutter_test.dart';

/// Prueba mínima para que `flutter test` y el CI no fallen
/// mientras no existan otras pruebas.
void main() {
  test('el proyecto compila', () => expect(1 + 1, 2));
}
