

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/in_app_purchase_uc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/in_app_purchase_manager/in_app_purchase_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/in_app_purchase_manager/in_app_purchase_states.dart';

class InAppPurchaseBloc extends Bloc<InAppPurchaseEvent, InAppPurchaseState> {

  final InAppPurchaseUsecase inAppPurchaseUsecase ; 
  InAppPurchaseBloc({required this.inAppPurchaseUsecase}) : super(InAppPurchaseInitial()) {

    on<PostInAppPurchaseEvent>((event, emit) async{
      emit(InAppPurchaseLoadingState());
final result = await inAppPurchaseUsecase.inAppPurchase(user_id: event.user_id, product_id: event.product_id);

result.fold((l) => emit(InAppPurchaseSucssesState(message: l)), (r) => emit(InAppPurchaseErrorState(error: DioHelper().getTypeOfFailure(r))));
      
    });
  }
}

