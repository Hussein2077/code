import 'dart:developer';


import 'package:tik_chat_v2/features/moment/data/model/moment_model.dart';

import 'widgets/moment_bottom_bar.dart';

class MomentController{

  static final Map<int, int> commentsOfMomentsMap = {};
  static int commentIncrement(int momentId){
    MomentController.commentsOfMomentsMap[momentId] =
        MomentController.commentsOfMomentsMap[momentId]! + 1;
    return  MomentController.commentsOfMomentsMap[momentId]!;
  }
  static int commentsDecrement(int momentId){
    MomentController.commentsOfMomentsMap[momentId] =
        MomentController.commentsOfMomentsMap[momentId]! - 1;
    return  MomentController.commentsOfMomentsMap[momentId]! ;
  }

  static final Map<int, int> giftsOfMomentsMap = {};
  static void giftIncrement(int momentId){
    MomentController.giftsOfMomentsMap[momentId] =
        MomentController.giftsOfMomentsMap[momentId]! + 1;
    MomentBottomBarState.giftsNotifierCounter.value++;


  static final Map<int,bool> favorites = {};
  static final Map<int,int> favoritesCount = {};
  static int selectedMoment = -1 ;
  void  likeReverce(int momentId){
    MomentController.favorites[momentId]= !MomentController.favorites[momentId]!;
    MomentBottomBarState.likeNotifierCounter.value++;
    // log( MomentController.favorites.toString());

  }
  void likecounter(int momentId){

    if( MomentController.favorites[momentId]==true){
      MomentController.favoritesCount[momentId]= MomentController.favoritesCount[momentId]!+1;
      MomentBottomBarState.likeNotifierCounter.value++;
      // log( MomentController.favoritesCount.toString());


    }else if( MomentController.favorites[momentId]==false){
      MomentController.favoritesCount[momentId]= MomentController.favoritesCount[momentId]!-1;
      MomentBottomBarState.likeNotifierCounter.value++;
      // log( MomentController.favoritesCount.toString());

    }
  }


  void fillLikeMaps (List<MomentModel> momentModelList){
    for (int i = 0; i < momentModelList.length; i++) {
      MomentController.favorites.putIfAbsent(
          momentModelList[i].momentId, () => momentModelList[i].isLike);
      MomentController.favoritesCount.putIfAbsent(
          momentModelList[i].momentId, () => momentModelList[i].likeNum);

    }
  }






}