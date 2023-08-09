import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/base_use_case/base_use_case.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/profile/data/model/charge_history_model.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';

class GetChargeDolarsAgencyOwnerHistoryUseCase extends BaseUseCase <ChargeHistoryModel,String>{
  BaseRepositoryProfile chargeHistoryUc;


  GetChargeDolarsAgencyOwnerHistoryUseCase({required this.chargeHistoryUc});

  @override
  Future<Either<ChargeHistoryModel, Failure>> call(String parameter) {

    return chargeHistoryUc.getChargeDolarsAgencyOwnerHistory(parameter);

  }
}