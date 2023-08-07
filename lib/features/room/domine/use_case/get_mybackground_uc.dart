import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/room/data/model/background_model.dart';
import 'package:tik_chat_v2/features/room/domine/Repository/Base_Repository_Profile.dart';

class GetMyBackGroundUseCase {
  BaseRepositoryRoom roomRepo;
  GetMyBackGroundUseCase({required this.roomRepo});
  Future<Either<List<BackGroundModel>, Failure>> getMyBackGround() async {
    return await roomRepo.getMyAllbackGround();
  }
}