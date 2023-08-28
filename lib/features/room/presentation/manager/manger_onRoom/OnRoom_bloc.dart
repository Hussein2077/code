import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/base_use_case/base_use_case.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/room/data/model/emojie_model.dart';
import 'package:tik_chat_v2/features/room/domine/use_case/background_usecase.dart';
import 'package:tik_chat_v2/features/room/domine/use_case/ban_user_from_writing_uc.dart';
import 'package:tik_chat_v2/features/room/domine/use_case/change_room_mode.dart';
import 'package:tik_chat_v2/features/room/domine/use_case/dispose_hide_room_uc.dart';
import 'package:tik_chat_v2/features/room/domine/use_case/emojie_usecase.dart';
import 'package:tik_chat_v2/features/room/domine/use_case/exist_room_uc.dart';
import 'package:tik_chat_v2/features/room/domine/use_case/get_all_room_user_usecase.dart';
import 'package:tik_chat_v2/features/room/domine/use_case/hide_room_use_case.dart';
import 'package:tik_chat_v2/features/room/domine/use_case/leave_mic_uc.dart';
import 'package:tik_chat_v2/features/room/domine/use_case/lock_unLock_mic_uc.dart';
import 'package:tik_chat_v2/features/room/domine/use_case/mute_unmute_mic_uc.dart';
import 'package:tik_chat_v2/features/room/domine/use_case/remove_pass_room_UC.dart';
import 'package:tik_chat_v2/features/room/domine/use_case/send_pob_up_uc.dart';
import 'package:tik_chat_v2/features/room/domine/use_case/up_mic_usecase.dart';
import 'package:tik_chat_v2/features/room/domine/use_case/update_room_usecase.dart';
import 'package:tik_chat_v2/features/room/presentation/manager/manger_onRoom/OnRoom_events.dart';
import 'package:tik_chat_v2/features/room/presentation/manager/manger_onRoom/OnRoom_states.dart';



class OnRoomBloc extends Bloc<OnRoomEvents, OnRoomStates> {
  final ExistroomUC existroomUC;
  final GetAllRoomUserUseCase getAllRoomUserUseCase;
  final BackGroundUseCase backGroundUseCase;
  final UpdateRoomUsecase updateRoomUsecase;
  final EmojieUseCase emojieUseCase;
  final RemovePassRoomUC removePassRoomUC;
  final UpMicUsecase upMicUsecase;
  final LeaveMicUC leaveMicUC;
  final MuteUnMuteMicUC muteUnMuteMicUC;
  final LockUnLockMicUC lockUnLockMicUC;
  final ChangeRoomModeUC changeRoomModeUC ;
  final BanUserFromWritingUC banUserFromWritingUC ;
  final SendPobUpUC sendPobUpUC ;
  final HideRoomUseCase hideRoomUseCase ;
  final DisposeHideRoomUseCase disposeHideRoomUseCase ;



  static OnRoomBloc get(context) => BlocProvider.of(context);
  List<EmojieModel>? allEmojie;
  OnRoomBloc(
      {
      required this.disposeHideRoomUseCase,
      required this.hideRoomUseCase ,
        required this.existroomUC,
        required this.banUserFromWritingUC,
        required this.sendPobUpUC,
      required this.upMicUsecase,
      required this.backGroundUseCase,
      required this.updateRoomUsecase,
      required this.getAllRoomUserUseCase,
      required this.changeRoomModeUC,
      required this.emojieUseCase,
      required this.removePassRoomUC,
      required this.leaveMicUC,
      required this.muteUnMuteMicUC,
      required this.lockUnLockMicUC})
      : super(const OnRoomInitialState()) {
    on<UpdateRoom>((event, emit) async {
      emit(const OnRoomLoadingState());
      final result = await updateRoomUsecase.updateRoom(
          PramiterUpdate(
        ownerId: event.ownerId,
        roomCover: event.roomCover,
        roomType: event.roomType,
        roomName: event.roomName,
        freeMic: event.freeMic,
        roomIntro: event.roomIntro,
        roomBackgroundId: event.roomBackgroundId,
        roomClass: event.roomClass,
        roomPass: event.roomPass,
        change: event.change,
      )
      );
      result.fold(
          (l) => emit(UpdateRoomErrorState(
              errorMassage: DioHelper().getTypeOfFailure(l))),
          (r) => emit(UpdateRoomSucsseState(data: r)));
    });

    on<InitEvent>((event, emit) async {
      emit(const OnRoomInitialState());
    });
    on<ExitRoomEvent>((event, emit) async {
      final result = await existroomUC.call(event.ownerId);
      result.fold(
          (l) => emit(const ExitRoomSuccesMessageState(
              succesMessage: "You leave room")),
          (r) => emit(ExitRoomErrorMessageState(
              errorMessage: DioHelper().getTypeOfFailure(r))));
    });

    on<RemovePassRoomEvent>((event, emit) async {
      final result = await removePassRoomUC.call(event.ownerId);
      result.fold(
          (l) => emit(const RemovePassRoomSucssesState(
              succecMassage: 'you remove  your Password')),
          (r) => emit(RemovePassRoomErrorState(
              errorMassage: DioHelper().getTypeOfFailure(r))));
    });

    on<GetAllRoomUserEvents>(((event, emit) async {
      emit(const GetAllRoomUserLoadingState());
      final result = await getAllRoomUserUseCase.getAllRoomUser(event.ownerId);
      result.fold(
          (l) => emit(GetAllRoomUsersuccessState(getRoomUsersEntite: l)),
          (r) => emit(GetAllRoomUserErrorState(
              errorMassage: DioHelper().getTypeOfFailure(r))));
    }));
    on<GetBackGroundEvent>(((event, emit) async {
      emit(GetBackGroundloadingState());
      final result = await backGroundUseCase.getBackGround();
      result.fold(
          (l) => emit(GetBackGroundSucsseState(data: l)),
          (r) => emit(GetBackGroundErrorState(
              errorMassage: DioHelper().getTypeOfFailure(r))));
    }));

    on<EmojieEvent>(((event, emit) async {
      emit(GetEmojieLoadingState());
      final result = await emojieUseCase.getEmojie();
      result.fold((l) {
        allEmojie = l;
        return emit(GetEmojieSucssesState(data: l));
      },
          (r) => emit(GetEmojieErrorState(
              errorMassage: DioHelper().getTypeOfFailure(r))));
    }));



    on<UpMicEvent>(((event, emit) async {
      emit(UpMicLoadingState());
      final result = await upMicUsecase.call(UpMicrophonePramiter(
          ownerId: event.ownerId,
          userId: event.userId,
          position: event.position));
      result.fold(
          (l) => emit(UpMicSucssesState(succecMassage: l)),
          (r) => emit(
              UpMicErrorState(errorMassage: DioHelper().getTypeOfFailure(r))));
    }));

    on<LeaveMicEvent>(((event, emit) async {
      emit(LeaveMicLoadingState());
      final result = await leaveMicUC.call(
          UpMicrophonePramiter(ownerId: event.ownerId, userId: event.userId));
      result.fold(
          (l) => emit(LeaveMicSucssesState(succecMassage: l)),
          (r) => emit(
              LeaveMicErrorState(errorMassage: DioHelper().getTypeOfFailure(r))));
    }));

    on<MuteMicEvent>(((event, emit) async {
      emit(MuteMicLoadingState());
      final result = await muteUnMuteMicUC.muteMic(
          UpMicrophonePramiter(ownerId: event.ownerId, position: event.position));
      result.fold(
          (l) => emit(MuteMicSucssesState(succecMassage: l)),
          (r) => emit(
              MuteMicErrorState(errorMassage: DioHelper().getTypeOfFailure(r))));
    }));

    on<UnMuteMicEvent>(((event, emit) async {
      emit(UnMuteMicLoadingState());
      final result = await muteUnMuteMicUC.unMuteMic(
          UpMicrophonePramiter(ownerId: event.ownerId, position: event.position));
      result.fold(
          (l) => emit(UnMuteMicSucssesState(succecMassage: l)),
          (r) => emit(UnMuteMicErrorState(
              errorMassage: DioHelper().getTypeOfFailure(r))));
    }));

    on<LockMicEvent>(((event, emit) async {
      emit(LockMicLoadingState());
      final result = await lockUnLockMicUC.lockMic(
          UpMicrophonePramiter(ownerId: event.ownerId, position: event.position));
      result.fold(
          (l) => emit(LockMicSucssesState(succecMassage: l)),
          (r) => emit(
              LockMicErrorState(errorMassage: DioHelper().getTypeOfFailure(r))));
    }));

    on<UnLockMicEvent>(((event, emit) async {
      emit(UnLockMicLoadingState());
      final result = await lockUnLockMicUC.unLockMic(
          UpMicrophonePramiter(ownerId: event.ownerId, position: event.position));
      result.fold(
          (l) => emit(UnLockMicSucssesState(succecMassage: l)),
          (r) => emit(UnLockMicErrorState(
              errorMassage: DioHelper().getTypeOfFailure(r))));
    }));

    on<ChangeModeRoomEvent>(((event, emit) async {
      emit(ChangeModeRoomLoadingState());
      final result = await changeRoomModeUC.changeRoomMode(event.ownerId, event.roomMode);
      result.fold(
              (l) => emit(ChangeModeRoomSuccessState(succecMassage: l)),
              (r) => emit(ChangeModeRoomErrorState(
              errorMassage: DioHelper().getTypeOfFailure(r))));
    }));



    on<BanUserFromWritingEvent>(((event, emit) async {
      emit(BanUserFromWritingLoadingState());
      final result = await banUserFromWritingUC.call(BanUserFromWritingPram(type: event.type, ownerId:event.ownerId,userId: event.userId ));
      result.fold(
              (l) => emit(BanUserFromWritingSuccessState(successMassage: StringManager.thisUserIsBaned.tr())),
              (r) => emit(BanUserFromWritingErrorState(
              errorMassage: DioHelper().getTypeOfFailure(r))));
    }));

    on<SendPobUpEvent>(((event, emit) async {
      emit(SendPobUpLoadingState());
      final result = await sendPobUpUC.call(SendPobUpPram(ownerId:event.ownerId, message: event.message));
      result.fold(
              (l) => emit(SendPobUpSuccessState(successMassage: StringManager.successfulOperation.tr())),
              (r) => emit(SendPobUpErrorState(
              errorMassage: DioHelper().getTypeOfFailure(r))));
    }));

      on<HideRoomEvent>(((event, emit) async {
      emit(HideRoomLoadingState());
      final result = await hideRoomUseCase.call(const  Noparamiter());
      result.fold(
              (l) => emit(HideRoomSuccessState(successMassage: StringManager.hideRoom.tr())),
              (r) => emit(HideRoomErrorState(
              errorMassage: DioHelper().getTypeOfFailure(r))));
    }));

        on<DisposeHideRoomEvent>(((event, emit) async {
      emit(HideRoomLoadingState());
      final result = await disposeHideRoomUseCase.call(const  Noparamiter());
      result.fold(
              (l) => emit(DisposeHideRoomSuccessState(successMassage: StringManager.hideRoom.tr())),
              (r) => emit(DisposeHideRoomErrorState(
              errorMassage: DioHelper().getTypeOfFailure(r))));
    }));
  }
}
