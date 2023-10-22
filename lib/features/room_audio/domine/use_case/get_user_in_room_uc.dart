import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/core/model/room_user_messages_model.dart';
import 'package:tik_chat_v2/features/room_audio/domine/Repository/Base_Repository_Profile.dart';





class GetRoomUserUseCase {

  final BaseRepositoryRoom roomRepo;
  GetRoomUserUseCase({ required this.roomRepo});

  Future<Either<List<RoomUserMesseagesModel>, Failure>> getUsersInRoon(String userId) async {
    return await roomRepo.getUsersInRoon(userId);
  }
}

