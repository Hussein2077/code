import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/family_room_usecase.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_family_room/bloc/family_room_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_family_room/bloc/family_room_state.dart';

class FamilyRoomBloc extends Bloc<FamilyRoomEvent, FamilyRoomState> {
  GetFamilyRoomUsecase getFamilyRoomUsecase;
  FamilyRoomBloc({required this.getFamilyRoomUsecase})
      : super(FamilyRoomInitial()) {
    on<GetFamilyRoomevent>((event, emit) async {
      emit(FamilyRoomLoadingState());
      final result = await getFamilyRoomUsecase.getFamilyRooms(event.familyId);

      result.fold(
          (l) => emit(FamilyRoomSucssesState(data: l)),
          (r) => emit(
              FamilyRoomLErrorState(error: DioHelper().getTypeOfFailure(r))));
    });
  }
}
