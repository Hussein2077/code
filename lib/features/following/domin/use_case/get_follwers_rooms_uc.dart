import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/core/model/all_rooms_model.dart';
import 'package:tik_chat_v2/features/following/domin/repository/follwoing_repository.dart';

class GetFollwingRoomsUC {


  RepoFollow repoFollow ;


  GetFollwingRoomsUC({required this.repoFollow});

  Future<Either<AllRoomsDataModel, Failure>> call(String type) async {
    final  result = await repoFollow.getFollowingRooms(type);
    return result ;
  }



}