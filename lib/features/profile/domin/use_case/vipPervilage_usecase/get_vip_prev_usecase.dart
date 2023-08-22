import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/profile/data/model/get_vip_prev.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';




class GetVipPrevUseCase {
  BaseRepositoryProfile baseRepositoryProfile;
  GetVipPrevUseCase({required this.baseRepositoryProfile});
  Future<Either<List<GetVipPrevModel>, Failure>> getVipPrevUseCase() async {
    return await baseRepositoryProfile.getVipPerv();
  }
}