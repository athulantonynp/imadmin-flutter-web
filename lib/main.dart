import 'package:flutter/material.dart';
import 'package:imadmin/screens/loginpage.dart';
import 'package:imadmin/utils/admincolors.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'InspiredMonster Admin',
      theme: ThemeData(
        primarySwatch: AdminColors.primaryBlack,
      ),
      home: LoginPage(title: 'IM Admin'),
    );
  }
}


