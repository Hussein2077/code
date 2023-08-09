class InterstedMode {
  int? id;
  String? name;
  String? image;

  InterstedMode({this.id, this.image, this.name});
  factory InterstedMode.fromjson(Map<String, dynamic> json) {
    return InterstedMode(
        id: json['id'] ?? 0,
        image: json['img'] ?? "tic_logo.jpg",
        name: json['name'] ?? "");
  }
}
