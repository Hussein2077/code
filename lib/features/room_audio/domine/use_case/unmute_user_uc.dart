
import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/base_use_case/base_use_case.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/room_audio/domine/Repository/Base_Repository_Profile.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/mute_user_uc.dart';



class UnMuteUserMicUsecase  extends BaseUseCase<String,MuteUserMicPramiter>{

  final BaseRepositoryRoom roomRepo;
  UnMuteUserMicUsecase({required this.roomRepo});

  @override
  Future<Either<String, Failure>> call(MuteUserMicPramiter muteUserMicPramiter) async {
    final result = await roomRepo.unMuteUserMic(muteUserMicPramiter);
    return result ;
  }
}