
import 'package:tik_chat_v2/features/moment/data/model/moment_model.dart';

import 'widgets/moment_bottom_bar.dart';

class MomentController{

  static final Map<int, int> commentsOfMomentsMap = {};
  static int selectedMomentComment = -1 ;
  static void commentIncrement(int momentId){
    MomentController.commentsOfMomentsMap[momentId] =
        MomentController.commentsOfMomentsMap[momentId]! + 1;
    MomentBottomBarState.commentsCounter.value++;

  }
  static void commentsDecrement(int momentId){
    MomentController.commentsOfMomentsMap[momentId] =
        MomentController.commentsOfMomentsMap[momentId]! - 1;
    MomentBottomBarState.commentsCounter.value++;

  }
  void fillCommentMap ( List<MomentModel> momentModelList){
    for (int i = 0; i < momentModelList.length; i++) {
      MomentController.commentsOfMomentsMap.putIfAbsent(
          momentModelList[i].momentId, () => momentModelList[i].commentNum);
    }
  }

  static final Map<int, int> giftsOfMomentsMap = {};
  static void giftIncrement(int momentId){
    MomentController.giftsOfMomentsMap[momentId] =
        MomentController.giftsOfMomentsMap[momentId]! + 1;
    MomentBottomBarState.giftsNotifierCounter.value++;

  }
  void fillGiftMap ( List<MomentModel> momentModelList){
    for (int i = 0; i < momentModelList.length; i++) {
      MomentController.giftsOfMomentsMap.putIfAbsent(
          momentModelList[i].momentId, () => momentModelList[i].giftsCount);
    }
  }

  static final Map<int,bool> favorites = {};
  static final Map<int,int> favoritesCount = {};
  static int selectedMomentLike = -1 ;
  void  likeReverce(int momentId){
    MomentController.favorites[momentId]= !MomentController.favorites[momentId]!;
    MomentBottomBarState.likeNotifierCounter.value++;

  }
  void likecounter(int momentId){

    if( MomentController.favorites[momentId]==true){
      MomentController.favoritesCount[momentId]= MomentController.favoritesCount[momentId]!+1;
      MomentBottomBarState.likeNotifierCounter.value++;


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