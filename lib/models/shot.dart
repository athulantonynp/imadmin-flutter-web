import 'dart:convert';

import 'package:imadmin/models/shotimage.dart';

class Shot{
  final String title;
  final String published_at;
  final ShotImage images;

  
  Shot({this.title,this.published_at,this.images});

  factory Shot.fromJson(Map<String, dynamic> jsonResponse){


    var list=ShotImage.fromJson(json.decode(jsonResponse['images']));

    var shot=Shot(title: jsonResponse['title'],published_at: jsonResponse['published_at'],images: list);
    return shot ;
  }
}