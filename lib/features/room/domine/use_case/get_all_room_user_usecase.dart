import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/features/room/data/model/get_room_users_model.dart';
import 'package:tik_chat_v2/features/room/domine/Repository/Base_Repository_Profile.dart';

import 'package:tik_chat_v2/core/error/failures.dart';



class GetAllRoomUserUseCase {
  
  final BaseRepositoryRoom roomRepo;
  GetAllRoomUserUseCase({ required this.roomRepo});
  Future<Either<GetRoomUsersModel, Failure>>
      getAllRoomUser(String ownerId) async {
    return await roomRepo.getAllRoomUser( ownerId: ownerId );
  }
}
