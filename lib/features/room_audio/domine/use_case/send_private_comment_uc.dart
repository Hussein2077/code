import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/SendPrivateCommentModel.dart';
import 'package:tik_chat_v2/features/room_audio/domine/Repository/Base_Repository_Profile.dart';


class SendPrivateCommentUC {
  final BaseRepositoryRoom roomRepo;
  SendPrivateCommentUC({required this.roomRepo});

  Future<Either<SendPrivateCommentModel, Failure>> sendPrivateComment({required String userId, required String message, required String roomId}) async {
    return await roomRepo.sendPrivateComment(userId: userId, message: message, roomId: roomId);
  }

}