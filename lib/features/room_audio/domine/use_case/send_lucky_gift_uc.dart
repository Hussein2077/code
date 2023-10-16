import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/base_use_case/base_use_case.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/lucky_gift_model.dart';
import 'package:tik_chat_v2/features/room_audio/domine/Repository/Base_Repository_Profile.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/send_gift_use_case.dart';

class SendLuckyGiftUc extends BaseUseCase<LuckyGiftModel,GiftPramiter>{

  final BaseRepositoryRoom roomRepo;


  SendLuckyGiftUc({required this.roomRepo});

  @override
  Future<Either<LuckyGiftModel, Failure>> call(GiftPramiter parameter) async{
     final result =  await roomRepo.sendLuckyGift(parameter);
     return result ;
  }

}