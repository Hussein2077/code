import 'package:equatable/equatable.dart';

class GetBadgesModel extends Equatable {
  final List<AchievementLevelModel> levels;

  const GetBadgesModel({
    required this.levels,
  });

  @override
  List<Object?> get props => [levels];

  factory GetBadgesModel.fromJson(Map<String, dynamic> json) {
    return GetBadgesModel(
      levels: List<AchievementLevelModel>.from(
          json["levels"].map((x) => AchievementLevelModel.fromJson(x))),
    );
  }
}

class AchievementLevelModel extends Equatable {
  final int id;
  final int achievementId;
  final int? giftId;
  final int target;
  final String image;
  final String description;

  final int enable;

  const AchievementLevelModel({
    required this.id,
    required this.achievementId,
    this.giftId,
    required this.target,
    required this.image,
    required this.enable,
    required this.description,
  });

  factory AchievementLevelModel.fromJson(Map<String, dynamic> json) {
    var jsonData = json;
    return AchievementLevelModel(
      id: jsonData["id"],
      image: jsonData["image"],
      achievementId: jsonData["achievement_id"],
      target: jsonData["target"],
      enable: jsonData["enable"],
      description: jsonData["description"] ?? "",
    );
  }

  @override
  List<Object?> get props =>
      [id, achievementId, giftId, target, image, enable, description];
}
