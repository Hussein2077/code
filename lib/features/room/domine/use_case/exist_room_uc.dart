

import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/room/domine/Repository/Base_Repository_Profile.dart';



class ExistroomUC {
  BaseRepositoryRoom roomRepo ;

  ExistroomUC({required this.roomRepo});

  Future<Either<Unit, Failure>> call(String ownerId) async {
    final result = await roomRepo.exsitRoom(ownerId);
    return result ;
  }
}