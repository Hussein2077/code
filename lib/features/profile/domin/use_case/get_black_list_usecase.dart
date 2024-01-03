
import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/profile/data/model/black_list_model.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';

class GetBlackListUseCase {
  BaseRepositoryProfile baseRepositoryProfile;
  GetBlackListUseCase({required this.baseRepositoryProfile});
  Future<Either<BlackListModel, Failure>> getBlackList() async {
    final result = await baseRepositoryProfile.getBlackList();
    return result;
  }
}
