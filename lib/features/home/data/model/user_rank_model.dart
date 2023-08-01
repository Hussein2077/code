import 'dart:developer';

import 'package:equatable/equatable.dart';

import 'user_top_model.dart';


class RankingModel extends Equatable{
  final bool sussecc;
  final String  messges;
  final UserTopModel userData ;
  final List<UserTopModel> userRankModels;
  late final List<UserTopModel> userOtherModel;


   // ignore: prefer_const_constructors_in_immutables
   RankingModel(
      { required this.sussecc,
       required  this.messges,
        required this.userData,
        required this.userRankModels,
       required this.userOtherModel});


  factory RankingModel.fromJson(Map<String,dynamic> jsonData){
    log(jsonData.toString());
    return RankingModel(
      sussecc: jsonData['success'],
      messges: jsonData['message'],
        userData: UserTopModel.fromJson(jsonData["data"]['user']),
        userRankModels: List<UserTopModel>.from(jsonData["data"]['top'].map((x) => UserTopModel.fromJson(x))),
      userOtherModel:
        List<UserTopModel>.from(jsonData["data"]['other'].map((x) => UserTopModel.fromJson(x)))
    );
  }


  List<UserTopModel> get moreUserOtherModel {
    return userOtherModel;
  }

  set setMoreUsers(List<UserTopModel> users) {
    userOtherModel = [...userOtherModel,...users] ;
  }
  @override

  List<Object?> get props => [sussecc,messges,userOtherModel,userRankModels];

}





// class UserOtherModel extends Equatable {
//   final int  exp;
//   final int userId ;
//   final String  sex ;
//   final String avater;
//   final String nickName;
//   final String starsImg;
//   final String goldImg;
//   final String vipImg;
//
//   UserOtherModel(
//       {required  this.exp,
//         required  this.userId,
//         required this.sex,
//         required  this.avater,
//         required this.nickName,
//         required this.starsImg,
//         required this.goldImg,
//         required  this.vipImg});
//
//
//
//   factory UserOtherModel.fromJson(Map<String,dynamic> jsonData){
//     return UserOtherModel(
//         exp: jsonData['exp'],
//         userId: jsonData['id'],
//         sex: jsonData['sex'],
//         avater: jsonData['avatar'],
//         nickName: jsonData['nickname'],
//         starsImg: jsonData['stars_img'],
//         goldImg: jsonData['gold_img'],
//         vipImg: jsonData['vip_img']);
//   }
//   @override
//   List<Object?> get props => [exp,userId,sex,avater,nickName,starsImg,goldImg,vipImg];
//
//
// }


