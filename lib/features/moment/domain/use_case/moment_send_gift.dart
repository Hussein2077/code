import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/Base_Use_Case/Base_Use_Case.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/moment/domain/repostoriy/base_repository_moment.dart';

class MomentSendGiftUseCase extends BaseUseCase<String, MomentSendGiftPrameter> {
  BaseRespositryMoment baseRespositryMoment;
  MomentSendGiftUseCase({required this.baseRespositryMoment});
  @override
  Future<Either<String, Failure>> call(MomentSendGiftPrameter parameter) async {
    final result = await baseRespositryMoment.momentSendGift(parameter);
    return result;
  }
}

class MomentSendGiftPrameter {
  final String userId;

  final String giftId;

  final String giftNum;

  const MomentSendGiftPrameter(
      {required this.giftNum, required this.userId, required this.giftId});
}
