import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/room/data/model/ente_room_model.dart';
import 'package:tik_chat_v2/features/room/domine/Repository/Base_Repository_Profile.dart';



class EnterRoomUC {
  final BaseRepositoryRoom roomRepo;

  EnterRoomUC({required this.roomRepo});

  Future<Either<EnterRoomModel, Failure>> call(
      EnterRoomPramiter parameter) async {
    final result = await roomRepo.enterRoom(parameter);
    return result;
  }
}

class EnterRoomPramiter extends Equatable {
  final String ownerId;
  final String? roomPassword;
  final bool? ignoreRoomPassword ;
  final bool? sendToZego ;
  final int isVip ; 


  const EnterRoomPramiter({required this.isVip ,  required this.ownerId, this.roomPassword, this.ignoreRoomPassword, this.sendToZego });

  @override
  List<Object?> get props => [ownerId, roomPassword,ignoreRoomPassword,sendToZego];
}
