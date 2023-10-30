import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/moment/domain/moment_usecse/get_moment_use_case.dart';
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


    on<LocalLikeFollowingMoment>((event, emit) async {
      state.data!.firstWhere((element) {
        if (element.momentId.toString() == event.momentId.toString()) {
          if (element.isLike) {
            element.isLike = false;
            if (element.likeNum.endsWith('k')) {}
            else {
              int newLikeNum = 0;
              newLikeNum = int.parse(element.likeNum) - 1;
              element.likeNum = newLikeNum.toString();
            }
            return true;
          } else {
            element.isLike = true;
            if (element.likeNum.endsWith('k')) {


            }
            else {
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
      emit(GetFollowingUserMomentSucssesState(data: state.data));
    });

    on<LocalCommentFollowingMomentEvent>((event, emit) async {
      state.data!.firstWhere((element) {
        if (element.momentId.toString() == event.momentId.toString()) {
          if (event.type=="add") {

            if (element.commentNum.endsWith('k')) {


            }
            else {
              int newcomentnum = 0;
              newcomentnum = int.parse(element.commentNum) + 1;
              element.commentNum = newcomentnum.toString();
            }
            return true;
          } else {
            if (element.commentNum.endsWith('k')) {

            }
            else {
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
      emit(GetFollowingUserMomentSucssesState(data: state.data));
    });

    on<LocalFollowingGiftMoment>((event,emit)async{
      state.data!.firstWhere((element) {
        if(element.momentId.toString()==event.momentId.toString()) {
          if (element.giftsCount.endsWith('k')) {


          }
          else {
            int newGiftNum = 0;
            newGiftNum = int.parse(element.giftsCount) + event.giftsNum;
            element.giftsCount = newGiftNum.toString();
          }
          return true;
        }else{
          return false;
        }
      });
      emit(GetFollowingUserMomentSucssesState(data: state.data));

    });


  }
}
