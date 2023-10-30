

import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/chat/data/data_source/remoted_dataSource_chat.dart';
import 'package:tik_chat_v2/features/chat/data/models/official_msgs_model.dart';
import 'package:tik_chat_v2/features/chat/domine/repository/base_repository_chat.dart';


import '../models/group_chat_model.dart';

class RepositoryImpChat extends BaseRepositoryChat {
  BaseDataSourceChat baseDataSourceChat;

  RepositoryImpChat({required this.baseDataSourceChat});

  @override
  Future<Either<OfficialSystemModel, Failure>> getOfficialMsg() async {
    try {
      final result = await baseDataSourceChat.getOfficailMsgs();
      return Left(result);
    } on Exception catch (e) {
      return right(DioHelper.buildFailure(e));
    }
   
  }
  
  @override
  Future<Either<String, Failure>> postGroupMassage(String massage)async {
   try {
      final result = await baseDataSourceChat.postGroupMassage(  massage);
      return Left(result);
    } on Exception catch (e) {
      return right(DioHelper.buildFailure(e));
    }
  }

  @override
  Future<Either<List<GroupChatModel>, Failure>> getGroupMassage(String?page)async {
    try {
      final result = await baseDataSourceChat.getGroupMassage( page);
      return Left(result);
    } on Exception catch (e) {
      return right(DioHelper.buildFailure(e));
    }
}
}
