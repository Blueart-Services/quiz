import 'package:flutter/material.dart';

import '../model/model.dart';

class QuizApp extends StatefulWidget {
  QuizApp({Key key}) : super(key: key);

  @override
  _QuizAppState createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  int _currentQuestionIndex = 0;
  Color bgColor = Colors.deepOrange.shade300;
  Color txtColor = Colors.white;
  TextStyle txtStyle = TextStyle(
    color: Colors.white,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
  List<Question> questionBank = [
    Question.name(
      "Essay exams are easier to construct than are objective exams.",
      true,
    ),
    Question.name(
      "Essay exams require more thorough student preparation and study time than objective exams.",
      false,
    ),
    Question.name(
      "Essay exams require writing skills where objective exams do not.",
      true,
    ),
    Question.name(
      "Essay exams teach a person how to write.",
      false,
    ),
    Question.name(
      "Essay exams are more subjective in nature than are objective exams.",
      true,
    ),
    Question.name(
      "Objective exams encourage guessing more so than essay exams.",
      true,
    ),
    Question.name(
      "Essay exams limit the extent of content covered.",
      true,
    ),
    Question.name(
      "Essay and objective exams can be used to measure the same content or ability.",
      false,
    ),
    Question.name(
      "Essay and objective exams are both good ways to evaluate a student's level of knowledge.",
      false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Questions",
          style: txtStyle,
        ),
        backgroundColor: bgColor,
        centerTitle: true,
      ),
      backgroundColor: bgColor,
      body: Builder(
        builder: (BuildContext context) => Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //Question Container
              Container(
                alignment: Alignment.center,
                height: 120,
                margin: EdgeInsets.all(25.0),
                decoration: BoxDecoration(
                  //color: txtColor,
                  borderRadius: BorderRadius.circular(25.0),
                  border: Border.all(
                    color: txtColor,
                    style: BorderStyle.solid,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "${_currentQuestionIndex + 1}- " +
                        "${questionBank[_currentQuestionIndex].questionText}",
                    textAlign: TextAlign.center,
                    style: txtStyle,
                  ),
                ),
              ),
              //Option Container
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //True Button
                  buildFlatButton(
                      "True", Icons.check, () => _checkAnswer(true, context)),
                  //True Button
                  buildFlatButton(
                      "False", Icons.close, () => _checkAnswer(false, context)),
                  //Next Button
                  buildFlatButton("Next", Icons.navigate_next, _nextQuestion),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  //Custom Flat Button
  FlatButton buildFlatButton(
      String btnText, IconData iconData, Function selectMethod) {
    return FlatButton.icon(
      onPressed: selectMethod,
      icon: Icon(iconData),
      label: Text(
        btnText,
        style: txtStyle,
      ),
    );
  }

  //Method Check Answer
  _checkAnswer(bool userChoice, BuildContext context) {
    final ScaffoldMessengerState scaffoldMessenger =
        ScaffoldMessenger.of(context);

    if (userChoice == questionBank[_currentQuestionIndex].isCorrect) {
      scaffoldMessenger.showSnackBar(
        SnackBar(
          content: Text(
            'Correct Answer',
            style: txtStyle,
          ),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 1),
        ),
      );
      setState(() {
        _currentQuestionIndex++;
      });
    } else {
      scaffoldMessenger.showSnackBar(
        SnackBar(
          content: Text(
            'Wrong Answer',
            style: txtStyle,
          ),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 1),
        ),
      );
    }
  }

//Method Next
  _nextQuestion() {
    setState(() {
      _currentQuestionIndex = (_currentQuestionIndex + 1) % questionBank.length;
    });
  }
}
