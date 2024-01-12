// ignore_for_file: sort_child_properties_last, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ignore: prefer_const_constructors
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Calculator(),
    );
  }
}

class Calculator extends StatefulWidget {
  const Calculator({super.key});

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  Widget calcubutton(String btntext, Color btncolor, Color textcolor) {
    return Container(
      child: ElevatedButton(
        onPressed: (() {
          calculation(btntext);
        }),
        child: Text(
          btntext,
          style: TextStyle(fontSize: 35, color: textcolor),
        ),
        style: ElevatedButton.styleFrom(
            backgroundColor: btncolor,
            fixedSize: const Size(87, 87),
            shape: const CircleBorder(),
            padding: const EdgeInsets.all(20)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'Calculator',
        ),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      text,
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.white, fontSize: 100),
                    ))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcubutton('AC', Colors.grey, Colors.black),
                calcubutton('+/-', Colors.grey, Colors.black),
                calcubutton('%', Colors.grey, Colors.black),
                calcubutton('/', Colors.amber.shade700, Colors.white),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcubutton('7', Colors.grey.shade800, Colors.white),
                calcubutton('8', Colors.grey.shade800, Colors.white),
                calcubutton('9', Colors.grey.shade800, Colors.white),
                calcubutton('*', Colors.amber.shade700, Colors.white),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcubutton('4', Colors.grey.shade800, Colors.white),
                calcubutton('5', Colors.grey.shade800, Colors.white),
                calcubutton('6', Colors.grey.shade800, Colors.white),
                calcubutton('-', Colors.amber.shade700, Colors.white),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcubutton('1', Colors.grey.shade800, Colors.white),
                calcubutton('2', Colors.grey.shade800, Colors.white),
                calcubutton('3', Colors.grey.shade800, Colors.white),
                calcubutton('+', Colors.amber.shade700, Colors.white),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: (() {}),
                    child: Text(
                      "0",
                      style: TextStyle(fontSize: 35, color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                        shape: StadiumBorder(),
                        backgroundColor: Colors.grey.shade800,
                        padding: EdgeInsets.fromLTRB(34, 20, 128, 20))),
                calcubutton('.', Colors.grey.shade800, Colors.white),
                calcubutton('=', Colors.amber.shade700, Colors.white),
              ],
            ),
          ],
        ),
      ),
    );
  }

  dynamic text = '0';
  double numOne = 0;
  double numTwo = 0;

  dynamic result = '';
  dynamic finalresult = '';
  dynamic operator = '';
  dynamic preoperator = '';

  void calculation(btntext) {
    if (btntext == 'AC') {
      text = '0';
      numOne = 0;
      numTwo = 0;
      result = '';
      finalresult = '0';
      operator = '';
      preoperator = '';
    } else if (btntext == '+' ||
        btntext == '-' ||
        btntext == '*' ||
        btntext == '/' ||
        btntext == '=') {
      if (numOne == 0) {
        numOne = double.parse(result);
      } else {
        numTwo = double.parse(result);
      }
      if (operator == '+') {
        finalresult = add();
      } else if (operator == '-') {
        finalresult = sub();
      } else if (operator == '*') {
        finalresult = mul();
      } else if (operator == '/') {
        finalresult = div();
      }
      preoperator = operator;
      operator = btntext;
      result = '';
    } else if (btntext == '%') {
      result = numOne / 100;
      finalresult = containDecimal(result);
    } else if (btntext == '. ') {
      if (!result.toString().contains('.')) {
        result = result.toString() + '.';
      }
      finalresult = result;
    } else if (btntext == '+/-') {
      result.toString().startsWith('-')
          ? result = result.toString().substring(1)
          : result = '-' + result.toString();
    } else {
      result = result + btntext;
      finalresult = result;
    }

    setState(() {
      text = finalresult;
    });
  }

  String add() {
    result = (numOne + numTwo).toString();
    numOne = double.parse(result);
    return containDecimal(result);
  }

  String sub() {
    result = (numOne - numTwo).toString();
    numOne = double.parse(result);
    return containDecimal(result);
  }

  String mul() {
    result = (numOne * numTwo).toString();
    numOne = double.parse(result);
    return containDecimal(result);
  }

  String div() {
    result = (numOne / numTwo).toString();
    numOne = double.parse(result);
    return containDecimal(result);
  }

  String containDecimal(dynamic result) {
    if (result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if (!(int.parse(splitDecimal[1]) > 0)) {
        return result = splitDecimal[0].toString();
      }
    }
    return result;
  }
}
