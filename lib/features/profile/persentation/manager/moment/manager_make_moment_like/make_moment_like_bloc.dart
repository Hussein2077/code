import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/moment_usecse/make_moment_like.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/moment/manager_make_moment_like/make_moment_like_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/moment/manager_make_moment_like/make_moment_like_state.dart';

class MakeMomentLikeBloc
    extends Bloc<BaseMakeMomentLikeEvent, MakeMomentLikeStates> {
  final MakeMomentLikeUseCase makeMomentLikeUseCase;

  MakeMomentLikeBloc(super.initialState,
      {required this.makeMomentLikeUseCase}) {
    on<MakeMomentLikeEvent>((event, emit) async {
      emit(MakeMomentLikeLoadingState());
      final result = await makeMomentLikeUseCase.call(event.userId);

      result.fold(
          (l) => emit(MakeMomentLikeSucssesState(  sucssesMessage: l)),
          (r) => emit(
              MakeMomentLikeErroeState(errorMessage: DioHelper().getTypeOfFailure(r))));
    });
  }
}
