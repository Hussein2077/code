
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/moment_usecse/moment_send_gift.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/moment/manager_moment_send_gift/moment_send_gift_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/moment/manager_moment_send_gift/moment_send_gift_state.dart';

class MomentSendGiftBloc
    extends Bloc<MomentSendGiftEvent, MomentSendGiftStates> {
  final MomentSendGiftUseCase momentSendGiftUseCase;

  MomentSendGiftBloc(
      {required this.momentSendGiftUseCase}):super(MomentSEndGiftInitialState()) {
    on<MomentSendGiftEvent>((event, emit) async {
      emit(MomentSEndGiftLoadingState());
      final result = await momentSendGiftUseCase.call(event.momentSendGiftPrameter);

      result.fold(
              (l) => emit(MomentSendGiftSucssesState(  sucssesMessage: l)),
              (r) => emit(
                  MomentSEndGiftErrorState(errorMessage: DioHelper().getTypeOfFailure(r))));
    });
  }
}
