import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/moment/domain/moment_usecse/get_moment_use_case.dart';
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

    on<LocalDeleteMomentILikedEvent>((event, emit)async {
      state.data!.removeWhere((element) {

        return element.momentId.toString() == event.momentId.toString();


      });
      emit(GetMomentILikeItSucssesState(data: state.data));

    });

    on<LocalLikeMomentIliked>((event, emit) async {
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
      emit(GetMomentILikeItSucssesState(data: state.data));
    });

    on<LocalCommentIlikedMomentEvent>((event, emit) async {
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
      emit(GetMomentILikeItSucssesState(data: state.data));
    });

    on<LocalGiftILikedMoment>((event,emit)async{
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
      emit(GetMomentILikeItSucssesState(data: state.data));

    });



  }
}
