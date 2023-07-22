

import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/base_use_case/base_use_case.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/core/model/owner_data_model.dart';
import 'package:tik_chat_v2/features/auth/domin/repo/base_repo.dart';



class SignInWithFacebookUC extends BaseUseCase<OwnerDataModel,Noparamiter>{

  BaseRepository baseRepository ;


  SignInWithFacebookUC({ required this.baseRepository});

  @override
  Future<Either<OwnerDataModel, Failure>> call(Noparamiter parameter) async{

        final result =  await baseRepository.siginWithFacebook() ;

        return result ;
  }


}