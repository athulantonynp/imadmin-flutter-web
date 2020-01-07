import 'dart:convert';

import 'package:imadmin/models/shotimage.dart';

class Shot{
  final String title;
  final DateTime published_at;
  final ShotImage images;
  final int id;
  bool isSelected=false;
  
  
  Shot({this.title,this.published_at,this.images,this.id});

  factory Shot.fromJson(Map<String, dynamic> jsonResponse){

    var imageList=jsonResponse['images'];
    var list=ShotImage.fromJson(imageList);

    var shot=Shot(title: jsonResponse['title'],published_at: DateTime.parse(jsonResponse['published_at']),images: list,
    id: jsonResponse['id']);
    return shot ;
  }

  Map<String,dynamic> toJson(){
    return {
      "title": this.title,
      "published_at": this.published_at.toIso8601String(),
      "id": this.id,
      "images": this.images.toJson()
    };
  }

  bool contains(Shot element) {
    return element.id==this.id;
  }
}