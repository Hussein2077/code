import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/emojie_model.dart';
import 'package:tik_chat_v2/features/room_audio/domine/Repository/Base_Repository_Profile.dart';



class EmojieUseCase {
  BaseRepositoryRoom roomRepo;
  EmojieUseCase({required this.roomRepo});
  Future<Either<List<EmojieModel>, Failure>> getEmojie() async {
    return await roomRepo.getEmojie();
  }
}