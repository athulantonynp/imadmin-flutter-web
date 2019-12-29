import 'package:flutter/material.dart';
import 'package:imadmin/utils/admincolors.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: AdminColors.fromHex("#212121"),
      )
    );
  }

}