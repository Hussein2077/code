import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/charge_dolars_for_users_uc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_charge_dolars_for_user/charge_dolars_for_user_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_charge_dolars_for_user/charge_dolars_for_user_state.dart';

class ChargeDolarsForUserBloc
    extends Bloc<BaseChargeDolarsForUserEvent, ChargeDolarsForUserState> {
  final ChargeDolarsForUserUsecase chargeDolarsForUserUsecase;
  ChargeDolarsForUserBloc({required this.chargeDolarsForUserUsecase})
      : super(ChargeDolarsForUserInitial()) {
    on<ChargeDolarsForUserEvent>((event, emit) async {
      emit(ChargeDolarsForUserLoadingState());
      final result = await chargeDolarsForUserUsecase.chargeDolarsForUsers(
          id: event.id, amount: event.amount);
      result.fold(
          (l) => emit(ChargeDolarsForUserSucssesState(message: l)),
          (r) => emit(ChargeDolarsForUserErrorState(
              error: DioHelper().getTypeOfFailure(r))));
    });
  }
}
