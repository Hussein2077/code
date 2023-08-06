

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/charge_coin_for_users_uc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_charge_coin_for_user/charge_coin_for_user_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_charge_coin_for_user/charge_coin_for_user_state.dart';

class ChargeCoinForUserBloc extends Bloc<BaseChargeCoinForUserEvent, ChargeCoinForUserState> {
  final ChargeCoinForUserUsecase chargeCoinForUserUsecase ; 
  ChargeCoinForUserBloc({required this.chargeCoinForUserUsecase}) : super(ChargeCoinForUserInitial()) {
    on<ChargeCoinForUserEvent>((event, emit) async{
      emit(ChargeCoinForUserLoadingState());
      final result = await chargeCoinForUserUsecase.chargeCoinForUsers(id: event.id, amount: event.amount);

      result.fold((l) => emit(ChargeCoinForUserSucssesState(message: l)), (r) => emit(ChargeCoinForUserErrorState(error: DioHelper().getTypeOfFailure(r))));
      
    });
  }
}
