class RoomUserMesseagesModel {
  final int id;
  final String uuid;
  final String name;
  final String image;
  final String senderLevelImg;
  final String revicerLevelImg;
  final int vipLevel;
  final String bubble;
  final int bubbleId;
  final bool hasColorName;

  RoomUserMesseagesModel(
      {required this.bubble,
      required this.bubbleId,
      required this.hasColorName,
      required this.id,
      required this.image,
      required this.name,
      required this.revicerLevelImg,
      required this.senderLevelImg,
      required this.uuid,
      required this.vipLevel});

  factory RoomUserMesseagesModel.fromJson(Map<String, dynamic> json) {
    return RoomUserMesseagesModel(
        bubbleId: json['bubble_id'],
        bubble: json['bubble']?? "",
        hasColorName: json['has_color_name'],
        id: json['id'],
        image: json['profile_image']??"",
        name: json['name']?? "",
        revicerLevelImg: json['level']['receiver_img']??'',
        senderLevelImg: json['level']['sender_img']??"",
        uuid: json['uuid'],
        vipLevel: json['vip']['level']??0);
  }
}