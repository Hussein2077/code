import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/moment/domain/moment_usecse/make_moment_like.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_make_moment_like/make_moment_like_event.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_make_moment_like/make_moment_like_state.dart';


class MakeMomentLikeBloc
    extends Bloc<BaseMakeMomentLikeEvent, MakeMomentLikeStates> {
  final MakeMomentLikeUseCase makeMomentLikeUseCase;

  MakeMomentLikeBloc(
      {required this.makeMomentLikeUseCase}) :super(MakeMomentLikeInitial()){
    on<MakeMomentLikeEvent>((event, emit) async {
      emit(MakeMomentLikeLoadingState());
      final result = await makeMomentLikeUseCase.call(event.momentId);

      result.fold(
          (l) => emit(MakeMomentLikeSucssesState(  sucssesMessage: l)),
          (r) => emit(
              MakeMomentLikeErroeState(errorMessage: DioHelper().getTypeOfFailure(r))));
    });
  }
}
