

import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/room/domine/Repository/Base_Repository_Profile.dart';


class RemoveChatUC {
  final BaseRepositoryRoom roomRepo;

  RemoveChatUC({required this.roomRepo});


  Future<Either<Unit, Failure>> call(String ownerId) async {
    return await roomRepo.removeChat(ownerId);
  }
}

