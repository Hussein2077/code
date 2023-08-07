import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/room/data/model/emojie_model.dart';
import 'package:tik_chat_v2/features/room/domine/Repository/Base_Repository_Profile.dart';



class EmojieUseCase {
  BaseRepositoryRoom roomRepo;
  EmojieUseCase({required this.roomRepo});
  Future<Either<List<EmojieModel>, Failure>> getEmojie() async {
    return await roomRepo.getEmojie();
  }
}