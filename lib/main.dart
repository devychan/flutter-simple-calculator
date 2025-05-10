import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dart_eval/dart_eval.dart';
import 'package:sample_flutter/buttons.dart';

void main() {
  runApp(const Home(title: 'My app'));
}

class Home extends StatelessWidget {
  const Home({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            backgroundColor: Color.fromRGBO(25, 28, 34, 1),
            appBar: AppBar(
                toolbarHeight: 10,
                backgroundColor: Color.fromRGBO(25, 28, 34, 1)),
            body: const App()));
  }
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => AppState();
}

class AppState extends State<App> {
  String input = "0";
  String expression = "0";
  dynamic result = 0;

  void _clear() {
    setState(() {
      result = 0;
      input = "0";
      expression = "0";
    });
  }

  String _formatNumber(String value) {
    if (value is num) {
      final formatter = NumberFormat("#,##0.##");
      return formatter.format(value);
    }
    return "Syntax Error";
  }

  void _click(String text) {
    final List<String> operators = [
      Button.add,
      Button.minus,
      Button.multiply,
      Button.divide,
      Button.modulos,
      Button.dot
    ];
    if (text == Button.clear) {
      _clear();
      return;
    }
    if (text == Button.delete) {
      setState(() {
        if (input.length == 1) {
          input = "0";
          expression = "0";
          result = 0;
        } else {
          final index = input.length - 1;
          final suffix = index == -1 ? 0 : index;

          final indexExpression = expression.length - 1;
          final suffixExpression = indexExpression == -1 ? 0 : indexExpression;
          input = input.substring(0, suffix);
          expression = expression.substring(0, suffixExpression);
        }
      });
      return;
    }
    if (text == Button.result) {
      setState(() {
        input = "$result";
        expression = "$result";
      });
      return;
    }

    int index = input.length - 1;
    String last = input[index];

    if (index == -1) {
      setState(() {
        input = "0";
        expression = "0";
      });
      return;
    }

    // Check if input is operator
    if (operators.contains(text)) {
      /**
       * Check if display text last character is operator also
       * otherwise, set the new operator
       * 1234+
       *     ^
       *     - is operator
       */
      dynamic isNum = int.tryParse(last);
      if (!operators.contains(last)) {
        setState(() {
          if (text == Button.minus && isNum == false) {
            input = text;
          } else {
            input += text;
          }
        });
      } else {
        final display = "${input.substring(0, index)}$text";
        setState(() {
          input = display;
        });
      }
      setState(() {
        expression = input
            .replaceAll('*', Button.display[Button.multiply])
            .replaceAll('/', Button.display[Button.divide]);
      });
      print('Symbol: $input');
    } else {
      setState(() {
        if (input == Button.zero) {
          input = text;
        } else {
          input += text;
        }
        final dynamic resultExpression = eval(input);
        if (resultExpression is num) {
          result = resultExpression % 1 == 0
              ? resultExpression.toInt()
              : resultExpression;
        } else {
          result = "Syntax Error";
        }
        expression = input
            .replaceAll('*', Button.display[Button.multiply])
            .replaceAll('/', Button.display[Button.divide]);
      });
    }
  }

  Widget _widgetButton(String label) {
    return Expanded(
      child: SizedBox(
        height: 80,
        child: TextButton(
          style: TextButton.styleFrom(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
            overlayColor: Color.fromRGBO(25, 27, 32, 1),
          ),
          onPressed: () => _click(label),
          child: Text(Button.display[label] ?? label,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, color: Colors.white)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Container(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Expanded(
                    child: Text(expression,
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize:
                                _formatNumber(result.toString()).length > 15
                                    ? 24
                                    : 40)))
              ],
            )),
        Container(
          color: Color.fromRGBO(38, 41, 49, 1),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children:
                    Button.row1.map((value) => _widgetButton(value)).toList(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children:
                    Button.row2.map((value) => _widgetButton(value)).toList(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children:
                    Button.row3.map((value) => _widgetButton(value)).toList(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children:
                    Button.row4.map((value) => _widgetButton(value)).toList(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children:
                    Button.row5.map((value) => _widgetButton(value)).toList(),
              ),
            ],
          ),
        )
      ],
    );
  }
}
