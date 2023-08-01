






import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/get_vistors_usecase.dart';

import 'vistors_event.dart';
import 'vistors_state.dart';

class VistorsBloc extends Bloc<VistorsEvent, VistorsState> {
  final GetVistorUseCase getVistorUseCase;
  bool isLoadingMore = false ;
  VistorsBloc({required this.getVistorUseCase}) : super(VistorsInitial(null)) {
    on<GetVistors>((event, emit) async {
      emit( GetVistorsLoadingState(null));
      final result = await getVistorUseCase.getVistors();
      result.fold((l) {
        emit(GetVistorsSucssesState(data: l));},
          (r) => emit(GetVistorsErrorState(null, DioHelper().getTypeOfFailure(r))));
    });
       on<GetMoreVistors>((event, emit) async {
            isLoadingMore = true ;

emit(GetVistorsSucssesState(data: [...state.data! ,]));
       var result = await getVistorUseCase.getVistors(page: event.page);
      result.fold((l) {
        isLoadingMore = false;

          if(l!=[]){  emit(GetVistorsSucssesState(data: [...state.data! , ...l]));}
      


      }, (r) {
            isLoadingMore = false ;
         emit(GetVistorsErrorState(
        null,  DioHelper().getTypeOfFailure(r)
      ));

      });
    });
  }
}
