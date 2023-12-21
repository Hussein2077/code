import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/base_use_case/base_use_case.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/ExtraRoomDataModel.dart';
import 'package:tik_chat_v2/features/room_audio/domine/Repository/Base_Repository_Profile.dart';

class ExtraRoomDataUseCase extends BaseUseCase<ExtraRoomDataModel, String >{

  final BaseRepositoryRoom roomRepo;
  ExtraRoomDataUseCase({required this.roomRepo});

  @override
  Future<Either<ExtraRoomDataModel, Failure>> call(String parameter)async {
    final result = await roomRepo.extraRoomData(parameter);
    return result ;
  }
}