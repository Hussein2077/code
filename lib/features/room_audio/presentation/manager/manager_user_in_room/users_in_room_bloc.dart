import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/kickout_pramiter_uc.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/mute_unmute_use_uc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manager_user_in_room/users_in_room_events.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manager_user_in_room/users_in_room_states.dart';


class UsersInRoomBloc extends Bloc<UsersInRoomEvents, OnUserInRoomStates> {
 final MuteUnMuteUserInRoomUC muteUnMuteUserInRoomUC ;
 final KickoutUC kickoutUC ;




 UsersInRoomBloc(
      {
        required this.kickoutUC,
        required this.muteUnMuteUserInRoomUC,
      })
      : super(const OnUserInRoomInitialState()) {
    on<MuteUserInRoom>(((event, emit) async {
      emit(const MuteUserInRoomLoadingState());
      final result = await muteUnMuteUserInRoomUC
          .call(MuteUnmutePramiters(ownerId:event.ownerId,userId:event.userId, mute: true)) ;
      result.fold(
              (l) => emit(MuteRoomSuccesState(succesMessage: StringManager.successfulOperation.tr())),
              (r) =>
              emit(
                  MuteUserInRoomErrorState(
                       errorMessage: DioHelper().getTypeOfFailure(r)))
                       );
    }));

    on<UnMuteUserInRoom>(((event, emit) async {
      emit( const  UnMuteUserInRoomLoadingState());
      final result = await muteUnMuteUserInRoomUC
          .call(MuteUnmutePramiters(ownerId:event.ownerId,userId:event.userId, mute: false)) ;
      result.fold(
              (l) => emit(UnMuteRoomSuccesState(succesMessage: StringManager.successfulOperation.tr())),
              (r) =>
              emit(
                  UnMuteUserInRoomErrorState(
                      errorMessage: DioHelper().getTypeOfFailure(r))));
    }));

    on<kickoutUser>(((event,emit)async{
      emit(LoadingKickoutState());

      final result = await kickoutUC.call(
          KickoutPramiterUc(ownerId: event.ownerId, userId: event.userId, minutes:event.minutes));

      result.fold((l) => emit(SuccessKickoutState(successMessage: l)),
              (r) => emit(ErrorKickoutState(errorMessage: DioHelper().getTypeOfFailure(r))));

    }));
  }
}
