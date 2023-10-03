
import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/base_use_case/base_use_case.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/room_audio/domine/Repository/Base_Repository_Profile.dart';
import 'package:equatable/equatable.dart';

class MuteUnMuteUserInRoomUC extends BaseUseCase<Unit,MuteUnmutePramiters>{


  final BaseRepositoryRoom roomRepo;


  MuteUnMuteUserInRoomUC({required this.roomRepo});

  @override
  Future<Either<Unit, Failure>> call(MuteUnmutePramiters parameter)  async{
    final result = await roomRepo.muteUser(parameter.ownerId,parameter.userId,parameter.mute) ;

    return result ;
  }


}

class MuteUnmutePramiters extends Equatable {
  final String ownerId ;
  final String userId  ;
  final bool mute ;

const  MuteUnmutePramiters({required this.ownerId,required this.userId,required this.mute});

  @override
  List<Object?> get props => [ownerId,userId,mute];


}