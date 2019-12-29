import 'dart:html';

import 'package:flutter/material.dart';
import 'package:imadmin/api/apiconstants.dart';
import 'package:imadmin/api/imadminapi.dart';
import 'package:imadmin/screens/dashboard.dart';
import 'package:imadmin/utils/admincolors.dart';
import 'package:imadmin/widgets/monsterbar.dart';
import 'package:page_transition/page_transition.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  bool _isLoggingLoading=false;
  final userNameController=TextEditingController();
  final passwordController=TextEditingController();

  void _performLogin(BuildContext context) async{

    setState(() {_isLoggingLoading=true; });
    var api=MonsterAdminApi();
    api.performLogin(userNameController.text,passwordController.text).then((value)=>{
       
        if(value==ApiConstants.ERROR_STRING){
            _displaySnackBar(context, value)
        }else{
            Navigator.pushAndRemoveUntil(context, PageTransition(type: PageTransitionType.fade, 
            child: DashBoard()),(e) => false)
        }
    });
    
  }

  _displaySnackBar(BuildContext context,String message) {
    final snackBar = SnackBar(content: Text(message));
    Scaffold.of(context).showSnackBar(snackBar);
     setState(() {_isLoggingLoading=false; });
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar:MonsterBar(false),
      body: Container(
        color: AdminColors.fromHex("#212121"),
        alignment:Alignment(0.0, 0.0) ,
        child: Container(
          width: 400,
          height: 400,
          child: new Card(
           semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          color: Colors.white,
          elevation: 8,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0) ),
          margin: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[

                Text("Login as user",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
               Padding(
                 padding: EdgeInsets.fromLTRB(50,20, 50, 0),
                 child:  TextField(
                   controller: userNameController,
                  decoration: InputDecoration(
                  border:const OutlineInputBorder( borderSide: const BorderSide(color: Colors.grey, width: 1.0))
                  ,labelText: "Username",
                  contentPadding: EdgeInsets.all(20))
                  ),
               ),
                Padding(
                 padding:EdgeInsets.fromLTRB(50, 20, 50, 20),
                 child:  TextField(
                   controller: passwordController,
                  decoration: InputDecoration(
                  border:const OutlineInputBorder( borderSide: const BorderSide(color: Colors.grey, width: 1.0))
                  ,labelText: "Password",contentPadding: EdgeInsets.all(20)),
                  obscureText: true,
                  ),
               ),
              _isLoggingLoading ? CircularProgressIndicator() : RaisedButton(onPressed: (){
                  _performLogin(context);
                },child: Text('Login',style: TextStyle(fontSize: 20)),splashColor: Colors.lightBlueAccent,
                elevation: 4,)
                 
        ],
        ),
      )
    )));
  }

    @override
  void dispose() {
    userNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}