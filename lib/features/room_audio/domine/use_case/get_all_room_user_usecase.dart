import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/room_vistor_model.dart';
import 'package:tik_chat_v2/features/room_audio/domine/Repository/Base_Repository_Profile.dart';





class GetAllRoomUserUseCase {
  
  final BaseRepositoryRoom roomRepo;
  GetAllRoomUserUseCase({ required this.roomRepo});
  Future<Either<List<RoomVistorModel>, Failure>>
      getAllRoomUser(GetAlluserPram pram) async {
    return await roomRepo.getAllRoomUser( pram: pram );
  }
}


class GetAlluserPram {
  final String page ; 
  List<String>? usersId ; 
  final String ownerId ; 


  GetAlluserPram( this.ownerId ,  this.page , this.usersId);

}

