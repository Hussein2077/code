
import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/base_use_case/base_use_case.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';




class DeleteAccountUC extends BaseUseCase<String,Noparamiter>{


  BaseRepositoryProfile baseRepositoryProfile ;


  DeleteAccountUC({ required this.baseRepositoryProfile});

  @override
  Future<Either<String, Failure>> call(Noparamiter parameter)async {
     final result= await baseRepositoryProfile.deleteAccount() ;
     return result ;
  }


}