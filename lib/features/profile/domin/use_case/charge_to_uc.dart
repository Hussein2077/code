

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/core/base_use_case/base_use_case.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/features/profile/data/model/charge_to_model.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';


class ChargeToUseCases extends BaseUseCase<ChargeToModel,ChargeToPramiter> {

  final BaseRepositoryProfile getChargeTo;


  ChargeToUseCases({required this.getChargeTo});

  @override
  Future<Either<ChargeToModel, Failure>> call(ChargeToPramiter parameter) async {
    final result = await getChargeTo.getChargeTo(parameter);

    return result;
  }
}
class ChargeToPramiter extends Equatable {
  final String toId ;
  final String usd ;

  const ChargeToPramiter({required this.toId,required this.usd});

  @override
  List<Object?> get props =>[toId,usd];


}