import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/auth/domin/repo/base_repo.dart';


class PrivacyPolicyUseCase {


  BaseRepository baseRepository ;


  PrivacyPolicyUseCase({ required this.baseRepository});

  @override
  Future<Either<String, Failure>> call()async {
    final result =await baseRepository.privacyPolicy();

    return result ;
  }



}