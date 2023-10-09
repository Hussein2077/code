import 'dart:developer';
import 'package:tik_chat_v2/features/moment/data/model/moment_model.dart';
import 'widgets/moment_bottom_bar.dart';

class MomentController {
  static MomentController get getInstance => MomentController();
  Map<int, int> commentsOfMomentsMap = {};
  Map<int, int> get getCommentsOfMomentsMap => commentsOfMomentsMap;

  set setCommentsOfMomentsMap(Map<int, int> newCommentsOfMomentsMap) =>
      commentsOfMomentsMap = newCommentsOfMomentsMap;

  int selectedMomentComment = -1;
  int get getSelectMoment => selectedMomentComment;
  set setSelectMoment(int newSelectMoment) =>
      selectedMomentComment = newSelectMoment;

  void commentIncrement(int momentId) {
    commentsOfMomentsMap[momentId] = commentsOfMomentsMap[momentId]! + 1;
    MomentBottomBarState.commentsCounter.value++;
  }
  void commentsDecrement(int momentId){
    commentsOfMomentsMap[momentId] =
        commentsOfMomentsMap[momentId]! - 1;
    MomentBottomBarState.commentsCounter.value++;
  }
  void fillCommentMap ( List<MomentModel> momentModelList) {
    for (int i = 0; i < momentModelList.length; i++) {
      MomentController.getInstance.commentsOfMomentsMap.putIfAbsent(
          momentModelList[i].momentId, () => momentModelList[i].commentNum);
    }
    setCommentsOfMomentsMap=commentsOfMomentsMap;
    log('commentsOfMomentsMap${commentsOfMomentsMap}');
    log('commentsOfMomentsMap${MomentController.getInstance.getCommentsOfMomentsMap}');
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