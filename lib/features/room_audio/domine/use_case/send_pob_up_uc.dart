

import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/base_use_case/base_use_case.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/room_audio/domine/Repository/Base_Repository_Profile.dart';
import 'package:equatable/equatable.dart';


class SendPobUpUC extends BaseUseCase<String,SendPobUpPram>{


  final BaseRepositoryRoom roomRepo;


  SendPobUpUC({required this.roomRepo});

  @override
  Future<Either<String, Failure>> call(SendPobUpPram parameter) async {

    return await roomRepo.sendPobUp(parameter);

  }


}


class SendPobUpPram extends Equatable {


  final String ownerId;
 final String message ;
  const SendPobUpPram({required this.ownerId, required this.message});

  @override
  List<Object?> get props => [ownerId,message];
}