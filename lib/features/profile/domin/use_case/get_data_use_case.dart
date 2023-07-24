

import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/base_use_case/base_use_case.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';
import 'package:tik_chat_v2/features/profile/domin/entitie/data_mall_entities.dart';



class GatDataMallUseCase extends BaseUseCase<List<DataMallEntities>,int>{

  BaseRepositoryProfile baseRepositoryProfile ;


  GatDataMallUseCase({required this.baseRepositoryProfile});

  @override
  Future<Either<List<DataMallEntities>, Failure>> call(int parameter) async {
    final result = await baseRepositoryProfile.getDataMall(parameter);
    return result ;
  }


}