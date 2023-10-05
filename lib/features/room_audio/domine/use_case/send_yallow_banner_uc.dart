

import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/base_use_case/base_use_case.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/room_audio/domine/Repository/Base_Repository_Profile.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/send_pob_up_uc.dart';



class SendYallowBannerUC extends BaseUseCase<String,SendPobUpPram>{


  final BaseRepositoryRoom roomRepo;


  SendYallowBannerUC({required this.roomRepo});

  @override
  Future<Either<String,Failure>> call(SendPobUpPram sendPobUpPram) async {

    return await roomRepo.sendYallowBanner(sendPobUpPram);

  }


}

