

class FamilyDataModel {
  final int? maxNum;
  final String? img;
  final int? memberNum;
  final String? name ;
  final int? ownerFamilyId ;

  FamilyDataModel(
      { this.maxNum,  this.img, this.name, this.ownerFamilyId,
         this.memberNum});

  factory FamilyDataModel.fromjosn(Map<String, dynamic> json) {
    return FamilyDataModel(
        maxNum: json['max_num'] ?? 0,
        img: json['img'] ?? "",
        ownerFamilyId:json['owner_id'] ??0,
        name:json['family_name']??"",
        memberNum: json['members_num'] ?? 0);
  }
}
