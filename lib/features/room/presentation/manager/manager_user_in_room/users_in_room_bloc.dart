



import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/room/domine/use_case/invite_user_uc.dart';
import 'package:tik_chat_v2/features/room/domine/use_case/mute_unmute_use_uc.dart';
import 'package:tik_chat_v2/features/room/presentation/manager/manager_user_in_room/users_in_room_events.dart';
import 'package:tik_chat_v2/features/room/presentation/manager/manager_user_in_room/users_in_room_states.dart';



class UsersInRoomBloc extends Bloc<UsersInRoomEvents, OnUserInRoomStates> {
 final MuteUnMuteUserInRoomUC muteUnMuteUserInRoomUC ;
 final InviteUserUC inviteUserUC ;




 UsersInRoomBloc(
      {
        required this.inviteUserUC,
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

       on<InviteUserInRoom>(((event, emit) async {
      emit( const  InviteUserInRoomLoadingState());
      final result = await inviteUserUC
          .call(InviteUserPramiter(ownerId:event.ownerId,userId:event.userId, indexSeate: event.indexSeate)) ;
      result.fold(
              (l) => emit(UnMuteRoomSuccesState(succesMessage: StringManager.successfulOperation.tr())),
              (r) =>
              emit(InviteUserInRoomErrorState(
                      errorMessage: DioHelper().getTypeOfFailure(r))));
    }));
  }
}
