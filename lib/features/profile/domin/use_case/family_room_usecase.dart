



import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/core/model/all_rooms_model.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';


class GetFamilyRoomUsecase {
  BaseRepositoryProfile baseRepositoryProfile;
  GetFamilyRoomUsecase({required this.baseRepositoryProfile});
  Future<Either<AllRoomsDataModel, Failure>> getFamilyRooms(
      String familyId) async {
    final result = await baseRepositoryProfile.getFamilyRoom(familyId);
    return result;
  }
}
