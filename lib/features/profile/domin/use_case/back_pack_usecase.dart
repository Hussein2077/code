

import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';
import 'package:tik_chat_v2/features/profile/domin/entitie/back_pack_entities.dart';


class GetBackPackUseCase {
  BaseRepositoryProfile baseRepositoryProfile;
  GetBackPackUseCase({required this.baseRepositoryProfile});
  Future<Either<List<BackPackEnities>, Failure>> getBackPack(String type) async {
    final result = await baseRepositoryProfile.getBckPack(type);
    return result ;
  }
}