class MomentController{
  static final Map<int, int> commentsOfMomentsMap = {};
  static final Map<int,bool> favorites = {};
  static final Map<int,int> favoritesCount = {};
  static int selectedMoment = -1 ;
  static bool likeReverce(int momentId){
   favorites[momentId]= !favorites[momentId]!;
    return favorites[momentId]!;
  }
  static void likecounter(int momentId){


    if(favorites[momentId]==true){
      favoritesCount[momentId]= favoritesCount[momentId]!+1;

    }else if( favorites[momentId]==false){
     favoritesCount[momentId]= favoritesCount[momentId]!-1;
    }
  }
  static int commentIncrement(int momentId){
  commentsOfMomentsMap[momentId] =
     commentsOfMomentsMap[momentId]! + 1;
    return  commentsOfMomentsMap[momentId]!;
  }
  static int commentsDecrement(int momentId){
    commentsOfMomentsMap[momentId] =
       commentsOfMomentsMap[momentId]! - 1;
    return  commentsOfMomentsMap[momentId]! ;
  }



}