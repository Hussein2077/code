


import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/chat/data/models/official_msgs_model.dart';
import 'package:tik_chat_v2/features/chat/domine/repository/base_repository_chat.dart';

import '../../../../core/base_use_case/base_use_case.dart';


class GetOfficialMsgUC extends BaseUseCase<OfficialSystemModel,Noparamiter>{

  BaseRepositoryChat baseRepositoryChat ;


  GetOfficialMsgUC({required this.baseRepositoryChat});

  @override
  Future<Either<OfficialSystemModel, Failure>> call(Noparamiter noparamiter) async {
    final result = await baseRepositoryChat.getOfficialMsg();
    return result ;
  }


}