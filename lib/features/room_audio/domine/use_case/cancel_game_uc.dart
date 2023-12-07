import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/base_use_case/base_use_case.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/room_audio/domine/Repository/Base_Repository_Profile.dart';


class CancelGameUC extends BaseUseCase<String, CancelGamePramiter>{

  final BaseRepositoryRoom roomRepo;
  CancelGameUC({required this.roomRepo});

  @override
  Future<Either<String,Failure>> call(CancelGamePramiter parameter) async{
    final result = await roomRepo.cancelGame(parameter);
    return result ;
  }

}

class CancelGamePramiter {
  final String gameId;

  const CancelGamePramiter({required this.gameId});


}