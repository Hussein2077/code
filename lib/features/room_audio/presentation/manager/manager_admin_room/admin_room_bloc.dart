
import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/add_admin_uc.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/remove_admin_uc.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/room_admins_uc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manager_admin_room/admin_room_events.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manager_admin_room/admin_room_states.dart';



class AdminRoomBloc extends Bloc<AdminRoomEvents,AdminRoomStates>{


  final RemoveAdminUC removeAdminUC ;
  final AddAdminUC addAdminUC ;
  final RoomAdminsUC roomAdminsUC ;

  AdminRoomBloc({required this.removeAdminUC, required this.roomAdminsUC, required this.addAdminUC}):super(InitialAdminRoomState()){
    on<AddAdminEvent>(addAdmin);
    on<RemoveAdminEvent>(removeAdmin);
    on<GetAdminsEvent>(getAdmins);
  }

  FutureOr<void> addAdmin(AddAdminEvent event, Emitter<AdminRoomStates> emit) async{
    emit(LoadindAddAdminRoomState());
    final result =await addAdminUC.call(event.ownerId, event.userId);

    result.fold((l) => emit(SuccessAddAdminRoomState()),
            (r) => emit(ErrorAddAdminRoomState(errorMessage: DioHelper().getTypeOfFailure(r))));
  }

  FutureOr<void> removeAdmin(RemoveAdminEvent event, Emitter<AdminRoomStates> emit)  async{
    emit(LoadingRemoveAdminRoomState());
    final result =await removeAdminUC.call(event.ownerId, event.userId);

    result.fold((l) => emit(SuccessRemoveAdminRoomState()),
            (r) => emit(ErrorRemoveAdminRoomState(errorMessage: DioHelper().getTypeOfFailure(r))));
  }

  FutureOr<void> getAdmins(GetAdminsEvent event, Emitter<AdminRoomStates> emit)  async{
    emit(LoadingAdminsRoomState());
    final result =await roomAdminsUC.call(event.ownerId);

    result.fold((l) => emit(SuccessAdminsRoomState(admins: l)),
            (r) => emit(ErrorAdminsRoomState(errorMessage: DioHelper().getTypeOfFailure(r))));
  }
}