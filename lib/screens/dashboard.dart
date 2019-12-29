import 'package:flutter/material.dart';
import 'package:imadmin/api/imadminapi.dart';
import 'package:imadmin/models/user.dart';
import 'package:imadmin/screens/home.dart';
import 'package:imadmin/utils/admincolors.dart';
import 'package:imadmin/widgets/appdrawer.dart';
import 'package:imadmin/widgets/monsterbar.dart';

import 'loginpage.dart';

class DashBoard extends StatefulWidget {
  DashBoard({Key key}) : super(key: key);
  @override
  DashBoardState createState() => DashBoardState();
}



class DashBoardState extends State<DashBoard>{

  var _user=MonsterAdminApi().getUser();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MonsterBar(true),
      body: Container(
        color: AdminColors.fromHex("#212121"),
        child: FutureBuilder(
        future: _user,
        builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
          if(snapshot.hasData){
            if(snapshot.data!=null){
              return Home(snapshot.data);
            }
          }else{
           return LoginPage(title: 'IM Admin');
          }
          
        },
      ),
      ),
      drawer:  AppDrawer().getDrawer(),
    );
  }

}

