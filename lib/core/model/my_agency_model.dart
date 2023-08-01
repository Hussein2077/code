class MyAgencyModel {
  final String? name;
  final String? notice;
  final String? img;
  MyAgencyModel({ this.img,  this.name,  this.notice});

  factory MyAgencyModel.fromjson(Map<String, dynamic> json) {
    return MyAgencyModel(
      name: json['name']??"",
      notice: json['notice']??"",
      img: json['img']??"",
    );
  }
}
