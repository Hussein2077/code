import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/moment/domain/moment_usecse/moment_send_gift.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_moment_send_gift/moment_send_gift_event.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_moment_send_gift/moment_send_gift_state.dart';

class MomentSendGiftBloc
    extends Bloc<MomentSendGiftEvent, MomentSendGiftStates> {
  final MomentSendGiftUseCase momentSendGiftUseCase;

  MomentSendGiftBloc({required this.momentSendGiftUseCase})
      : super(MomentSEndGiftInitialState()) {
    on<MomentSendGiftEvent>((event, emit) async {
      emit(MomentSEndGiftLoadingState());
      final result = await momentSendGiftUseCase.call(
        MomentSendGiftPrameter(
            giftNum: event.giftNum,
            momentId: event.momentId,
            giftId: event.giftId),
      );
      result.fold(
              (l) => emit(MomentSendGiftSucssesState(sucssesMessage: l)),
              (r) {
                log(r.toString());
              emit(MomentSEndGiftErrorState(
                  errorMessage: DioHelper().getTypeOfFailure(r)));});
    });
  }
}
