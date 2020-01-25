import 'dart:convert';

import 'package:imadmin/models/shotimage.dart';

class Shot {
  final String title;
  final DateTime published_at;
  final ShotImage images;
  final int id;
  bool isSelected = false;
  final String description;

  Shot({this.title, this.published_at, this.images, this.id, this.description});

  factory Shot.fromJson(Map<String, dynamic> jsonResponse) {
    var imageList = jsonResponse['images'];
    var list = ShotImage.fromJson(imageList);

    var shot = Shot(
        title: jsonResponse['title'],
        published_at: DateTime.parse(jsonResponse['published_at']),
        images: list,
        id: jsonResponse['id'],
        description: jsonResponse['description']);
    return shot;
  }

  Map<String, dynamic> toJson() {
    return {
      "title": this.title,
      "published_at": this.published_at.toIso8601String(),
      "id": this.id,
      "description": this.description,
      "images": this.images.toJson()
    };
  }

  bool contains(Shot element) {
    return element.id == this.id;
  }
}
