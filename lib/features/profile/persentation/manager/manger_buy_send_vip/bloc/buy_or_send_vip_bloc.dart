





import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/buy_or_send_vip.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manger_buy_send_vip/bloc/buy_or_send_vip_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manger_buy_send_vip/bloc/buy_or_send_vip_state.dart';

class BuyOrSendVipBloc extends Bloc<BuyOrSendVipEvent, BuyOrSendVipState> {
  BuyOrSendVipUseCase buyOrSendVipUseCase ;
  BuyOrSendVipBloc({required this.buyOrSendVipUseCase}) : super(BuyOrSendVipInitial()) {
    on<BuyOrSendVipEvent>((event, emit) async{
      emit(BuyOrSendVipLoadingState());
       final result = await buyOrSendVipUseCase.buyOrSendVip(event.type ,event.vipId , event.toUId);

      result.fold(
          (l) => emit(BuyOrSendVipSucssesState(
               massage: l,
              )),
          (r) =>
              emit(BuyOrSendVipErrorState(error: DioHelper().getTypeOfFailure(r))));

    });
  }
}
