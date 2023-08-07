
import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/base_use_case/base_use_case.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/room/domine/Repository/Base_Repository_Profile.dart';
import 'package:tik_chat_v2/features/room/domine/use_case/upMic_usecase.dart';



class LeaveMicUC extends BaseUseCase<String,UpMicrophonePramiter>{
  final BaseRepositoryRoom roomRepo;


  LeaveMicUC({required this.roomRepo});

  @override
  Future<Either<String, Failure>> call(UpMicrophonePramiter parameter)async {
    return await roomRepo.leaveMic(parameter);
  }


}