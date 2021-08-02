import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz_app_flutter/constants/SizeConfig.dart';
import 'package:quiz_app_flutter/resultpage.dart';

class quizpage extends StatefulWidget {
  final List mydata;
  quizpage({Key key, @required this.mydata}) : super(key: key);
  @override
  _quizpageState createState() => _quizpageState(mydata);
}

class _quizpageState extends State<quizpage> {
  final List mydata;
  _quizpageState(this.mydata);
  Color colortoshow = Colors.indigoAccent;
  Color right = Colors.green;
  Color wrong = Colors.red;
  int marks = 0;
  int i = 1;
  bool disableAnswer = false;
  // extra varibale to iterate
  int j = 1;
  int timer = 10;
  String showtimer = "10";


  Map<String, Color> btncolor = {
    "a": Colors.blueGrey,
    "b": Colors.blueGrey,
    "c": Colors.blueGrey,
    "d": Colors.blueGrey,
  };

  bool canceltimer = false;
 
  // overriding the initstate function to start timer as this screen is created
  @override
  void initState() {
    starttimer();
    super.initState();
  }

  // overriding the setstate function to be called only if mounted
  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  void starttimer() async {
    const onesec = Duration(seconds: 1);
    Timer.periodic(onesec, (Timer t) {
      setState(() {
        if (timer < 1) {
          t.cancel();
          nextquestion();
        } else if (canceltimer == true) {
          //when user press the choice option.
          t.cancel();
        } else {
          timer = timer - 1;
        }
        showtimer = timer.toString();
      });
    });
  }

  void nextquestion() {
    canceltimer = false;
    timer = 10;
    setState(() {
      if (j < 10) {
        j++;
        i = j;
        
      } else {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => resultpage(marks: marks),
        ));
      }
      btncolor["a"] = Colors.blueGrey;
      btncolor["b"] = Colors.blueGrey;
      btncolor["c"] = Colors.blueGrey;
      btncolor["d"] = Colors.blueGrey;
      disableAnswer = false;
    });
    starttimer();
  }

  void checkanswer(String k) {
    if (widget.mydata[2][i.toString()] == widget.mydata[1][i.toString()][k]) {
      marks = marks + 5;
      // changing the color variable to be green
      setState(() {
        colortoshow = right;
      });
    } else if (widget.mydata[2][i.toString()] !=
        widget.mydata[1][i.toString()][k]) {
      colortoshow = wrong;
      String realAns = widget.mydata[2][i.toString()].toString();
      if (realAns == widget.mydata[1][i.toString()]['a']) {
        //ans is a
        print('ans  = a');
        setState(() {
          setState(() {
            // applying the changed color to the particular button that was selected
            btncolor[k] = colortoshow;
            btncolor['a'] = Colors.green;
            canceltimer = true;
            disableAnswer = true;
          });
        });
      } else if (realAns == widget.mydata[1][i.toString()]['b']) {
        //ans is b
        print('ans  = b');
        setState(() {
          // applying the changed color to the particular button that was selected
          btncolor[k] = colortoshow;
          btncolor['b'] = Colors.green;
          canceltimer = true;
          disableAnswer = true;
        });
      } else if (realAns == widget.mydata[1][i.toString()]['c']) {
        //and is c
        print('ans  = c');
        setState(() {
          // applying the changed color to the particular button that was selected
          btncolor[k] = colortoshow;
          btncolor['c'] = Colors.green;
          canceltimer = true;
          disableAnswer = true;
        });
      } else {
        //and is d
        print('ans  = d');
        setState(() {
          // applying the changed color to the particular button that was selected
          btncolor[k] = colortoshow;
          btncolor['d'] = Colors.green;
          canceltimer = true;
          disableAnswer = true;
        });
      }
    }

    setState(() {
      // applying the changed color to the particular button that was selected
      btncolor[k] = colortoshow;
      canceltimer = true;
      disableAnswer = true;
    });
    // nextquestion();
    // changed timer duration to 1 second
    Timer(Duration(seconds: 1), nextquestion);
  }

  Widget choicebutton(String k) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: SizeConfig.blockSizeVertical,
        horizontal: SizeConfig.blockSizeHorizontal * 3.3,
      ),
      child: MaterialButton(
        onPressed: () => checkanswer(k),
        child: Text(
          mydata[1][i.toString()][k],
          style: TextStyle(
            color: Colors.black,
            fontFamily: "Alike",
            fontSize: SizeConfig.blockSizeVertical * 1.8,
          ),
          maxLines: 1,
        ),
        color: btncolor[k],
        minWidth: SizeConfig.blockSizeHorizontal * 70,
        height: SizeConfig.blockSizeVertical * 6,
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(SizeConfig.blockSizeVertical * 1.2),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    return WillPopScope(
      onWillPop: () {
        return showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text(
                    "Quiz",
                  ),
                  content: Text("You Can't Go Back At This Stage."),
                  actions: <Widget>[
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Ok',
                      ),
                    )
                  ],
                ));
      },
      child: Scaffold(
        body: Column(
          children: <Widget>[
            Expanded(
              flex: 5,
              child: Container(
                padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 4),
                alignment: Alignment.bottomCenter,
                child: Text(
                  mydata[0][i.toString()],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: SizeConfig.blockSizeVertical * 2,
                    fontFamily: "Quando",
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: AbsorbPointer(
                absorbing: disableAnswer,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      choicebutton('a'),
                      choicebutton('b'),
                      choicebutton('c'),
                      choicebutton('d'),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                alignment: Alignment.topCenter,
                child: Center(
                  child: Text(
                    showtimer,
                    style: TextStyle(
                      fontSize: SizeConfig.blockSizeVertical * 2.8,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Times New Roman',
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
