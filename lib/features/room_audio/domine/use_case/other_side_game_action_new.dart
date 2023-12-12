import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/base_use_case/base_use_case.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/room_audio/domine/Repository/Base_Repository_Profile.dart';


class OtherSideGameActionNewUC extends BaseUseCase<String, OtherSideGameActionNewPramiter>{

  final BaseRepositoryRoom roomRepo;
  OtherSideGameActionNewUC({required this.roomRepo});

  @override
  Future<Either<String,Failure>> call(OtherSideGameActionNewPramiter parameter) async{
    final result = await roomRepo.otherSideGameActionNew(parameter);
    return result ;
  }

}

class OtherSideGameActionNewPramiter {
  final String gameId;
  final String status;

  const OtherSideGameActionNewPramiter({required this.gameId, required this.status});


}