


import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/send_gift_use_case.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/send_gift_manger/send_gift_events.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/send_gift_manger/send_gift_states.dart';


class SendGiftBloc extends Bloc<SendGiftEvents,SendGiftStates>{
  final SendGiftUseCase giftUseCase ;

  SendGiftBloc({required this.giftUseCase}): super(IntialSendGiftStates()){


    on<SendGiftesEvent>(getSendGift);

      }


  FutureOr<void> getSendGift(SendGiftesEvent event, Emitter<SendGiftStates> emit) async {
  emit (LoadingSendGiftStates());
    final result = await giftUseCase.call(
        GiftPramiter(ownerId: event.ownerId, id: event.id,
            toUid: event.toUid,
            num: event.num,
            toZego:  event.toZego

        ));

  result.fold((l) => emit(SuccessSendGiftStates(successMessage: l)),
          (r) => emit(ErrorSendGiftStates(errorMessage: DioHelper().getTypeOfFailure(r))));


  }
}