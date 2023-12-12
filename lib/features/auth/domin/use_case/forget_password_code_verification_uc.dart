import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/auth/domin/repo/base_repo.dart';



class ForgetPasswordCodeVerificationUc {

  BaseRepository baseRepository ;
  ForgetPasswordCodeVerificationUc({ required this.baseRepository});

  @override
  Future<Either<String, Failure>> call({required String phone, required String code})async {
    final result = await baseRepository.forgetPasswordCodeVerification(phone: phone, code: code);
    return result ;
  }
}
