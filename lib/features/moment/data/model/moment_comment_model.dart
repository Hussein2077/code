class MomentCommentModel {
  final int? commentId;
  final int? momentId;
  final int? userId;
  final String? uuid;
  final String comment;
  final String userProfilePic;
  final String userName;
  final String commentTime;

  MomentCommentModel({
    this.commentId,
    this.momentId,
    this.userId,
    this.uuid,
    required this.comment,
    required this.userProfilePic,
    required this.userName,
    required this.commentTime,
  });

  factory MomentCommentModel.fromJson(Map<String, dynamic> json) {
    return MomentCommentModel(
        commentId: json['id'],
        userId: json['user']['id'],
        uuid: json['user']['uuid'],
        momentId: json['moment_id'],
        comment: json['comment'],
        commentTime: json['created_at'],
        userName: json['user']['name'],
        userProfilePic: json['user']['image']);
  }
}
