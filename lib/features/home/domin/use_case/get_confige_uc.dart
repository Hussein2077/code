

import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/base_use_case/base_use_case.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/home/data/model/config_model.dart';
import 'package:tik_chat_v2/features/home/domin/repository/rebostory_ab.dart';


class GetConfigeAppUseCase extends BaseUseCase<ConfigModel,ConfigModelBody>{
  RepoHome homeRepo ;


  GetConfigeAppUseCase({ required this.homeRepo});

  @override
  // ignore: avoid_renaming_method_parameters
  Future<Either<ConfigModel, Failure>> call(ConfigModelBody configModelBody) async{
    final result = await homeRepo.getConfigApp(configModelBody) ;
    return result ;
  }


}