import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/base_use_case/base_use_case.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/auth/domin/repo/base_repo.dart';



class ForgetPasswordUc extends BaseUseCase<String,String>{


  BaseRepository baseRepository ;


  ForgetPasswordUc({ required this.baseRepository});

  @override
  Future<Either<String, Failure>> call(String parameter)async {
    final result =await baseRepository.forgetPassword(parameter);
    return result ;
  }



}
