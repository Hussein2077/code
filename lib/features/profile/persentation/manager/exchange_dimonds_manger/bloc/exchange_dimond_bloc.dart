
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/exchange_dimonds.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/exchange_dimonds_manger/bloc/exchange_dimond_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/exchange_dimonds_manger/bloc/exchange_dimond_state.dart';

class ExchangeDimondBloc extends Bloc<BaseExchangeDimondEvent, ExchangeDimondState> {
  ExchangeDimondsUseCase exchangeDimondsUseCase;
  ExchangeDimondBloc({required this.exchangeDimondsUseCase}) : super(ExchangeDimondInitial()) {
    on<ExchangeDimondEvent>((event, emit) async{
   emit(ExchangeDimondLoadingState());
   
     final result = await exchangeDimondsUseCase.exchangeDimonds(event.itemId);

      result.fold(
          (l) => emit(ExchangeDimondSucssesState(
               massage: l,
              )),
          (r) =>
              emit(ExchangeDimondErrorState(error: DioHelper().getTypeOfFailure(r))));
    });
  }
}
