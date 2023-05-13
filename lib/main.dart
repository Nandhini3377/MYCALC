import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Color ap = Colors.deepPurple.shade500;
  String usertext = '';
  String result = '';

  //buttons List
  final List<String> buttons = [
    'C',
    '^',
    '%',
    'DEL',
    '1',
    '2',
    '3',
    '+',
    '4',
    '5',
    '6',
    '-',
    '7',
    '8',
    '9',
    '*',
    '0',
    '.',
    '=',
    '/',
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: Scaffold(
      appBar: AppBar(
        backgroundColor: ap,
        title: Text('MyCalc'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.all(20),
                    child: Text(
                    usertext,
                      style: TextStyle(
                          fontSize: 22, color: Colors.black),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 40),
                    alignment: Alignment.centerRight,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      result,
                      style: TextStyle(
                          fontSize: 35, color: Colors.deepPurple),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              child: GridView.builder(
                itemCount: buttons.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return Button(
                        buttonText: buttons[index],
                        color: ap,
                        buttontapped: () {
                          setState(() {
                            usertext = '';
                            result = '0';
                          });
                        },
                      );
                    }
                    else if (index == 1) {
                      return Button(
                        buttontapped: () {
                          setState(() {
                            usertext += buttons[index];
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.deepPurple.shade100,
                        textColor: Colors.black,
                      );
                    }
                    else if (index == 2) {
                      return Button(
                        buttontapped: () {
                          setState(() {
                            usertext += buttons[index];
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.deepPurple.shade100,
                        textColor: Colors.black,
                      );
                    }

                    else if (index == 3) {
                      return Button(
                        buttontapped: () {
                          setState(() {
                            usertext =
                                usertext.substring(0, usertext.length - 1);
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.deepPurple.shade500,
                        textColor: Colors.black,
                      );
                    }
                    else if (index == 18) {
                      return Button(
                        buttontapped: () {
                          setState(() {
                            equalPressed();
                          });
                        },
                        buttonText: buttons[index],
                        color: Colors.deepPurple.shade700,
                        
                      );
                    }
                    else {
                      return Button(
                        buttontapped: () {
                          setState(() {
                            usertext += buttons[index];
                          });
                        },
                        buttonText: buttons[index],
                        color: isOperator(buttons[index])
                            ? Colors.deepPurple.shade100
                            : Colors.deepPurple.shade300,
                        textColor: isOperator(buttons[index])
                            ? Colors.black
                            : Colors.black,
                      );
                    }
                  }),
            ),
          )
        ],
      ),
    ));
  }

  void equalPressed() {
    String finaluserinput = usertext;
    //finaluserinput = usertext.replaceAll('x', '*');
 
    Parser p = Parser();
    Expression exp = p.parse(finaluserinput);
    ContextModel cm = ContextModel();
    double eval = exp.evaluate(EvaluationType.REAL, cm);
    result = eval.toString();
  }
}
 bool isOperator(String x) {
    if (x == '/' || x == '*' || x == '-' || x == '+' || x == '=') {
      return true;
    }
    return false;
  }
 

class Button extends StatelessWidget {
  // declaring variables
  final color;
  final textColor;
  final String buttonText;
  final buttontapped;

  //Constructor
  Button(
      {this.color,
      this.textColor,
      required this.buttonText,
      this.buttontapped});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttontapped,
      child: Padding(
        padding: const EdgeInsets.all(0.2),
        child: ClipRRect(
          // borderRadius: BorderRadius.circular(25),
          child: Container(
            decoration: BoxDecoration(
              color: color,
             
             // borderRadius: BorderRadius.circular(70),
            ),
            
            child: Center(
              child: Text(
                buttonText,
                style: TextStyle(
                  color: textColor,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
