

import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/base_use_case/base_use_case.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';


class GetVipCountUsecase {

  BaseRepositoryProfile baseRepositoryProfile ;


  GetVipCountUsecase({required this.baseRepositoryProfile});

  Future<Either<int,Failure>> call(Noparamiter parameter)async {
     final result =  await baseRepositoryProfile.getVipCount();
     return result ;
  }


}