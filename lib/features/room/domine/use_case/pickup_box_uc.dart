
import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/base_use_case/base_use_case.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/room/domine/Repository/Base_Repository_Profile.dart';


class PickupBoxUC extends BaseUseCase<String,String>{

  final BaseRepositoryRoom roomRepo;


  PickupBoxUC({required this.roomRepo});

  @override
  Future<Either<String, Failure>> call(String parameter) async  {

    return await roomRepo.pickUpBox(parameter);
  }



}