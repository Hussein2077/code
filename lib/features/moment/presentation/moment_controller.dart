

import 'package:tik_chat_v2/features/moment/data/model/moment_model.dart';

import 'widgets/moment_bottom_bar.dart';

class MomentController{
  static get  getInstance => MomentController() ;



  //comments
   void commentIncrement(int momentId){
    MomentBottomBarState.commentsOfMomentsMap[momentId] =
        MomentBottomBarState.commentsOfMomentsMap[momentId]! + 1;
    MomentBottomBarState.commentsCounter.value++;
  }
   void commentsDecrement(int momentId){
    MomentBottomBarState.commentsOfMomentsMap[momentId] =
        MomentBottomBarState.commentsOfMomentsMap[momentId]! - 1;
    MomentBottomBarState.commentsCounter.value++;

  }
  void fillCommentMap ( List<MomentModel> momentModelList){
    for (int i = 0; i < momentModelList.length; i++) {
      MomentBottomBarState.commentsOfMomentsMap.putIfAbsent(
          momentModelList[i].momentId, () => momentModelList[i].commentNum);
    }
  }


  //gifts


   void giftIncrement(int momentId,int giftNum){
    MomentBottomBarState.giftsOfMomentsMap[momentId] =
        MomentBottomBarState.giftsOfMomentsMap[momentId]! + giftNum;
    MomentBottomBarState.giftsNotifierCounter.value++;
  }
  void fillGiftMap ( List<MomentModel> momentModelList){
    for (int i = 0; i < momentModelList.length; i++) {
      MomentBottomBarState.giftsOfMomentsMap.putIfAbsent(
          momentModelList[i].momentId, () => momentModelList[i].giftsCount);
    }

  }


  //like

  void  likeReverce(int momentId){
    MomentBottomBarState.favorites[momentId]= !MomentBottomBarState.favorites[momentId]!;
    MomentBottomBarState.likeNotifierCounter.value++;

  }
  void likecounter(int momentId){

    if( MomentBottomBarState.favorites[momentId]==true){
      MomentBottomBarState.favoritesCount[momentId]= MomentBottomBarState.favoritesCount[momentId]!+1;
      MomentBottomBarState.likeNotifierCounter.value++;


    }else if( MomentBottomBarState.favorites[momentId]==false){
      MomentBottomBarState.favoritesCount[momentId]= MomentBottomBarState.favoritesCount[momentId]!-1;
      MomentBottomBarState.likeNotifierCounter.value++;
      // log( MomentController.favoritesCount.toString());

    }
  }
  void fillLikeMaps (List<MomentModel> momentModelList){
    for (int i = 0; i < momentModelList.length; i++) {
      MomentBottomBarState.favorites.putIfAbsent(
          momentModelList[i].momentId, () => momentModelList[i].isLike);
      MomentBottomBarState.favoritesCount.putIfAbsent(
          momentModelList[i].momentId, () => momentModelList[i].likeNum);

    }
  }


  void clearMaps(){
    MomentBottomBarState.commentsOfMomentsMap.clear();
    MomentBottomBarState.giftsOfMomentsMap.clear();
    MomentBottomBarState.favorites.clear();
    MomentBottomBarState.favoritesCount.clear();

  }
}













// import 'dart:developer';
// import 'package:tik_chat_v2/features/moment/data/model/moment_model.dart';
// import 'widgets/moment_bottom_bar.dart';
//
// class MomentController {
//
//   //comments
//   //static MomentController get getInstance => MomentController();
//   static Map<int, int> commentsOfMomentsMap = {};
//
//   // Map<int, int> get getCommentsOfMomentsMap {
//   //   return commentsOfMomentsMap;
//   // }
//
//     // set setCommentsOfMomentsMap(Map<int, int> newCommentsOfMomentsMap) {
//     //   commentsOfMomentsMap = newCommentsOfMomentsMap;
//     // }
//
//
//   // Map<int, int> get getCommentsOfMomentsMap => commentsOfMomentsMap;
//   // set setCommentsOfMomentsMap(Map<int, int> newCommentsOfMomentsMap) =>
//   //     commentsOfMomentsMap = newCommentsOfMomentsMap;
//
//
//
//  static int selectedMomentComment = -1;
//     // int get getSelectMoment {
//     //   return selectedMomentComment;
//     // }
//   // int get getSelectMoment => selectedMomentComment;
//   // set setSelectMoment(int newSelectMoment) {
//   //   selectedMomentComment = newSelectMoment;
//   //     }
//   // set setSelectMoment(int newSelectMoment) =>
//   //     selectedMomentComment = newSelectMoment;
//
//   void commentIncrement(int momentId) {
//     commentsOfMomentsMap[momentId] = commentsOfMomentsMap[momentId]! + 1;
//     MomentBottomBarState.commentsCounter.value++;
//   }
//   static void commentsDecrement(int momentId){
//     MomentController.commentsOfMomentsMap[momentId] =
//         MomentController.commentsOfMomentsMap[momentId]! - 1;
//     MomentBottomBarState.commentsCounter.value++;
//   }
//   void fillCommentMap ( List<MomentModel> momentModelList) {
//     for (int i = 0; i < momentModelList.length; i++) {
//       MomentController.commentsOfMomentsMap.putIfAbsent(
//           momentModelList[i].momentId, () => momentModelList[i].commentNum);
//     }
//     log('commentsOfMomentsMap${commentsOfMomentsMap}');
//   }
//
//
//
//
//
//
//
//
//
//   //class MyClass {
//   //   // Private instance variables
//   //   int _intValue;
//   //   Map<int, int> _intMap;
//   //
//   //   // Getter method for int value
//   //   int get intValue {
//   //     return _intValue;
//   //   }
//   //
//   //   // Setter method for int value
//   //   set intValue(int newValue) {
//   //     _intValue = newValue;
//   //   }
//   //
//   //   // Getter method for Map<int, int>
//   //   Map<int, int> get intMap {
//   //     return _intMap;
//   //   }
//   //
//   //   // Setter method for Map<int, int>
//   //   set intMap(Map<int, int> newMap) {
//   //     _intMap = newMap;
//   //   }
//   // }
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//   //gifts
//   static final Map<int, int> giftsOfMomentsMap = {};
//
//   static void giftIncrement(int momentId){
//     MomentController.giftsOfMomentsMap[momentId] =
//         MomentController.giftsOfMomentsMap[momentId]! + 1;
//     MomentBottomBarState.giftsNotifierCounter.value++;
//   }
//
//   void fillGiftMap ( List<MomentModel> momentModelList){
//     for (int i = 0; i < momentModelList.length; i++) {
//       MomentController.giftsOfMomentsMap.putIfAbsent(
//           momentModelList[i].momentId, () => momentModelList[i].giftsCount);
//     }
//   }
//
//
//
//   //likes
//   static final Map<int,bool> favorites = {};
//   static final Map<int,int> favoritesCount = {};
//   static int selectedMomentLike = -1 ;
//
//   void  likeReverce(int momentId){
//     MomentController.favorites[momentId]= !MomentController.favorites[momentId]!;
//     MomentBottomBarState.likeNotifierCounter.value++;
//   }
//   void likecounter(int momentId){
//     if( MomentController.favorites[momentId]==true){
//       MomentController.favoritesCount[momentId]= MomentController.favoritesCount[momentId]!+1;
//       MomentBottomBarState.likeNotifierCounter.value++;
//     }else if( MomentController.favorites[momentId]==false){
//       MomentController.favoritesCount[momentId]= MomentController.favoritesCount[momentId]!-1;
//       MomentBottomBarState.likeNotifierCounter.value++;
//
//     }
//   }
//
//   void fillLikeMaps (List<MomentModel> momentModelList){
//     for (int i = 0; i < momentModelList.length; i++) {
//       MomentController.favorites.putIfAbsent(
//           momentModelList[i].momentId, () => momentModelList[i].isLike);
//       MomentController.favoritesCount.putIfAbsent(
//           momentModelList[i].momentId, () => momentModelList[i].likeNum);
//     }
//   }
//
// }