import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/base_use_case/base_use_case.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/auth/domin/repo/base_repo.dart';




class SendCodeUseCase extends BaseUseCase<Unit,String>{

  BaseRepository baseRepository ;


  SendCodeUseCase({ required this.baseRepository});

  @override
  Future<Either<Unit, Failure>> call(String  parameter) async {

    final result = await baseRepository.resendCode(parameter) ;

    return result ;
  }
}