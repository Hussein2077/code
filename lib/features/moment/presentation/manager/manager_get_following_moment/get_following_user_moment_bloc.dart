
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/moment/domain/use_case/get_moment_use_case.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_get_following_moment/get_following_user_moment_event.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_get_following_moment/get_following_user_moment_state.dart';




class GetFollowingUserMomentBloc
    extends Bloc<BaseGetFollowingMomentEvent, GetFollowingUserMomentState> {
  final GetMomentUseCase getMomenttUseCase;
  int page = 1;
  GetFollowingUserMomentBloc({required this.getMomenttUseCase})
      : super(GetFollowingUserMomentInitial(null)) {
    on<GetFollowingMomentEvent>((event, emit) async {
      page = 1;
      emit(GetFollowingUserMomentLoadingState(null));
      final result = await getMomenttUseCase
          .call(GetMomentPrameter( page: page.toString(), userId: MyDataModel.getInstance().id.toString(),type: "3",));
      result.fold(
          (l) => emit(GetFollowingUserMomentSucssesState(data: l)),
          (r) => emit(GetFollowingUserMomentErrorState(
              null, DioHelper().getTypeOfFailure(r))));
    });

    on<LoadMoreFollowingMomentEvent>((event, emit) async {
      page++;
      final result = await getMomenttUseCase.call(GetMomentPrameter(
        page: page.toString(),
        userId: MyDataModel.getInstance().id.toString(),
        type: "3",

      ));
      result.fold((l) {
        if (l != []) {
          emit(GetFollowingUserMomentSucssesState(data: [...state.data!, ...l]));
        }
      },
          (r) => emit(GetFollowingUserMomentErrorState(
              null, DioHelper().getTypeOfFailure(r))));
    });
  }
}
