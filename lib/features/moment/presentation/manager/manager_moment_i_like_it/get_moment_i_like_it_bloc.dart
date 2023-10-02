import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/moment/domain/use_case/get_moment_use_case.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_moment_i_like_it/get_moment_i_like_it_event.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_moment_i_like_it/get_moment_i_like_it_state.dart';



class GetMomentILikeItBloc
    extends Bloc<BaseGetMomentILikeItEvent, GetMomentILikeItUserState> {
  final GetMomentUseCase getMomenttUseCase;
  int page = 1;
  GetMomentILikeItBloc({required this.getMomenttUseCase})
      : super(GetMomentILikeItInitial(null)) {
    on<GetMomentIliKEitEvent>((event, emit) async {
      page = 1;
      emit(GetMomentILikeItLoadingState(null));
      final result = await getMomenttUseCase
          .call(GetMomentPrameter(page: page.toString(), userId: MyDataModel.getInstance().id.toString(),type: "2"));
      result.fold(
              (l) => emit(GetMomentILikeItSucssesState(data: l)),
              (r) => emit(GetMomentILikeItErrorState(
              null, DioHelper().getTypeOfFailure(r))));
    });

    on<LoadMoreMomentIlikeItEvent>((event, emit) async {
      page++;
      final result = await getMomenttUseCase.call(GetMomentPrameter(

        page: page.toString(),
        userId: MyDataModel.getInstance().id.toString(),
        type: "2",
      ));
      result.fold((l) {
        if (l != []) {
          emit(GetMomentILikeItSucssesState(data: [...state.data!, ...l]));
        }
      },
              (r) => emit(GetMomentILikeItErrorState(
              null, DioHelper().getTypeOfFailure(r))));
    });
  }
}
