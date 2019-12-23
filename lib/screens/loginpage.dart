import 'package:flutter/material.dart';
import 'package:imadmin/utils/admincolors.dart';



class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        color: AdminColors.fromHex("#212121"),
        alignment:Alignment(0.0, 0.0) ,
        child: Container(
          width: 500,
          height: 500,
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
                TextField(decoration: InputDecoration(border: InputBorder.none,hintText: 'Username',contentPadding: EdgeInsets.all(20) ),),
                TextField(decoration: InputDecoration(border: InputBorder.none,hintText: 'Password',contentPadding: EdgeInsets.all(20) ),),
                RaisedButton(onPressed: (){},child: Text('Login',style: TextStyle(fontSize: 20) ),
        )
            ],
          ),
        ),
        ),
      )
    );
  }
}