class RoomVistorModel {
  final int? id;
  final String? uuid;
  final String? name;
  final String? image;
  final String? senderLevelImg;
  final String? revicerLevelImg;
  final int? vipLevel;
  final String? frame;
  final int? frameId;
  final bool? hasColorName;
  final int? type; // 0 owner , 1 admin , 2 vistor

  RoomVistorModel({this.frameId, this.frame, this.hasColorName, this.id, this.image, this.name, this.revicerLevelImg, this.senderLevelImg, this.type, this.uuid, this.vipLevel});

  factory RoomVistorModel.fromJson(Map<String, dynamic> json) {
    return RoomVistorModel(
        frameId: json['frame_id']??0,
        frame: json['frame']??'',
        hasColorName: json['has_color_name']??false,
        id: json['id']??0,
        image: json['profile_image']??"",
        name: json['name']??'',
        revicerLevelImg: json['level']['receiver_img']??"",
        senderLevelImg: json['level']['sender_img']??"",
        type: json['type']??2,
        uuid: json['uuid']??0,
        vipLevel: json['vip']['level']??0);
  }
}
