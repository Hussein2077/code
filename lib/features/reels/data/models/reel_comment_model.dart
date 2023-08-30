class ReelCommentModel {
  final int? id;
  final int? reelId;
  final int? userId;

  final String comment;
  final String userProfilePic;
  final String userName;
  final String commentTime;

  ReelCommentModel({
    this.id,
    this.reelId,
    this.userId,
    required this.comment,
    required this.userProfilePic,
    required this.userName,
    required this.commentTime,
  });

  factory ReelCommentModel.fromJson(Map<String, dynamic> json) {
    return ReelCommentModel(
        id: json['id'],
        userId: json['user_id'],
        reelId: json['real_id'],
        comment: json['comment'],
        commentTime: json['created_at'],
        userName: json['user']['name'],
        userProfilePic: json['user']['image']);
  }
}
