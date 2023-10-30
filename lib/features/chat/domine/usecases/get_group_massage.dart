import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/chat/domine/repository/base_repository_chat.dart';


import '../../data/models/group_chat_model.dart';

class GetGroupMassageUseCase {

  BaseRepositoryChat baseRepositoryChat ;


  GetGroupMassageUseCase({required this.baseRepositoryChat});

  @override
  Future<Either<List<GroupChatModel>, Failure>> call(String?page) async {
    final result = await baseRepositoryChat.getGroupMassage(page);
    return result ;
  }


}