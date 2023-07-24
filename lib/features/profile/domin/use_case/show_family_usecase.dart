

import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/profile/data/model/show_family_model.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';


class ShowFamilymUsecase {
  BaseRepositoryProfile baseRepositoryProfile;
  ShowFamilymUsecase({required this.baseRepositoryProfile});
  Future<Either<ShowFamilyModel, Failure>> showFmily(String id) async {
    final result = await baseRepositoryProfile.showFamily(id);
    return result;
  }
}
