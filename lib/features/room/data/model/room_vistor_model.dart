class RoomVistorModel {
  final int id;
  final String uuid;
  final String name;
  final String image;
  final String senderLevelImg;
  final String revicerLevelImg;
  final int vipLevel;
  final String frame;
  final int frameId;
  final bool hasColorName;
  final int type; // 0 owner , 1 admin , 2 vistor

  RoomVistorModel(
      {required this.frameId,
      required this.frame,
      required this.hasColorName,
      required this.id,
      required this.image,
      required this.name,
      required this.revicerLevelImg,
      required this.senderLevelImg,
      required this.type,
      required this.uuid,
      required this.vipLevel});

  factory RoomVistorModel.fromJson(Map<String, dynamic> json) {
    return RoomVistorModel(
        frameId: json['frame_id'],
        frame: json['frame'],
        hasColorName: json['has_color_name'],
        id: json['id'],
        image: json['profile_image']??"",
        name: json['name'],
        revicerLevelImg: json['level']['receiver_img']??'',
        senderLevelImg: json['level']['sender_img']??"",
        type: json['type'],
        uuid: json['uuid'],
        vipLevel: json['vip']['level']??0);
  }
}
