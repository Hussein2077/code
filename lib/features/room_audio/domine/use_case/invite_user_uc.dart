


import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/base_use_case/base_use_case.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/room_audio/domine/Repository/Base_Repository_Profile.dart';


class InviteUserUC extends BaseUseCase<Unit,InviteUserPramiter>{

  final BaseRepositoryRoom roomRepo;


  InviteUserUC({required this.roomRepo});

  @override
  Future<Either<Unit,Failure>> call(InviteUserPramiter parameter) async{
    final result = await roomRepo
        .inviteUser(parameter.ownerId,parameter.userId,parameter.indexSeate) ;
    return result ;
  }

}

class InviteUserPramiter {
  final String ownerId;
  final String userId ;
  final int indexSeate;

 const InviteUserPramiter({required this.ownerId,required this.userId,required this.indexSeate});


}