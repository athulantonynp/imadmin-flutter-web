
import 'dart:convert';

class User{

  final String userName;
  final String name;
  final String pass;

  User({this.userName,this.pass,this.name});

  factory User.parse(Map<String,dynamic> json,String pass){

    return User(
      userName: json['username'],
      pass: pass,
      name: json['name']
    );
  }


  factory User.fromJson(Map<String,dynamic> json){

    return User(
      userName: json['username'],
      pass: json['pass'],
      name: json['name']
    );
  }

 Map<String, dynamic> toJson(){
    return {
      'username':userName,
      'pass':pass,
      'name':name
    };
  }
}