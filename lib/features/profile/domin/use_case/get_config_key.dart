import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/profile/data/model/get_config_key_model.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';



class GetConfigKeyUc {
  BaseRepositoryProfile baseRepositoryProfile;

  GetConfigKeyUc({required this.baseRepositoryProfile});

  Future<Either<GetConfigKeyModel, Failure>> call(
      GetConfigKeyPram parameter) async {
    final result = await baseRepositoryProfile.getConfigKey(parameter);
    return result;
  }
}

class GetConfigKeyPram extends Equatable {
  final String? specialBar;



  const GetConfigKeyPram({ this.specialBar, });

  @override
  List<Object?> get props => [specialBar];
}