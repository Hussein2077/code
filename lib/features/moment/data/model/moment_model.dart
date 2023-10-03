class MomentModel {
  final int momentId;
  final int userId;
  final String moment;
  final String momentImage;
  final int commentNum;
  final int likeNum;
  final int giftsCount;
  final String creeatedTime;
  final String userName;
  final String userImage;
  final String uuid;
  final String receiverImage;
  final String senderImage;
  final int vip;
  final bool hasColorName;




  const MomentModel(
      {required this.momentId,
        required this.uuid,
        required this.hasColorName,
        required this.receiverImage,
        required this.senderImage,
        required this.vip,
        required this.userId,
        required this.moment,
        required this.momentImage,
        required this.commentNum,
        required this.likeNum,
        required this.giftsCount,
        required this.creeatedTime,
        required this.userImage,
        required this.userName});

  factory MomentModel.fromJson(Map<String, dynamic> json) {
    return MomentModel(
      momentId: json['id'],
      userId: json['user_id'],
      moment: json['description'],
      momentImage: json['img']??"",
      commentNum: json['comment_num'],
      likeNum: json['like_num'],
      giftsCount: json['gifts_count'],
      creeatedTime: json['created_at'],
      userImage: json['user']['image'],
      userName: json['user']['image'],
      uuid: json['user']['uuid'],
      vip: json['user']['vip'],
      senderImage: json['user']['sender_level'],
      receiverImage: json['user']['receiver_level'],
      hasColorName: json['user']['has_color_name'],

    );

  }
}
