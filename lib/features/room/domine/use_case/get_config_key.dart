import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/profile/data/model/get_config_key_model.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/get_config_key.dart';
import 'package:tik_chat_v2/features/room/domine/Repository/Base_Repository_Profile.dart';



class GetConfigKeyUc {
  final BaseRepositoryRoom roomRepo;

  GetConfigKeyUc({required this.roomRepo});

  Future<Either<GetConfigKeyModel, Failure>> call(
      GetConfigKeyPram parameter) async {
    final result = await roomRepo.getConfigKey(parameter);
    return result;
  }
}

