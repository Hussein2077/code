import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/chat/domine/repository/base_repository_chat.dart';

import '../../../../core/base_use_case/base_use_case.dart';


class PostGroupMassageUseCase extends BaseUseCase<String,String>{

  BaseRepositoryChat baseRepositoryChat ;


  PostGroupMassageUseCase({required this.baseRepositoryChat});

  @override
  Future<Either<String, Failure>> call(String massage) async {
    final result = await baseRepositoryChat.postGroupMassage( massage);
    return result ;
  }


}