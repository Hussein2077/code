import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/base_use_case/base_use_case.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/room_audio/domine/Repository/Base_Repository_Profile.dart';


class InviteToGameNewUC extends BaseUseCase<String, InviteToGameNewPramiter>{

  final BaseRepositoryRoom roomRepo;
  InviteToGameNewUC({required this.roomRepo});

  @override
  Future<Either<String,Failure>> call(InviteToGameNewPramiter parameter) async{
    final result = await roomRepo.inviteToGameNew(parameter);
    return result ;
  }

}

class InviteToGameNewPramiter {
  final String ownerId;
  final String game_id ;
  final List<int> players;
  final String coins;
  final int round_num;

  const InviteToGameNewPramiter({required this.ownerId, required this.game_id, required this.players, required this.coins, required this.round_num});


}