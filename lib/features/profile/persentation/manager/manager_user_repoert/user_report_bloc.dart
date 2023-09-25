

import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/user_reporet_uc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_user_repoert/user_report_state.dart';

import 'user_report_event.dart';


class UserReportBloc extends Bloc<UserReportEvent, UserReportState> {
  UserReporetUseCase userReporetUseCase ; 
  UserReportBloc({required this.userReporetUseCase}) : super(UserReportInitial()) {
    on<UserReporetEvent>((event, emit)async {
      emit(UserReportLoading());
      final result =await userReporetUseCase.call(UserReporetPramiter(id: event.id , image: event.image , reporetContetnt: event.reporetContetnt , typeReporet: event.typeReporet));
      result.fold((l) {
        log("bloc sucsses");
        
        emit(UserReportSucsses(message: l));}, (r) => emit(UserReportError(error: DioHelper().getTypeOfFailure(r))));
    });
  }
}
