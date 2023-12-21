class InvitationUsersModel {
  final String invitedId;
  final int userCharge;
  final int parentPercentage;
  final String date;
  final String image;
  final String name;

  InvitationUsersModel({
    required this.invitedId,
    required this.userCharge,
    required this.parentPercentage,
    required this.date,
    required this.image,
    required this.name,
  });

  factory InvitationUsersModel.fromMap(Map<String, dynamic> map) {
    return InvitationUsersModel(
      invitedId: map['user']['uuid']??'',
      name: map['user']['name']??'',
      userCharge: map['user_charge']??0,
      parentPercentage: map['parent_percentage']??0,
      date: map['updated_at']??'',
      image: map['user']['profile']['image']??'',
    );
  }
}
class ParentStaticsModel {
  final int totalEarned;
  final int dayEarned;
  final int totalInvited;
  final int dayInvited;


  ParentStaticsModel({
    required this.totalEarned,
    required this.dayEarned,
    required this.totalInvited,
    required this.dayInvited,

  });

  factory ParentStaticsModel.fromMap(Map<String, dynamic> map) {
    return ParentStaticsModel(

      totalEarned: map['dayInvited']??0,
      dayEarned: map['earnedDay']??0,
      totalInvited: map['TotalInvited']??0,
      dayInvited: map['invitedDay']??0,
    );
  }
}
