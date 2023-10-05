import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/base_use_case/base_use_case.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/room_audio/domine/Repository/Base_Repository_Profile.dart';


class HideRoomUseCase extends BaseUseCase<String,Noparamiter>{
  final BaseRepositoryRoom roomRepo;

  HideRoomUseCase({required this.roomRepo});


  @override
  Future<Either<String, Failure>> call(Noparamiter parameter) async {
    final result = await roomRepo.hideRoom();
    return result ;
  }


}