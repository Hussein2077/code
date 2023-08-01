
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/get_config_key.dart';
import 'package:tik_chat_v2/features/profile/presentation/manager/manager_get_config_key/get_config_keys_event.dart';
import 'package:tik_chat_v2/features/profile/presentation/manager/manager_get_config_key/get_config_keys_state.dart';


class GetConfigKeysBloc
    extends Bloc<BaseGetConfigKeysEvent, GetConfigKeysState> {
  GetConfigKeyUc getConfigKeyUc;
  GetConfigKeysBloc({required this.getConfigKeyUc})
      : super(GetConfigKeysInitial()) {
    on<GetConfigKeyEvent>((event, emit) async {
      emit(GetConfigKeysLoading());
      final result = await getConfigKeyUc.call(event.getConfigKeyPram);
      result.fold(
          (l) => emit(GetConfigKeysSucsses(getConfigKey: l)),
          (r) =>
              emit(GetConfigKeysError(error: DioHelper().getTypeOfFailure(r))));
    });
  }
}
