
import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/base_use_case/base_use_case.dart';
import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/room_audio/domine/Repository/Base_Repository_Profile.dart';



class UpMicUsecase  extends BaseUseCase<String,UpMicrophonePramiter>{

  final BaseRepositoryRoom roomRepo;


  UpMicUsecase({required this.roomRepo});

  @override
  Future<Either<String, Failure>> call(UpMicrophonePramiter parameter) async {
   final result = await roomRepo.upMic(parameter);
   return result ;
  }


}


class UpMicrophonePramiter extends Equatable {

  final String ownerId;
  final String? userId ;
  final String? position ;
  final bool?  isSwitch ;

 const UpMicrophonePramiter({required this.ownerId,
   this.userId, this.position ,  this.isSwitch});

  @override
  List<Object?> get props =>[ownerId,userId,position,isSwitch];


}