

import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/moment/domain/moment_usecse/get_moment_use_case.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_get_all_moment_types/get_moment_event.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_get_all_moment_types/get_moment_state.dart';






class GetMomentBloc extends Bloc<BaseGetMomentEvent, GetMomentUserState> {
 final GetMomentUseCase getMomentUseCase ; 
  int page = 1 ; 
  GetMomentBloc({required this.getMomentUseCase}) : super(GetMomentUserInitial(null)) {
    on<GetUserMomentEvent>((event, emit)async {
      page = 1 ; 
    emit(GetMomentUserLoadingState(null));
    final result = await getMomentUseCase.call(GetMomentPrameter(type:"1"  , page: page.toString() , userId: event.userId));
    result.fold((l) => emit(GetMomentUserSucssesState(data: l)), (r) => emit(GetMomentUserErrorState(null, DioHelper().getTypeOfFailure(r))));
    });


        on<LoadMoreUserMomentEvent>((event, emit)async {
          page++ ; 
    final result = await getMomentUseCase.call(GetMomentPrameter(type:"1"  , page: page.toString() , userId: event.userId));
    result.fold((l) {  if (l != []) {
          emit(
              GetMomentUserSucssesState(data: [...state.data!, ...l]));
        }}, (r) => emit(GetMomentUserErrorState(null, DioHelper().getTypeOfFailure(r))));
    });

    on<LocalDeleteMomentEvent>((event, emit) async {
      state.data!.removeWhere((element) {
        return element.momentId.toString() == event.momentId.toString();
      });
      emit(GetMomentUserSucssesState(data: state.data));
    });

    on<LocalLikeMoment>((event, emit) async {
      state.data!.firstWhere((element) {
        if (element.momentId.toString() == event.momentId.toString())
        {
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
        }
        else {
          return false;
        }
      });
      emit(GetMomentUserSucssesState(data: state.data));
    });

    on<LocalCommentMoment>((event, emit) async {
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
      emit(GetMomentUserSucssesState(data: state.data));
    });

    on<LocalGiftMoment>((event,emit)async{
      log('sentgift5');

      state.data!.firstWhere((element) {
        if(element.momentId.toString()==event.momentId.toString()){
          element.giftsCount=element.giftsCount+event.giftsNum;
          return true;
        }else{
          return false;
        }
      });
      emit(GetMomentUserSucssesState(data: state.data));

    });




  }

}
