
import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/base_use_case/base_use_case.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/moment/domain/repository/base_repository_moment.dart';


class MomentSendGiftUseCase extends BaseUseCase<String, MomentSendGiftPrameter> {
  BaseRepositoryMoment baseRepositoryMoment;
  MomentSendGiftUseCase({required this.baseRepositoryMoment});
  @override
  Future<Either<String, Failure>> call(MomentSendGiftPrameter parameter,) async {
    final result = await baseRepositoryMoment.momentSendGift(parameter);
    return result;
  }
}
class MomentSendGiftPrameter {
  final String momentId;

  final int giftId;

  final int giftNum;

  const MomentSendGiftPrameter(
      {required this.giftNum, required this.momentId, required this.giftId});
}
