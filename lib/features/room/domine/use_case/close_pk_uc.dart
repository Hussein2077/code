
import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/room/domine/Repository/Base_Repository_Profile.dart';

class ClosePKUC {
  final BaseRepositoryRoom roomRepo;


  ClosePKUC({required this.roomRepo});


  Future<Either<String, Failure>> call(String ownerId) async {
    return await roomRepo.closePK(ownerId);
  }

}