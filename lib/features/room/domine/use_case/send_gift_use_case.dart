
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/core/base_use_case/base_use_case.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/room/domine/Repository/Base_Repository_Profile.dart';


class SendGiftUseCase extends BaseUseCase<String,GiftPramiter>{

  final BaseRepositoryRoom roomRepo;


  SendGiftUseCase({required this.roomRepo});

  @override
  Future<Either<String, Failure>> call(GiftPramiter parameter) async{
     final result =  await roomRepo.sendGifts(parameter);
     return result ;
  }

}


class GiftPramiter  extends Equatable {
  final String ownerId;
  final  String id ;
  final String toUid ;
  final  String num ;
  final String toZego ;
 const GiftPramiter({
    required this.ownerId,required this.toZego ,required  this.id, required this.toUid,required this.num});

  @override
  List<Object?> get props => [
    ownerId,
     id ,
    toUid ,
     num ,
    toZego
  ];


}