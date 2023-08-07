import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/room/domine/Repository/Base_Repository_Profile.dart';


class StartPKUC {
     final BaseRepositoryRoom roomRepo;


     StartPKUC({required this.roomRepo});


     Future<Either<String, Failure>> startPk(String ownerId,String time) async {
       return await roomRepo.startPK(ownerId, time);
     }

}