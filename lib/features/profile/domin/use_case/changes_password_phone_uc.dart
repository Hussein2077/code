
import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/bound_platform_uc.dart';


class ChangesPasswordPhoneUc {

  BaseRepositoryProfile baseRepositoryProfile;
  ChangesPasswordPhoneUc({required this.baseRepositoryProfile});

  Future<Either<String,Failure>> changePassword(BoundNumberPramiter boundNumberPramiter ) async{
    final result = await baseRepositoryProfile.ChangePassword(boundNumberPramiter);
    return result ;
  }

  Future<Either<String,Failure>> changePhone(BoundNumberPramiter boundNumberPramiter) async{

    final result = await baseRepositoryProfile.ChangePhone(boundNumberPramiter);
    return result ;
  }

}