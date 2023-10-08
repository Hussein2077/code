import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/moment/data/model/moment_comment_model.dart';
import 'package:tik_chat_v2/features/moment/data/model/moment_gift_model.dart';
import 'package:tik_chat_v2/features/moment/data/model/moment_like_model.dart';
import 'package:tik_chat_v2/features/moment/data/model/moment_model.dart';
import 'package:tik_chat_v2/features/moment/domain/moment_usecse/add_moment_comment_use_case.dart';
import 'package:tik_chat_v2/features/moment/domain/moment_usecse/add_moment_use_case.dart';
import 'package:tik_chat_v2/features/moment/domain/moment_usecse/delete_moment_comment_use_case.dart';
import 'package:tik_chat_v2/features/moment/domain/moment_usecse/get_moment_comment_usecase.dart';
import 'package:tik_chat_v2/features/moment/domain/moment_usecse/get_moment_gifts_uc.dart';
import 'package:tik_chat_v2/features/moment/domain/moment_usecse/get_moment_likes_uc.dart';
import 'package:tik_chat_v2/features/moment/domain/moment_usecse/get_moment_use_case.dart';
import 'package:tik_chat_v2/features/moment/domain/moment_usecse/moment_send_gift.dart';


abstract class BaseRepositoryMoment{


  Future<Either<String, Failure>> addMoment(AddMomentPrameter addMomentPrameter);
  Future<Either<String, Failure>> deleteMoment(String momentId);
  Future<Either<List<MomentModel>, Failure>> getMoment(GetMomentPrameter userId);
  Future<Either<String, Failure>> addMomentComment(AddMomentCommentPrameter addMomentCommentPrameter );
  Future<Either<String, Failure>> deleteMomentComment(DeleteMomentCommentPrameter deleteMomentCommentPrameter );
  Future<Either<List<MomentCommentModel>,Failure>> getMomentComment(GetMomentCommentPrameter getMomentCommentPrameter);
  Future<Either<String, Failure>> makeMomentLike(String momentId);
  Future<Either<String, Failure>> momentSendGift(MomentSendGiftPrameter momentSEndGiftPrameter);
  Future<Either<List<MomentLikeModel>,Failure>> getMomentLike(GetMomentLikePrameter getMomentLikePrameter);
  Future<Either<List<MomentGiftsModel>,Failure>> getMomentGifts(GetMomentGiftsPrameter getMomentGiftsPrameter);


}