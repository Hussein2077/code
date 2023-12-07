import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/base_use_case/base_use_case.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/room_audio/domine/Repository/Base_Repository_Profile.dart';


class StartGameUC extends BaseUseCase<String, StartGamePramiter>{

  final BaseRepositoryRoom roomRepo;
  StartGameUC({required this.roomRepo});

  @override
  Future<Either<String,Failure>> call(StartGamePramiter parameter) async{
    final result = await roomRepo.startGame(parameter);
    return result ;
  }

}

class StartGamePramiter {
  final String gameId;

  const StartGamePramiter({required this.gameId});


}