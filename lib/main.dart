import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const Calculator());
}

class Calculator extends StatelessWidget {
  const Calculator({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Calculator App',
      home: CalculatorApp(),
    );
  }
}

class CalculatorApp extends StatefulWidget {
  const CalculatorApp({super.key});

  @override
  State<CalculatorApp> createState() => CalculatorAppState();
}

final ButtonStyle flatButtonStyle = TextButton.styleFrom(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(0.0),
    ),
    padding: const EdgeInsets.all(16.0));

class CalculatorAppState extends State<CalculatorApp> {
  String equationField = "0";
  String resultField = "0";
  String expression = "";
  double changeEquationFont = 40;
  double changeResultFont = 50;

  void actionButton(String buttonPressed) {
    setState(() {
      if (buttonPressed == "C") {
        equationField = "0";
        resultField = "0";
        changeEquationFont = 40;
        changeResultFont = 50;
      } else if (buttonPressed == "⌫") {
        changeEquationFont = 50;
        changeResultFont = 40;
        equationField = equationField.substring(0, equationField.length - 1);
        if (equationField == "") {
          equationField = "0";
        }
      } else if (buttonPressed == "=") {
        changeEquationFont = 40;
        changeResultFont = 50;

        expression = equationField;
        expression = expression.replaceAll('×', "*");
        expression = expression.replaceAll('÷', "/");

        try {
          Parser parser = Parser();
          Expression exp = parser.parse(expression);

          ContextModel contextModel = ContextModel();
          resultField = '${exp.evaluate(EvaluationType.REAL, contextModel)}';
        } catch (e) {
          resultField = "SYNTAX ERROR";
        }
      } else {
        if (equationField == "0") {
          changeEquationFont = 50;
          changeResultFont = 40;
          equationField = buttonPressed;
        } else {
          equationField = equationField + buttonPressed;
        }
      }
    });
  }

  Widget buildButton(String buttonPressed, double buttonHeight, Color buttonColor, Color textColor) {
    return Container(
      height: MediaQuery.of(context).size.height * .1 * buttonHeight,
      color: buttonColor,
      child: TextButton(
        style: flatButtonStyle,
        onPressed: () {
          actionButton(buttonPressed);
        },
        child: Text(buttonPressed,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.normal,
              color: textColor,
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text("Calculator App by John Patrick M. Salangsang",
                style: TextStyle(
                    color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15)),
            backgroundColor: Colors.green),
        body: Material(
            color: Colors.black,
            child: Column(
              children: <Widget> [
                Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.fromLTRB(10, 50, 10, 0),
                  child: Text(
                    equationField,
                    style: TextStyle(
                        fontSize: changeEquationFont, color: Colors.white),
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.fromLTRB(10, 30, 10, 0),
                  child: Text(
                    resultField,
                    style: TextStyle(
                        fontSize: changeResultFont, color: Colors.white),
                  ),
                ),

                const Expanded(
                  child: Divider()
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget> [
                    Container(
                        width: MediaQuery.of(context).size.width * .75,
                        child: Table(
                          children: [
                            TableRow(children: [
                              buildButton(
                                  "C", 1, Colors.black87, Colors.green),
                              buildButton(
                                  "⌫", 1, Colors.black87, Colors.green),
                              buildButton("÷", 1, Colors.black87, Colors.green),
                            ]),
                            TableRow(children: [
                              buildButton("7", 1, Colors.black87, Colors.white),
                              buildButton("8", 1, Colors.black87, Colors.white),
                              buildButton("9", 1, Colors.black87, Colors.white),
                            ]),
                            TableRow(children: [
                              buildButton("4", 1, Colors.black87, Colors.white),
                              buildButton("5", 1, Colors.black87, Colors.white),
                              buildButton("6", 1, Colors.black87, Colors.white),
                            ]),
                            TableRow(children: [
                              buildButton("1", 1, Colors.black87, Colors.white),
                              buildButton("2", 1, Colors.black87, Colors.white),
                              buildButton("3", 1, Colors.black87, Colors.white),
                            ]),
                            TableRow(children: [
                              buildButton("%", 1, Colors.black87, Colors.white),
                              buildButton("0", 1, Colors.black87, Colors.white),
                              buildButton(".", 1, Colors.black87, Colors.white),
                            ])
                          ],
                        )
                      ),

                    Container(
                        width: MediaQuery.of(context).size.width * .25,
                        child: Table(
                          children: [
                            TableRow(children: [
                              buildButton("×", 1, Colors.black87, Colors.green),
                            ]),
                            TableRow(children: [
                              buildButton("-", 1, Colors.black87, Colors.green),
                            ]),
                            TableRow(children: [
                              buildButton("+", 1, Colors.black87, Colors.green),
                            ]),
                            TableRow(children: [
                              buildButton("=", 2, Colors.black87, Colors.green),
                            ])
                          ],
                        )
                      )
                  ],
                )
              ],
            )
          )
        );
  }
}