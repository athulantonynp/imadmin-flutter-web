class ShotImage{

  final String normal;
  final String two_x;

  ShotImage({this.normal,this.two_x});

  factory ShotImage.fromJson(Map<String, dynamic> json){
    print(json);
    return ShotImage(normal: json['normal'],two_x: json['two_x']);
  }
}