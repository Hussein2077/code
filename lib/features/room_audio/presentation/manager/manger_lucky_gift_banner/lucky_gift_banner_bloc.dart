import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/send_gift_use_case.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/send_lucky_gift_uc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manger_lucky_gift_banner/lucky_gift_banner_event.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manger_lucky_gift_banner/lucky_gift_banner_state.dart';

class LuckyGiftBannerBloc
    extends Bloc<BaseLuckyGiftBannerEvent, LuckyGiftBannerState> {
  final SendLuckyGiftUc sendLuckyGiftUc;
  int giftNum = 1;
    int isFrist = 0 ;


  LuckyGiftBannerBloc({required this.sendLuckyGiftUc})
      : super(LuckyGiftBannerInitial()) {
    on<SendLuckyGiftEvent>((event, emit) async {
      final result = await sendLuckyGiftUc.call(GiftPramiter(
          id: event.id,
          num: event.num,
          ownerId: event.ownerId,
          toUid: event.toUid,
          toZego: "0"));
      result.fold((l) {
        isFrist++;
        emit(SendLuckyGiftSucssesState(giftNum: giftNum++ , data: l , isFirst: isFrist));



      },
          (r) => emit(SendLuckyGiftErrorStateState(
              error: DioHelper().getTypeOfFailure(r))));
    });

    on<EndBannerEvent>((event, emit) {
      giftNum = 0;
      isFrist =0 ;
    });
  }
}
