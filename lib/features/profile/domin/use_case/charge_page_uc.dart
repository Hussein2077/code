

import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/base_use_case/base_use_case.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/profile/data/model/charge_page_model.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';


class ChargePageUseCases extends BaseUseCase<DataWalletModel,Noparamiter>{

  BaseRepositoryProfile  getChargePage ;


  ChargePageUseCases({required this.getChargePage});

  @override
  Future<Either<DataWalletModel, Failure>> call(Noparamiter parameter) async {

     final result = await getChargePage.getChargePage();

      return result;

  }

}