


import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/core/model/all_rooms_model.dart';
import 'package:tik_chat_v2/core/model/owner_data_model.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/following/data/data_sorce/follwoing_remote_data_sours.dart';
import 'package:tik_chat_v2/features/following/domin/repository/follwoing_repository.dart';


class FollwoingRepostoryImp implements RepoFollow{
  final FollwoingRemoteDataSours follwoingRemoteDataSours ;

  FollwoingRepostoryImp( {required this.follwoingRemoteDataSours});



  @override
  Future<Either<List<UserDataModel>, Failure>> getFriendsOpenRoom(
      int type) async {
    try {
      final result =
          await follwoingRemoteDataSours.getFriendsOpenRoom(type);
      return Left(result);
    } on Exception catch (e) {
      return right(DioHelper.buildFailure(e));
    }
    
  }

  @override
  Future<Either<AllRoomsDataModel, Failure>> getFollowingRooms(String type)async {
    try {
      final result =
          await follwoingRemoteDataSours.getFollowersRooms(type: type);
      return Left(result);
    } on Exception catch (e) {
      return right(DioHelper.buildFailure(e));
    }
  }


}