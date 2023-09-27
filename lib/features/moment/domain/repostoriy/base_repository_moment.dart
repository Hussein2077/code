import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/moment/data/model/moment_comment_model.dart';
import 'package:tik_chat_v2/features/moment/data/model/moment_like_model.dart';
import 'package:tik_chat_v2/features/moment/domain/use_case/add_moment_comment_use_case.dart';
import 'package:tik_chat_v2/features/moment/domain/use_case/add_moment_use_case.dart';
import 'package:tik_chat_v2/features/moment/domain/use_case/delete_moment_comment_use_case.dart';
import 'package:tik_chat_v2/features/moment/domain/use_case/get_moment_comment_usecase.dart';
import 'package:tik_chat_v2/features/moment/domain/use_case/get_moment_likes_uc.dart';
import 'package:tik_chat_v2/features/moment/domain/use_case/moment_send_gift.dart';
import 'package:tik_chat_v2/features/moment/data/model/moment_model.dart';

abstract class BaseRespositryMoment{

  Future<Either<String, Failure>> addMoment(AddMomentPrameter addMomentPrameter);
  Future<Either<String, Failure>> deleteMoment(String momentId);
  Future<Either<String, Failure>> addMomentComment(AddMomentCommentPrameter addMomentCommentPrameter );
  Future<Either<String, Failure>> deleteMomentComment(DeleteMomentCommentPrameter deleteMomentCommentPrameter );
  Future<Either<List<MomentCommentModel>,Failure>> getMomentComment(GetMomentCommentPrameter getMomentCommentPrameter);
  Future<Either<String, Failure>> makeMomentLike(String momentId);

  Future<Either<List<MomentModel>, Failure>> getMoment(String userId);
  Future<Either<String, Failure>> momentSendGift(MomentSendGiftPrameter momentSEndGiftPrameter);
  Future<Either<List<MomentLikeModel>,Failure>> getMomentLike(GetMomentLikePrameter getMomentLikePrameter);

}