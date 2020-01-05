class ShotImage{

  final String normal;
  final String two_x;

  ShotImage({this.normal,this.two_x});

  factory ShotImage.fromJson(Map<String, dynamic> json){
    return ShotImage(normal: json['normal'],two_x: json['two_x']);
  }

    Map<String,dynamic> toJson(){
    return {
      "normal": this.normal,
      "two_x": this.two_x
    };
  }
}