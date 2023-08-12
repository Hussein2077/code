import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/base_use_case/base_use_case.dart';
import 'package:tik_chat_v2/features/home/domin/repository/rebostory_ab.dart';
import 'package:tik_chat_v2/features/room/data/model/all_main_classes_model.dart';

import 'package:tik_chat_v2/core/error/failures.dart';


class GetAllRoomTypesUC extends BaseUseCase<List<AllMainClassesModel>,Noparamiter>{


  final RepoHome repoHome;


  GetAllRoomTypesUC({required this.repoHome});

  @override
  Future<Either<List<AllMainClassesModel>, Failure>> call(Noparamiter parameter) async {
    final result = await repoHome.getAllRoomTypes();

    return result ;
  }



}