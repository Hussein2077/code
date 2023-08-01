import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/auth/domin/repo/base_repo.dart';


class LogOutUseCase {


  BaseRepository baseRepository ;


  LogOutUseCase({ required this.baseRepository});

  Future<Either<String, Failure>> call()async {
    final result =await baseRepository.logOut();

    return result ;
  }



}