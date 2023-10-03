import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/background_model.dart';
import 'package:tik_chat_v2/features/room_audio/domine/Repository/Base_Repository_Profile.dart';




class BackGroundUseCase {
  BaseRepositoryRoom roomRepo;
  BackGroundUseCase({required this.roomRepo});
  Future<Either<List<BackGroundModel>, Failure>> getBackGround() async {
    return await roomRepo.getAllbackGround();
  }
}
