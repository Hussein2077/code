import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/core/model/owner_data_model.dart';
import 'package:tik_chat_v2/features/room/domine/Repository/Base_Repository_Profile.dart';


class RoomAdminsUC {
     final BaseRepositoryRoom roomRepo;

     RoomAdminsUC({required this.roomRepo});


   Future<Either<List<OwnerDataModel>, Failure>> call(String ownerId) async {
     return await roomRepo.roomAdmins(ownerId);
   }

}