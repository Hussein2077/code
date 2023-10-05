
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/core/base_use_case/base_use_case.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/room_audio/domine/Repository/Base_Repository_Profile.dart';

class KickoutUC extends BaseUseCase<String,KickoutPramiterUc>{


  final BaseRepositoryRoom roomRepo;


  KickoutUC({required this.roomRepo});

  @override
  Future<Either<String, Failure>> call(KickoutPramiterUc parameter)  async{
     final result = await roomRepo.kickoutUser(parameter) ;

     return result ;
  }


}

class KickoutPramiterUc extends Equatable {

  final String ownerId ;
  final String userId ;
  final String minutes ;

 const KickoutPramiterUc({required this.ownerId,required this.userId, required this.minutes});

  @override
  List<Object?> get props => [ownerId,userId,minutes];


}