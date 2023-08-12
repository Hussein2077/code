

import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/room/domine/use_case/kickout_pramiter_uc.dart';
import 'package:tik_chat_v2/features/room/presentation/manager/kickout_manger/kickout_events.dart';
import 'package:tik_chat_v2/features/room/presentation/manager/kickout_manger/kickout_states.dart';

class KickoutBloc extends Bloc<KickoutEvents,KickoutStates>{


  final KickoutUC kickoutUC ;

  KickoutBloc({required this.kickoutUC}):super(InitialKickoutState()){
    on<kickoutUser>(kickout);
  }

  FutureOr<void> kickout(kickoutUser event, Emitter<KickoutStates> emit) async{
     emit(LoadingKickoutState());

     final result = await kickoutUC.call(
         KickoutPramiterUc(ownerId: event.ownerId, userId: event.userId, minutes:event.minutes));

     result.fold((l) => emit(SuccessKickoutState(successMessage: l)),
             (r) => emit(ErrorKickoutState(errorMessage: DioHelper().getTypeOfFailure(r))));
  }

}