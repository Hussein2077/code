

import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/room/domine/Repository/Base_Repository_Profile.dart';
import 'package:tik_chat_v2/features/room/domine/use_case/up_mic_usecase.dart';


class MuteUnMuteMicUC {
  final BaseRepositoryRoom roomRepo;


  MuteUnMuteMicUC({required this.roomRepo});


  Future<Either<String, Failure>> muteMic(UpMicrophonePramiter upMicrophonePramiter) async{

    return await roomRepo.muteMic(upMicrophonePramiter);
  }

  Future<Either<String, Failure>> unMuteMic(UpMicrophonePramiter upMicrophonePramiter) async{

    return await roomRepo.unMuteMic(upMicrophonePramiter);
  }


}

