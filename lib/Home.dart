import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz_app_flutter/GetJson.dart';
import 'package:quiz_app_flutter/constants/SizeConfig.dart';

class homepage extends StatefulWidget {
  @override
  _homepageState createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  List<String> images = [
    "images/flutter.png",
    // "images/java.png",
    // "images/js.png",
    // "images/cpp.png",
    // "images/linux.png",
  ];

  String des =
      "Flutter is a cross-platform UI toolkit that is designed to allow code reuse across operating systems such as iOS and Android, while also allowing applications to interface directly with underlying platform services. ... The rendering process: How Flutter turns UI code into pixels.";

  Widget customcard(String name, String image, String des) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: SizeConfig.blockSizeVertical * 2.5,
        horizontal: SizeConfig.blockSizeHorizontal * 6,
      ),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => getjson(),
          ));
        },
        child: Material(
          color: Color(0xFFcfd8dc),
          elevation: 5.0,
          borderRadius: BorderRadius.circular(SizeConfig.blockSizeVertical * 2),
          child: Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: SizeConfig.blockSizeVertical * 4,
                  ),
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(
                        SizeConfig.blockSizeHorizontal * 10),
                    child: Container(
                      height: SizeConfig.blockSizeVertical * 18,
                      width: SizeConfig.blockSizeHorizontal * 35,
                      child: ClipOval(
                        child: Image(
                          fit: BoxFit.cover,
                          image: AssetImage(
                            image,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Center(
                  child: Text(
                    name,
                    style: TextStyle(
                      fontSize: SizeConfig.blockSizeHorizontal * 6,
                      color: Colors.black,
                      fontFamily: "Quando",
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(SizeConfig.blockSizeHorizontal * 3),
                  child: Text(
                    des,
                    style: TextStyle(
                        fontSize: SizeConfig.blockSizeHorizontal * 5,
                        color: Colors.black,
                        fontFamily: "Alike"),
                    maxLines: 5,
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Quiz",
          style: TextStyle(
            fontFamily: "Quando",
          ),
        ),
      ),
      body: ListView(
        children: <Widget>[
          customcard("Flutter", images[0], des),
        ],
      ),
    );
  }
}
