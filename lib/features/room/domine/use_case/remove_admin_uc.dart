

import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/room/domine/Repository/Base_Repository_Profile.dart';



class RemoveAdminUC {


  final BaseRepositoryRoom roomRepo;

  RemoveAdminUC({required this.roomRepo});


  Future<Either<String, Failure>> call(String ownerId,String userId) async {
    return await roomRepo.removeAdmin(ownerId, userId);
  }
}