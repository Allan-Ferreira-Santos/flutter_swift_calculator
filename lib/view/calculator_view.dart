import 'package:flutter/material.dart';
import 'package:flutter_swift_calculator/controller/calculator_controller.dart';

class CalculatorView extends StatefulWidget {
  const CalculatorView({super.key});

  @override
  State<CalculatorView> createState() => _CalculatorViewState();
}

class _CalculatorViewState extends State<CalculatorView> {
  final CalculatorController calculatorController = CalculatorController();
  final TextEditingController numero1Controller = TextEditingController();
  final TextEditingController numero2Controller = TextEditingController();
  String operador = '+';
  int resultado = 0;

  Future<void> _calcular() async {
    final int numero1 = int.tryParse(numero1Controller.text) ?? 0;
    final int numero2 = int.tryParse(numero2Controller.text) ?? 0;

    await calculatorController.onCalcularPressed(numero1, numero2, operador);

    setState(() {
      resultado = calculatorController.resultado;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora Swift-Flutter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: numero1Controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Número 1'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: numero2Controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Número 2'),
            ),
            const SizedBox(height: 16),
            DropdownButton<String>(
              value: operador,
              onChanged: (String? newValue) {
                setState(() {
                  operador = newValue!;
                });
              },
              items: ['+', '-', '*', '/']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            // Botão para calcular
            ElevatedButton(
              onPressed: _calcular,
              child: const Text('Calcular'),
            ),
            const SizedBox(height: 16),
            // Exibição do resultado
            Text(
              'Resultado: $resultado',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
