
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/core/base_use_case/base_use_case.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/room/domine/Repository/Base_Repository_Profile.dart';


class SendBoxUC extends BaseUseCase<Unit,LuckyBoxPramiter>{

  final BaseRepositoryRoom roomRepo;


  SendBoxUC({required this.roomRepo});

  @override
  Future<Either<Unit, Failure>> call(LuckyBoxPramiter parameter) async  {
     return await roomRepo.sendBox(parameter) ;
  }


}
class LuckyBoxPramiter extends Equatable {
  final String boxId ;
  final String ownerId ;
  final String quintity ;

  const LuckyBoxPramiter({required this.boxId,required this.ownerId ,required this.quintity});

  @override
  List<Object?> get props => [boxId,ownerId,quintity];




}
