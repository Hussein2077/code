class MyAgencyModel {
  final String name;
  final String notice;
  final String img;
  MyAgencyModel({required this.img, required this.name, required this.notice});

  factory MyAgencyModel.fromjson(Map<String, dynamic> json) {
    return MyAgencyModel(
      name: json['name']??"",
      notice: json['notice']??"",
      img: json['img']??"",
    );
  }
}
