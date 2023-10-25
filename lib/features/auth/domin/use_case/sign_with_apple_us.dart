import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/base_use_case/base_use_case.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/auth/data/model/auth_with_apple_model.dart';
import 'package:tik_chat_v2/features/auth/domin/repo/base_repo.dart';

class SignInWithAppleUC extends BaseUseCase<AuthWithAppleModel,Noparamiter>{

  BaseRepository baseRepository ;


  SignInWithAppleUC({ required this.baseRepository});

  @override
  Future<Either<AuthWithAppleModel, Failure>> call(Noparamiter parameter) async{

    final result =  await baseRepository.siginWithApple() ;

    return result ;
  }


}