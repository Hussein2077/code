

import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/room_audio/domine/Repository/Base_Repository_Profile.dart';



class AddAdminUC  {


  final BaseRepositoryRoom roomRepo;

  AddAdminUC({required this.roomRepo});


  Future<Either<String, Failure>> call(String ownerId,String userId) async {
    return await roomRepo.addAdmin(ownerId, userId) ;
  }
}