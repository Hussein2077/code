import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/huawei_pay_uc.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/pay_uc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/pay_manager/pay_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/pay_manager/pay_states.dart';


class PayBloc extends Bloc<PayEvent, payState> {
  PayUsecase payUsecase;
  HuaweiPayUsecase huaweiPayUsecase;
  PayBloc({required this.payUsecase, required this.huaweiPayUsecase}) : super(payInitial()) {

    on<PayNow>((event, emit) async {
      emit(inAppPurchaseLoadingState());
      final result = await payUsecase.pay(product_id: event.product_id, order_id: event.order_id);
      result.fold((l) => emit(inAppPurchaseSucssesState(massege: l)),
              (r) => emit(inAppPurchaseErrorState(massege: DioHelper().getTypeOfFailure(r))));
    });

    on<HuaweiPayNow>((event, emit) async {
      emit(huaweiPayLoadingState());
      final result = await huaweiPayUsecase.huaweiPay(product_id: event.product_id, token: event.token);
      result.fold((l) => emit(huaweiPaySucssesState(massege: l)),
              (r) => emit(huaweiPayErrorState(massege: DioHelper().getTypeOfFailure(r))));
    });

  }

}
