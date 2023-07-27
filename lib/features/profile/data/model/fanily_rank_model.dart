


class FamilyRankModel {
  final List<FamilyRanking> topRanking;
  final List<FamilyRanking> otherRanking;
  FamilyRankModel({required this.otherRanking, required this.topRanking});
  factory FamilyRankModel.fromJson(Map<String, dynamic> json) {
    return FamilyRankModel(
      otherRanking: List<FamilyRanking>.from(
          json["data"]['other'].map((x) => FamilyRanking.fromJson(x))),
      topRanking: List<FamilyRanking>.from(
          json["data"]['top'].map((x) => FamilyRanking.fromJson(x))),
    );
  }
}

class FamilyRanking {
  final int? id;
  final String? name;
  final String? introduce;
  final String? img;
  // final String? notice;
  // final int? maxNumOfMembers;
  final String? rank;
  // final OwnerDataModel? ownerData ; 
  FamilyRanking(
      { this.id,
       this.img,
       this.introduce,
      //  this.maxNumOfMembers,
       this.name,
       this.rank
      //  this.notice,
      });
  factory FamilyRanking.fromJson(Map<String, dynamic> json) {
  

    return FamilyRanking(
      id: json['id']??0,
      img: json["image"]??"",
      introduce: json["introduce"]??"",
      // maxNumOfMembers: json["max_num_of_members"],
      name: json["name"]??"",
      // notice: json["notice"],
      rank: json["rank"]??"",
      // ownerData:  OwnerDataModel.fromMap(json['owner'])
    );
  }
}
