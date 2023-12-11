import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/base_use_case/base_use_case.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/auth/domin/repo/base_repo.dart';



class ForgetPasswordCheckCodeUc extends BaseUseCase<String ,ForgetPasswordCheckCodeParameters>{


  BaseRepository baseRepository ;


  ForgetPasswordCheckCodeUc({ required this.baseRepository});

  @override
  Future<Either<String , Failure>> call(ForgetPasswordCheckCodeParameters  parameter)async {
    final result =await baseRepository.forgetPasswordCheckCode(parameter);
    return result ;
  }



}


class ForgetPasswordCheckCodeParameters{
 final String code;
 final String phone;

 ForgetPasswordCheckCodeParameters({ required this.code,required this.phone});
}