

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/agency_requests_uc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_agency_requests/agency_requests_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_agency_requests/agency_requests_state.dart';

class AgencyRequestsBloc extends Bloc<BaseAgencyRequestsEvent, AgencyRequestsState> {
  final AgencyRequestsUsecase agencyRequestsUsecase ; 
  AgencyRequestsBloc({required this.agencyRequestsUsecase }) : super(AgencyRequestsInitial()) {
    on<AgencyRequestsEvent>((event, emit) async{
     emit(AgencyRequestsLoadingState());
     final result = await agencyRequestsUsecase.agencyRequsets();
      
      result.fold((l) => emit(AgencyRequestSucssesState(data: l)), (r) => emit(AgencyRequestsErrorState(error: DioHelper().getTypeOfFailure(r))));
    });
  }
}
