import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/base_use_case/base_use_case.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/room_audio/domine/Repository/Base_Repository_Profile.dart';


class SendGameChoiseUC extends BaseUseCase<String, SendGameChoisePramiter>{

  final BaseRepositoryRoom roomRepo;
  SendGameChoiseUC({required this.roomRepo});

  @override
  Future<Either<String,Failure>> call(SendGameChoisePramiter parameter) async{
    final result = await roomRepo.sendGameChoise(parameter);
    return result ;
  }

}

class SendGameChoisePramiter {
  final String gameId;
  final String answer;

  const SendGameChoisePramiter({required this.gameId, required this.answer});


}