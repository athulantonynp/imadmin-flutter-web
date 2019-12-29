import 'package:flutter/material.dart';
import 'package:imadmin/screens/home.dart';
import 'package:imadmin/utils/admincolors.dart';
import 'package:imadmin/widgets/appdrawer.dart';
import 'package:imadmin/widgets/monsterbar.dart';

class DashBoard extends StatefulWidget {
  DashBoard({Key key}) : super(key: key);
  @override
  DashBoardState createState() => DashBoardState();
}



class DashBoardState extends State<DashBoard>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MonsterBar(true),
      body: Container(
        color: AdminColors.fromHex("#212121"),
        child: Home(),
      ),
      drawer:  AppDrawer().getDrawer(),
    );
  }

}

