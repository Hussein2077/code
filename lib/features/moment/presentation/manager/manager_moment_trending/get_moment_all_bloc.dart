
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/moment/domain/moment_usecse/get_moment_use_case.dart';

import 'get_moment_all_event.dart';
import 'get_moment_all_state.dart';

class GetMomentallBloc
    extends Bloc<BaseGetMomentAllEvent, GetMomentAllState> {
  final GetMomentUseCase getMomenttUseCase;
  int page = 1;
  GetMomentallBloc({required this.getMomenttUseCase})
      : super(GetMomentAllInitial(null)) {
    on<GetMomentAllEvent>((event, emit) async {
      page = 1;
      emit(GetMomentAllLoadingState(null));
      final result = await getMomenttUseCase
          .call(GetMomentPrameter(page: page.toString(), userId: MyDataModel.getInstance().id.toString(),type: "4"));
      result.fold(
          (l) => emit(GetMomentAllSucssesState(data: l)),
          (r) => emit(GetMomentAllErrorState(
              null, DioHelper().getTypeOfFailure(r))));
    });

    on<LoadMoreMomentAllEvent>((event, emit) async {
      page++;
      final result = await getMomenttUseCase.call(GetMomentPrameter(

        page: page.toString(),
           userId: MyDataModel.getInstance().id.toString(),
        type: "4",
      ));
      result.fold((l) {
        if (l != []) {
          emit(GetMomentAllSucssesState(data: [...state.data!, ...l]));
        }
      },
          (r) => emit(GetMomentAllErrorState(
              null, DioHelper().getTypeOfFailure(r))));
    });

    on<LocalDeleteMomentAllEvent>((event, emit)async {
      state.data!.removeWhere((element) {
  
        return element.momentId.toString() == event.momentId.toString();


      });
emit(GetMomentAllSucssesState(data: state.data));

    });

    on<LocalLikeMomentAll>((event, emit) async {
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
      emit(GetMomentAllSucssesState(data: state.data));
    });

       on<LocalCommentMomentAllEvent>((event, emit) async {
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
            //element.commentNum =  element.commentNum+1;


            return true;
          }
          else {
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
      emit(GetMomentAllSucssesState(data: state.data));
    });

    on<LocalGiftMomentAllEvent>((event,emit)async{
      state.data!.firstWhere((element) {
        if(element.momentId.toString()==event.momentId.toString()){
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
      emit(GetMomentAllSucssesState(data: state.data));

    });


  }
}


