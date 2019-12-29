import 'package:flutter/material.dart';
import 'package:imadmin/api/imadminapi.dart';
import 'package:imadmin/models/user.dart';
import 'package:imadmin/screens/dashboard.dart';
import 'package:imadmin/screens/loginpage.dart';
import 'package:imadmin/utils/admincolors.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  
  var _user=MonsterAdminApi().getUser();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'InspiredMonster Admin',
      theme: ThemeData(
        primarySwatch: AdminColors.primaryBlack,
      ),
      home: new Scaffold(body: FutureBuilder(
        future: _user,
        builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
          if(snapshot.hasData){
            if(snapshot.data!=null){
              return DashBoard();
            }else{
              return LoginPage(title: 'IM Admin');
            }
           
          }else{
           return LoginPage(title: 'IM Admin');
          }
          
        },
      )),
    );
  }
}


