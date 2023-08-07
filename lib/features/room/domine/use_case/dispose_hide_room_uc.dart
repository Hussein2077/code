
import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/base_use_case/base_use_case.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/room/domine/Repository/Base_Repository_Profile.dart';


class DisposeHideRoomUseCase extends BaseUseCase<String,Noparamiter>{
  final BaseRepositoryRoom roomRepo;

  DisposeHideRoomUseCase({required this.roomRepo});


  @override
  Future<Either<String, Failure>> call(parameter) async {
    final result = await roomRepo.disposehideRoom();
    return result ;
  }


}