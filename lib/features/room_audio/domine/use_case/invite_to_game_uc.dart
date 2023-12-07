import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/base_use_case/base_use_case.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/room_audio/domine/Repository/Base_Repository_Profile.dart';


class InviteToGameUC extends BaseUseCase<String, InviteToGamePramiter>{

  final BaseRepositoryRoom roomRepo;
  InviteToGameUC({required this.roomRepo});

  @override
  Future<Either<String,Failure>> call(InviteToGamePramiter parameter) async{
    final result = await roomRepo.inviteToGame(parameter);
    return result ;
  }

}

class InviteToGamePramiter {
  final String ownerId;
  final String userId ;
  final String coins;

  const InviteToGamePramiter({required this.ownerId, required this.userId, required this.coins});


}