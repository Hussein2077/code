import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/base_use_case/base_use_case.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/moment/data/model/moment_gift_model.dart';
import 'package:tik_chat_v2/features/moment/domain/repository/base_repository_moment.dart';


class GetMomentGiftsUseCase extends BaseUseCase<List<MomentGiftsModel>,GetMomentGiftsPrameter> {

BaseRepositoryMoment baseRepositoryMoment;
GetMomentGiftsUseCase({required this.baseRepositoryMoment});

  @override
  Future<Either<List<MomentGiftsModel>, Failure>> call(GetMomentGiftsPrameter param) async{
   final result = await baseRepositoryMoment.getMomentGifts(param);
   return result;
  }
}
class GetMomentGiftsPrameter {
  final String page ;
  final String momentId ;
  const GetMomentGiftsPrameter({required this.page , required this.momentId});


}