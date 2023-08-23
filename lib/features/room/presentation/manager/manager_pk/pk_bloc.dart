
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/room/domine/use_case/close_pk_uc.dart';
import 'package:tik_chat_v2/features/room/domine/use_case/hide_pk_uc.dart';
import 'package:tik_chat_v2/features/room/domine/use_case/show_pk_uc.dart';
import 'package:tik_chat_v2/features/room/domine/use_case/start_pk_uc.dart';
import 'package:tik_chat_v2/features/room/presentation/manager/manager_pk/pk_events.dart';
import 'package:tik_chat_v2/features/room/presentation/manager/manager_pk/pk_states.dart';



class PKBloc extends Bloc<PKEvents,PKStates>{
  final ShowPKUC  showPKUC;
  final StartPKUC startPKUC;
  final ClosePKUC  closePKUC ;
  final HidePKUC hidePKUC ;

  PKBloc({ required this.showPKUC,
       required this.hidePKUC,
    required this.closePKUC, required this.startPKUC}):super(InitailPKState()){
   on<ShowPKEvent>(showPK);
   on<StartPKEvent>(startPK);
   on<ClosePKEvent>(closePK);
   on<HidePKEvent>(hidePk);
  }

  FutureOr<void> showPK(ShowPKEvent event, Emitter<PKStates> emit) async {
              emit(ShowStateLoading());
         final result= await showPKUC.call(event.ownerId);
         result.fold((l) => emit(ShowStateSuccess()),
                 (r) => emit(ShowStateError(errorMessage: DioHelper().getTypeOfFailure(r))));

  }



  FutureOr<void> startPK(StartPKEvent event, Emitter<PKStates> emit) async{
    emit(StartPKStateLoading());
    final result = await startPKUC.startPk(event.ownerId, event.time) ;

    result.fold((l) => emit(StartPKStateSuccess()),
            (r) => emit(StartPKStateError(errorMessage: DioHelper().getTypeOfFailure(r))));
  }

  FutureOr<void> closePK(ClosePKEvent event, Emitter<PKStates> emit) async {
    emit(ClosePKStateLoading());
    final result = await closePKUC.call(event.ownerId,event.pkId) ;

    result.fold((l) => emit(ClosePKStateSuccess()),
            (r) => emit(ClosePKStateError(errorMessage: DioHelper().getTypeOfFailure(r))));
  }

  FutureOr<void> hidePk(HidePKEvent event, Emitter<PKStates> emit) async {
    emit(HidePKStateLoading());
    final result = await hidePKUC.call(event.ownerId) ;

    result.fold((l) => emit(HidePKStateSuccess()),
            (r) => emit(HidePKStateError(errorMessage: DioHelper().getTypeOfFailure(r))));

  }
}