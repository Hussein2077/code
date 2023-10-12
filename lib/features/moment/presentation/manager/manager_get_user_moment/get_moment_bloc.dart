

import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/moment/domain/moment_usecse/get_moment_use_case.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_get_user_moment/get_moment_event.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_get_user_moment/get_moment_state.dart';





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
            element.likeNum = element.likeNum - 1;

            return true;
          } else {
            element.isLike = true;
            element.likeNum = element.likeNum + 1;

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
            element.commentNum =  element.commentNum+1;
            return true;
          } else {
            element.commentNum = element.commentNum - 1;
            return true;
          }
        } else {
          return false;
        }
      });
      emit(GetMomentUserSucssesState(data: state.data));
    });

    on<LocalGiftMoment>((event,emit)async{
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
