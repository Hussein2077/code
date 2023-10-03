

import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/base_use_case/base_use_case.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/room_audio/domine/Repository/Base_Repository_Profile.dart';
import 'package:equatable/equatable.dart';

class BanUserFromWritingUC extends BaseUseCase<String,BanUserFromWritingPram>{


  final BaseRepositoryRoom roomRepo;

  BanUserFromWritingUC({required this.roomRepo});

  @override
  Future<Either<String, Failure>> call(BanUserFromWritingPram parameter)async {
    return await roomRepo.banUserFromWriting(parameter) ;

  }
}


class BanUserFromWritingPram extends Equatable{
  final String ownerId ;
  final String? userId ;
  final String? time ;
  final String type ; 
 const  BanUserFromWritingPram({required this.type ,  required this.ownerId, this.userId, this.time});

  @override
  List<Object?> get props => [ownerId,userId,time];



}