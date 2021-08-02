import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:quiz_app_flutter/QuizPage.dart';

class getjson extends StatelessWidget {
  String assettoload;

  // a function
  // sets the asset to a particular JSON file
  // and opens the JSON
  setasset() {
    assettoload = "assets/python.json";
  }

  @override
  Widget build(BuildContext context) {
    // this function is called before the build so that
    // the string assettoload is avialable to the DefaultAssetBuilder
    setasset();
    // and now we return the FutureBuilder to load and decode JSON
    return FutureBuilder(
      future:
          DefaultAssetBundle.of(context).loadString(assettoload, cache: false),
      builder: (context, snapshot) {
        List mydata = json.decode(snapshot.data.toString());
        if (mydata != null) {
          return quizpage(mydata: mydata);
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}
