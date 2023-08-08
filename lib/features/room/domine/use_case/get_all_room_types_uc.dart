import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/base_use_case/base_use_case.dart';
import 'package:tik_chat_v2/features/room/data/model/all_main_classes_model.dart';
import 'package:tik_chat_v2/features/room/domine/Repository/Base_Repository_Profile.dart';

import 'package:tik_chat_v2/core/error/failures.dart';


class GetAllRoomTypesUC extends BaseUseCase<List<AllMainClassesModel>,Noparamiter>{


  final BaseRepositoryRoom roomRepo;


  GetAllRoomTypesUC({required this.roomRepo});

  @override
  Future<Either<List<AllMainClassesModel>, Failure>> call(Noparamiter parameter) async {
    final result = await roomRepo.getAllRoomTypes();

    return result ;
  }



}