
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/core/base_use_case/base_use_case.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/room_audio/domine/Repository/Base_Repository_Profile.dart';



class MuteUserMicUsecase  extends BaseUseCase<String,MuteUserMicPramiter>{

  final BaseRepositoryRoom roomRepo;
  MuteUserMicUsecase({required this.roomRepo});

  @override
  Future<Either<String, Failure>> call(MuteUserMicPramiter muteUserMicPramiter) async {
    final result = await roomRepo.muteUserMic(muteUserMicPramiter);
    return result ;
  }
}

class MuteUserMicPramiter extends Equatable {

  final String ownerId;
  final String? userId ;

  const MuteUserMicPramiter({required this.ownerId, this.userId,});

  @override
  List<Object?> get props =>[ownerId,userId];


}