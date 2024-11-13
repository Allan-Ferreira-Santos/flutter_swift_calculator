import 'package:flutter/services.dart';

class CalculatorController {
  int resultado = 0;

  static const platform = MethodChannel('calculadora');

  Future<void> onCalcularPressed(
      int numero1, int numero2, String operador) async {
    try {
      final int resultadoCalculado = await platform.invokeMethod('calcular', {
        'numero1': numero1,
        'numero2': numero2,
        'operador': operador,
      });

      resultado = resultadoCalculado;
    } on PlatformException catch (e) {
      print("Erro ao comunicar com o Swift: ${e.message}");
      resultado = 0;
    }
  }
}
