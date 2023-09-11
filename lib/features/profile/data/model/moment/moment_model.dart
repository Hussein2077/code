class MomentModel {
  final int momentId;
  final int userId;
  final String moment;
  final int commentNum;
  final int likeNum;
  final int giftsCount;
  final String creeatedTime;
  final String userName;
  final String userImage;

  const MomentModel(
      {required this.momentId,
      required this.userId,
      required this.moment,
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
        commentNum: json['comment_num'],
        likeNum: json['like_num'],
        giftsCount: json['gifts_count'],
        creeatedTime: json['created_at'],
        userImage: json['user']['image'],
        userName: json['user']['image']);
  }
}
