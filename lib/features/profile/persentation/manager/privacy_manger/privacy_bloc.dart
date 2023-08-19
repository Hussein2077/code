import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/vipPervilage_usecase/prev_active_usecase.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/vipPervilage_usecase/prev_dispose_use_case.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/privacy_manger/privacy_state.dart';

import 'privacy_event.dart';

class PrivacyBloc extends Bloc<PrivacyEvent, PrivacyState> {
  PrevActiveUseCases prevActiveUseCases;
  PrevDisposeUseCases prevDisposeUseCases;


  PrivacyBloc(
      {
  
      required this.prevDisposeUseCases,
      required this.prevActiveUseCases})
      : super(PrivacyInitial()) {
    on<AtivePrev>(activePrevliage);
        on<DisposeePrev>(disposePrevliage);


  }

  


  FutureOr<void> activePrevliage(AtivePrev event, Emitter<PrivacyState> emit)async {
    emit(LoadingState());
    final result = await prevActiveUseCases.prevActive(event.type);
    result.fold((l) => emit(SucssesState(massege: l)), (r) => emit(ErrorState(massege: DioHelper().getTypeOfFailure(r))));
    

  }

  FutureOr<void> disposePrevliage(DisposeePrev event, Emitter<PrivacyState> emit) async{

      emit(LoadingState());
    final result = await prevDisposeUseCases.prevDispose(event.type);
    result.fold((l) => emit(SucssesState(massege: l)), (r) => emit(ErrorState(massege: DioHelper().getTypeOfFailure(r))));
  }
}
