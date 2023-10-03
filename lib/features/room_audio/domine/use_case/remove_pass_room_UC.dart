
import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/base_use_case/base_use_case.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/room_audio/domine/Repository/Base_Repository_Profile.dart';


class RemovePassRoomUC extends BaseUseCase<String,String>{

  final BaseRepositoryRoom roomRepo;


  RemovePassRoomUC({required this.roomRepo});

  @override
  Future<Either<String, Failure>> call(String parameter) async {
    final result = await roomRepo.removePassRoom( parameter);
    return result ;
  }
}