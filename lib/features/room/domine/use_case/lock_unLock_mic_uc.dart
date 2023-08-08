
import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/room/domine/Repository/Base_Repository_Profile.dart';
import 'package:tik_chat_v2/features/room/domine/use_case/up_mic_usecase.dart';



class LockUnLockMicUC {

  final BaseRepositoryRoom roomRepo;


  LockUnLockMicUC({required this.roomRepo});


  Future<Either<String, Failure>> lockMic(UpMicrophonePramiter upMicrophonePramiter) async{

    return await roomRepo.lockMic(upMicrophonePramiter);
  }

  Future<Either<String, Failure>> unLockMic(UpMicrophonePramiter upMicrophonePramiter) async{

    return await roomRepo.unLockMic(upMicrophonePramiter);
  }

}