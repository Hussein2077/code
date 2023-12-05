import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/base_use_case/base_use_case.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/room_audio/domine/Repository/Base_Repository_Profile.dart';

class HostOnMicTimeUseCase extends BaseUseCase<String, int >{


  final BaseRepositoryRoom roomRepo;


  HostOnMicTimeUseCase({required this.roomRepo});

  @override
  Future<Either<String, Failure>> call(int time)async {
    final result = await roomRepo.hostTimeOnMic(time);
    return result ;
  }



}