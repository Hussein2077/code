

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/get_mydata_usecase.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_my_data_manager/get_my_data_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_my_data_manager/get_my_data_state.dart';

import '../../../../../core/base_use_case/base_use_case.dart';

class GetMyDataBloc extends Bloc<BaseGetMyDataEvent, GetMyDataState> {
    final GetmyDataUsecase getmyDataUsecase;

  GetMyDataBloc({required this.getmyDataUsecase}) : super(GetMyDataInitial()) {
    on<GetMyDataEvent>((event, emit) async{
        emit(GetMyDataLoadingState());
      final result = await getmyDataUsecase.call(const Noparamiter());

      result.fold(
          (l) => emit(GetMyDataSucssesState(
               myDataModel: l,
              )),
          (r) =>
              emit(GetMyDataErrorState(errorMassage: DioHelper().getTypeOfFailure(r))));

      
    });
  }
}
