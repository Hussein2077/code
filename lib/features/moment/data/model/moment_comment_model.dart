class MomentCommentModel {
  final int? commentId;
  final int? momentId;
  final int? userId;

  final String comment;
  final String userProfilePic;
  final String userName;
  final String commentTime;

  MomentCommentModel({
    this.commentId,
    this.momentId,
    this.userId,
    required this.comment,
    required this.userProfilePic,
    required this.userName,
    required this.commentTime,
  });

  factory MomentCommentModel.fromJson(Map<String, dynamic> json) {
    return MomentCommentModel(
        commentId: json['id'],
        userId: json['user_id'],
        momentId: json['moment_id'],
        comment: json['comment'],
        commentTime: json['created_at'],
        userName: json['user']['name'],
        userProfilePic: json['user']['image']);
  }
}
