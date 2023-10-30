
import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/chat/data/models/official_msgs_model.dart';


import '../../data/models/group_chat_model.dart';

abstract class BaseRepositoryChat {

  Future<Either<OfficialSystemModel,Failure>> getOfficialMsg();
    Future<Either<String,Failure>> postGroupMassage(String massage);
    Future<Either<List<GroupChatModel>,Failure>> getGroupMassage(String?page);

}