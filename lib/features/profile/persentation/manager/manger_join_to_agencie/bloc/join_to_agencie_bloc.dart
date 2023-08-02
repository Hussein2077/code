


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/join_to_agencie_usecase.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manger_join_to_agencie/bloc/join_to_agencie_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manger_join_to_agencie/bloc/join_to_agencie_state.dart';

class JoinToAgencieBloc extends Bloc<JoinToAgencieEvent, JoinToAgencieState> {
  JoinToAgencieUsecase joinToAgencieUsecase ; 
  JoinToAgencieBloc({required this.joinToAgencieUsecase}) : super(JoinToAgencieInitial()) {
    on<JoinToAgencieEvent>((event, emit) async{
        emit(JoinToAgencieLoadingState());
      final result = await joinToAgencieUsecase.joinToAgence(
          event.agencieId, event.whatsAppNum);

      result.fold(
          (l) => emit(JoinToAgencieSucssesState(success: l)),
          (r) => emit(
              JoinToAgencieErrorState(error: DioHelper().getTypeOfFailure(r))));
    });

    }
  }

