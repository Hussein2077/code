import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/auth/data/model/auth_with_google_model.dart';
import 'package:tik_chat_v2/features/auth/domin/repo/base_repo.dart';

import '../../../../core/base_use_case/base_use_case.dart';



class SignInWithGoogleUC extends BaseUseCase<AuthWithGoogleModel,Noparamiter>{

  BaseRepository baseRepository ;


  SignInWithGoogleUC({ required this.baseRepository});

  @override
  Future<Either<AuthWithGoogleModel, Failure>> call(Noparamiter parameter) async{

    final result =  await baseRepository.siginWithGoogle() ;

    return result ;
  }


}