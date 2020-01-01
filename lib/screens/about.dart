import 'package:flutter/material.dart';
import 'package:imadmin/utils/admincolors.dart';

class About extends StatefulWidget {
  About({Key key}) : super(key: key);

  @override
  AboutState createState() => AboutState();
}

class AboutState extends State<About>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AdminColors.fromHex("#212121"),
        body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                getTitle()
                
              ],
            ),
        ));
  }

  Padding getTitle() {
    return Padding(
        padding: EdgeInsets.fromLTRB(32, 24, 24, 16),
        child: RichText(
          text: TextSpan(
            text: 'About',
            style: TextStyle(color: Colors.white, fontSize: 16),
            children: <TextSpan>[
              TextSpan(
                  text:"" ,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26))
            ],
          ),
        ));
  }

}