import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/base_use_case/base_use_case.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/room_audio/domine/Repository/Base_Repository_Profile.dart';


class GameResultUC extends BaseUseCase<String, GameResultPramiter>{

  final BaseRepositoryRoom roomRepo;
  GameResultUC({required this.roomRepo});

  @override
  Future<Either<String,Failure>> call(GameResultPramiter parameter) async{
    final result = await roomRepo.gameresult(parameter);
    return result ;
  }

}

class GameResultPramiter {
  final String gameId;
  final String answer;
  final String round;

  const GameResultPramiter({required this.gameId, required this.answer, required this.round});


}