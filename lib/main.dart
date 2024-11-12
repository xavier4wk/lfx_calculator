import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const CalculatorScreen(),
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  _CalculatorScreenState createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String currentInput =
      '0'; // holds the current number being entered or the result
  double previousValue =
      0; // holds the previous value for binary operations (e.g., addition)
  String operation = ''; // holds the operation symbol selected
  bool isNewInput =
      true; // indicates if we should start a new input after an operation

  void inputNumber(String number) {
    setState(() {
      // if it's a new input, start fresh, otherwise append the number
      if (isNewInput) {
        currentInput = number;
        isNewInput = false;
      } else {
        currentInput += number;
      }
    });
  }

  void selectOperation(String op) {
    setState(() {
      previousValue = double.parse(
          currentInput); // save the current input as previous value
      operation = op; // store the operation selected
      isNewInput = true; // set flag to start new input for next number
    });
  }

  void calculateResult() {
    setState(() {
      double currentValue = double.parse(currentInput);
      double result;

      switch (operation) {
        case '+':
          result = previousValue + currentValue;
          break;
        case '-':
          result = previousValue - currentValue;
          break;
        case 'x': // Changing * to x
          result = previousValue * currentValue;
          break;
        case '%': // Changing / to %
          result = currentValue != 0 ? previousValue / currentValue : 0;
          break;
        default:
          result =
              currentValue; // if no operation, just return the current input
      }

      currentInput = result.toString(); // update display with result
      isNewInput = true; // prepare for a new input
      operation = ''; // clear the operation
    });
  }

  void clear() {
    setState(() {
      currentInput = '0';
      previousValue = 0;
      operation = '';
      isNewInput = true;
    });
  }

  Widget buildButton(String text, Function() onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue.shade200,
        shape: CircleBorder(),
        padding: EdgeInsets.all(20),
      ),
      child: Text(
        text,
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculator'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            width:
                double.infinity, // make the container stretch across the screen
            color: Colors.blue, // background color for the title bar
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'LFX CALCULATOR',
              textAlign: TextAlign.center,
              style: GoogleFonts.roboto(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerRight,
            child: Text(
              currentInput,
              style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
            ),
          ),
          Divider(),
          Expanded(
            child: GridView.count(
              crossAxisCount: 4,
              children: <Widget>[
                buildButton('7', () => inputNumber('7')),
                buildButton('8', () => inputNumber('8')),
                buildButton('9', () => inputNumber('9')),
                buildButton('%', () => selectOperation('%')),
                buildButton('4', () => inputNumber('4')),
                buildButton('5', () => inputNumber('5')),
                buildButton('6', () => inputNumber('6')),
                buildButton('x', () => selectOperation('x')),
                buildButton('1', () => inputNumber('1')),
                buildButton('2', () => inputNumber('2')),
                buildButton('3', () => inputNumber('3')),
                buildButton('-', () => selectOperation('-')),
                buildButton('0', () => inputNumber('0')),
                buildButton('C', clear), // Clear button
                buildButton('=', calculateResult), // Equals button
                buildButton('+', () => selectOperation('+')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
