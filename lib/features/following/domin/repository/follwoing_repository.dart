

import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/core/model/all_rooms_model.dart';
import 'package:tik_chat_v2/core/model/owner_data_model.dart';


abstract class RepoFollow{

    Future<Either<List<UserDataModel>, Failure>> getFriendsOpenRoom(int type);
        Future<Either<AllRoomsDataModel, Failure>> getFollowingRooms(String type);


}