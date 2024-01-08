import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/apple_pay_uc.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/huawei_pay_uc.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/google_pay_uc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/pay_manager/pay_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/pay_manager/pay_states.dart';

class PayBloc extends Bloc<PayEvent, payState> {
  PayUsecase payUsecase;
  HuaweiPayUsecase huaweiPayUsecase;
  ApplePayUsecase applePayUsecase;

  PayBloc(
      {required this.payUsecase,
      required this.huaweiPayUsecase,
      required this.applePayUsecase})
      : super(payInitial()) {
    on<GooglePay>((event, emit) async {
      emit(inAppPurchaseLoadingState());
      final result = await payUsecase.googlePay(data: event.data);
      result.fold(
          (l) => emit(inAppPurchaseSucssesState(massege: l)),
          (r) => emit(inAppPurchaseErrorState(
              massege: DioHelper().getTypeOfFailure(r))));
    });

    on<HuaweiPayNow>((event, emit) async {
      emit(huaweiPayLoadingState());
      final result = await huaweiPayUsecase.huaweiPay(
          product_id: event.product_id, token: event.token);
      result.fold(
          (l) => emit(huaweiPaySucssesState(massege: l)),
          (r) => emit(
              huaweiPayErrorState(massege: DioHelper().getTypeOfFailure(r))));
    });

    on<ApplePayNow>((event, emit) async {
      emit(applePayLoadingState());
      final result = await applePayUsecase.applePay(data: event.data);
      result.fold(
          (l) => emit(applePaySucssesState(massege: l)),
          (r) => emit(
              applePayErrorState(massege: DioHelper().getTypeOfFailure(r))));
    });
  }
}
