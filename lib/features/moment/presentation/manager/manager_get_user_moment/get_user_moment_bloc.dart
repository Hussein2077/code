
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/moment/domain/moment_usecse/get_moment_use_case.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_get_user_moment/get_user_moment_event.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_get_user_moment/get_user_moment_state.dart';

class GetOtherUserMomentBloc
    extends Bloc<BaseGetOtherUserMomentEvent, GetMomentOtherUserState> {
  final GetMomentUseCase getMomentUseCase;

  int page = 1;

  GetOtherUserMomentBloc({required this.getMomentUseCase})
      : super(GetMomentOtherUserInitial(null)) {
    on<GetOtherUserMomentEvent>((event, emit) async {
      page = 1;
      emit(GetMomentOtherUserLoadingState(null));
      final result = await getMomentUseCase.call(GetMomentPrameter(
          type: "1", page: page.toString(), userId: event.userId));
      result.fold(
          (l) => emit(GetMomentOtherUserSucssesState(data: l)),
          (r) => emit(
              GetMomentOtherUserErrorState(null, DioHelper().getTypeOfFailure(r))));
    });

    on<LoadMoreOtherUserMomentEvent>((event, emit) async {
      page++;
      final result = await getMomentUseCase.call(GetMomentPrameter(
          type: "1", page: page.toString(), userId: event.userId));
      result.fold((l) {
        if (l != []) {
          emit(GetMomentOtherUserSucssesState(data: [...state.data!, ...l]));
        }
      },
          (r) => emit(
              GetMomentOtherUserErrorState(null, DioHelper().getTypeOfFailure(r))));
    });

    on<LocalLikeOtherUserMoment>((event, emit) async {
      state.data!.firstWhere((element) {
        if (element.momentId.toString() == event.momentId.toString()) {
          if (element.isLike) {
            element.isLike = false;
            if (element.likeNum.endsWith('k')) {
            } else {
              int newLikeNum = 0;
              newLikeNum = int.parse(element.likeNum) - 1;
              element.likeNum = newLikeNum.toString();
            }
            return true;
          } else {
            element.isLike = true;
            if (element.likeNum.endsWith('k')) {
            } else {
              int newLikeNum = 0;
              newLikeNum = int.parse(element.likeNum) + 1;
              element.likeNum = newLikeNum.toString();
            }
            return true;
          }
        } else {
          return false;
        }
      });
      emit(GetMomentOtherUserSucssesState(data: state.data));
    });

    on<LocalCommentGetOtherUserMoment>((event, emit) async {
      state.data!.firstWhere((element) {
        if (element.momentId.toString() == event.momentId.toString()) {
          if (event.type == "add") {
            if (element.commentNum.endsWith('k')) {
            } else {
              int newcomentnum = 0;
              newcomentnum = int.parse(element.commentNum) + 1;
              element.commentNum = newcomentnum.toString();
            }
            return true;
          } else {
            if (element.commentNum.endsWith('k')) {
            } else {
              int newCommentNum = 0;
              newCommentNum = int.parse(element.commentNum) - 1;
              element.commentNum = newCommentNum.toString();
            }

            return true;
          }
        } else {
          return false;
        }
      });
      emit(GetMomentOtherUserSucssesState(data: state.data));
    });

    on<LocalGiftOtherUserMoment>((event, emit) async {

      state.data!.firstWhere((element) {
        if (element.momentId.toString() == event.momentId.toString()) {
          element.giftsCount = element.giftsCount + event.giftsNum;
          return true;
        } else {
          return false;
        }
      });
      emit(GetMomentOtherUserSucssesState(data: state.data));
    });
  }
}
