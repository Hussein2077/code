import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/base_use_case/base_use_case.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/auth/domin/repo/base_repo.dart';



//new
class RegisterVerificationUseCase extends BaseUseCase<Unit ,RegisterVerificationModel>{

  BaseRepository baseRepository ;


  RegisterVerificationUseCase({ required this.baseRepository});

  @override
  Future<Either<Unit, Failure>> call(RegisterVerificationModel parameter) async {

    final result = await baseRepository.registerVerification(parameter) ;

    return result ;
  }
}

class RegisterVerificationModel {
  final String uuid;
  final String code;
  final String deviceID;

  RegisterVerificationModel({required this.uuid, required this.code, required this.deviceID});
}