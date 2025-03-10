
import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/room_audio/domine/Repository/Base_Repository_Profile.dart';

class ClosePKUC {
  final BaseRepositoryRoom roomRepo;


  ClosePKUC({required this.roomRepo});


  Future<Either<String, Failure>> call(String ownerId,String pkId) async {
    return await roomRepo.closePK(ownerId,pkId);
  }

}