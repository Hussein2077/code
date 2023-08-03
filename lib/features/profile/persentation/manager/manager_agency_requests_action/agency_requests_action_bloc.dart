

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/agency_requests_action_uc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_agency_requests_action/agency_requests_action_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_agency_requests_action/agency_requests_action_state.dart';

class AgencyRequestsActionBloc extends Bloc<BaseAgencyRequestsActionEvent, AgencyRequestsActionState> {
  final AgencyRequestsActionUsecase agencyRequestsActionUsecase ; 
  AgencyRequestsActionBloc({required this.agencyRequestsActionUsecase}) : super(AgencyRequestsActionInitial()) {
    on<AgencyRequestsActionEvent>((event, emit) async{
      emit(AgencyRequestsActionLoadingState());
final result = await agencyRequestsActionUsecase.agencyRequsetsAction(userId: event.userId, accept: event.accept);

result.fold((l) => emit(AgencyRequestsActionSucssesState(message: l)), (r) => emit(AgencyRequestsActionErrorState(error: DioHelper().getTypeOfFailure(r))));
      
    });
  }
}

