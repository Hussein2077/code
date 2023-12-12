import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/base_use_case/base_use_case.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/auth/domin/repo/base_repo.dart';



class ForgetPasswordUc {

  BaseRepository baseRepository ;
  ForgetPasswordUc({ required this.baseRepository});

  @override
  Future<Either<String, Failure>> call({required String phone, required String password, required String code})async {
    final result = await baseRepository.forgetPassword(phone: phone, password: password, code: code);
    return result ;
  }
}
