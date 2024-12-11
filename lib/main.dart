import 'package:flutter/material.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculadora Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({Key? key}) : super(key: key);

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String currentInput = ''; // Entrada atual
  String previousInput = ''; // Entrada anterior
  String operator = ''; // Operador

  // Função para atualizar a entrada
  void _onButtonPressed(String value) {
    setState(() {
      if (value == 'C') {
        currentInput = '';
        previousInput = '';
        operator = '';
      } else if (value == '=') {
        if (previousInput.isNotEmpty && operator.isNotEmpty) {
          currentInput = _calculateResult(previousInput, operator, currentInput);
          operator = '';
          previousInput = '';
        }
      } else if (['+', '-', '*', '/'].contains(value)) {
        if (currentInput.isNotEmpty) {
          if (previousInput.isNotEmpty) {
            currentInput = _calculateResult(previousInput, operator, currentInput);
          }
          previousInput = currentInput;
          operator = value;
          currentInput = '';
        }
      } else {
        currentInput += value;
      }
    });
  }

  // Função para realizar os cálculos
  String _calculateResult(String a, String operator, String b) {
    double num1 = double.parse(a);
    double num2 = double.parse(b);

    switch (operator) {
      case '+':
        return (num1 + num2).toString();
      case '-':
        return (num1 - num2).toString();
      case '*':
        return (num1 * num2).toString();
      case '/':
        return (num1 / num2).toString();
      default:
        return b;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora Flutter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Display da calculadora
            TextField(
              controller: TextEditingController(text: currentInput),
              style: const TextStyle(fontSize: 30),
              textAlign: TextAlign.right,
              readOnly: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.all(16),
              ),
            ),
            const SizedBox(height: 20),
            // Botões da calculadora
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  childAspectRatio: 1.5,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: 20,
                itemBuilder: (context, index) {
                  return ElevatedButton(
                    onPressed: () {
                      _onButtonPressed(_getButtonLabel(index));
                    },
                    child: Text(
                      _getButtonLabel(index),
                      style: const TextStyle(fontSize: 24),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Retorna o rótulo dos botões com base no índice
  String _getButtonLabel(int index) {
    const buttons = [
      '7', '8', '9', '/',
      '4', '5', '6', '*',
      '1', '2', '3', '-',
      '0', '.', '=', '+',
      'C'
    ];
    return buttons[index];
  }
}
