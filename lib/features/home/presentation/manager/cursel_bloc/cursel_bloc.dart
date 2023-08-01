





import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/base_use_case/base_use_case.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/home/domin/use_case/getcarousels_usecase.dart';
import 'package:tik_chat_v2/features/home/presentation/manager/cursel_bloc/cursel_events.dart';
import 'package:tik_chat_v2/features/home/presentation/manager/cursel_bloc/cursel_state.dart';

class CarouselBloc extends Bloc<GetCarouselEvents, CarouselStates> {
  final  GetCarouselsUsecase getCarouselsUsecase ;
  CarouselBloc({required this.getCarouselsUsecase})
      : super(CarouselInitial()) {
    on<GetCarouselEvent>((event, emit) async{
      emit(CarouselInitial());
      var result = await getCarouselsUsecase.call(const Noparamiter());
      result.fold((l) => emit(GetCarouselSuccesState(carouselsList: l
      )), (r) => emit(GetCarouselErrorState(  errorMessage: DioHelper().getTypeOfFailure(r))));
    });

    on<InitCarouselEvent>((event, emit) async{
      emit(CarouselInitial());

    });
}
}