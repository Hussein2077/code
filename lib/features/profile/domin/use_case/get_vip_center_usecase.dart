
import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/core/model/vip_center_model.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';


class GetVipCenterUsecase{

  BaseRepositoryProfile baseRepositoryProfile;
  GetVipCenterUsecase({required this.baseRepositoryProfile});

  Future<Either<List<VipCenterModel>, Failure>> getVipCenter()async {
     final result = await baseRepositoryProfile.getVipCenter();
     return result ;
  }


}