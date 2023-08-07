

import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/base_use_case/base_use_case.dart';
import 'package:tik_chat_v2/features/room/data/model/box_lucky_model.dart';
import 'package:tik_chat_v2/features/room/domine/Repository/Base_Repository_Profile.dart';

import 'package:tik_chat_v2/core/error/failures.dart';

class GetBoxexUC extends BaseUseCase<BoxLuckyModel,Noparamiter>{
  final BaseRepositoryRoom roomRepo;
  GetBoxexUC({ required this.roomRepo});





  @override
  Future<Either<BoxLuckyModel, Failure>> call(Noparamiter parameter) async  {
    return await roomRepo.getBoxes();
  }


}