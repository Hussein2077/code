import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/base_use_case/base_use_case.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/home/domin/use_case/get_country_usecase.dart';
import 'package:tik_chat_v2/features/home/presentation/manager/country_manager/counrty_event.dart';
import 'package:tik_chat_v2/features/home/presentation/manager/country_manager/counrty_state.dart';



class CounrtyBloc extends Bloc<CounrtyEvent, CountryStates> {

  final GetCountryUseCase getCountryUseCase;
  CounrtyBloc({ required this.getCountryUseCase}) : super(const CountryInitialState()) {
    on<GetAllCountryEvent>(getCountry);
  }

  FutureOr<void> getCountry(GetAllCountryEvent event, Emitter<CountryStates> emit) async{
     emit (const CountryLoadingState());
      final result =   await getCountryUseCase.call(const Noparamiter());
      result.fold( (l) => emit(CountrySuccesMessageState(countrys: l)),
              (r) => emit(CountryErrorMessageState(errorMessage: DioHelper().getTypeOfFailure(r, ))));

  }
}
