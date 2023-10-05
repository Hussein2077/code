class VideoCacheModel {
  final String img;
  final String url;

  VideoCacheModel({
    required this.img,
    required this.url,
  });

  Map<String, dynamic> toJson() {
    return {
      'img': img,
      'url': url,
    };
  }

  factory VideoCacheModel.fromJson(Map<String, dynamic> json) {
    return VideoCacheModel(
      img: json['img'] as String,
      url: json['url'] as String,
    );
  }
}