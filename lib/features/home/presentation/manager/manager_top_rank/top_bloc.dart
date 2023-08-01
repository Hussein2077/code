import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/features/home/data/model/user_rank_model.dart';
import 'package:tik_chat_v2/features/home/domin/use_case/get_top_usecase.dart';
import 'package:tik_chat_v2/features/home/presentation/manager/manager_top_rank/top_states.dart';

import 'top_events.dart';




class TobBloc extends Bloc<TopEvents,TopStates>
{
  final GetTopUseCase getTopUseCase;
  int page = 1 ;
  bool isLoadMore= false ;

  TobBloc({required this.getTopUseCase}): super(const TopStates()){

    on<GetDiamondsDayEvent>(getDiamondsDay);
    on<GetDiamondsWeeklyEvent>(getDiamondsWeekly);
    on<GetDiamondsMonthlyEvent>(getDiamondsMonthly);
    on<GetCoinsDayEvent>(getCoinsDay);
    on<GetCoinsWeeklyEvent>(getCoinsWeekly);
    on<GetCoinsMonthlyEvent>(getCoinsMonthly);
    on<LoadMoreEvent>(loadMore);

  }

  FutureOr<void> getDiamondsDay(GetDiamondsDayEvent event, Emitter<TopStates> emit)async {

    final result = await getTopUseCase.call(TopPramiter(
        sendOrReceiver: event.sendOrReceiver,
       isHome: event.isHome,
      date: event.date
    ));
    result.fold((l) => emit(state.copyWith(usersRankDD: l,dDState: RequestState.loaded)),
            (r) => emit(state.copyWith(dDError: DioHelper().getTypeOfFailure(r),  dDState: RequestState.error)));

  }


  FutureOr<void> getDiamondsWeekly(GetDiamondsWeeklyEvent event, Emitter<TopStates> emit) async {
    final result = await getTopUseCase.call(TopPramiter(
        sendOrReceiver: event.sendOrReceiver,
        isHome: event.isHome,
        date: event.date
    ));

    result.fold((l) {
      emit(state.copyWith(usersRankDW: l,dWState: RequestState.loaded));
    },
            (r) => emit(state.copyWith(dWError: DioHelper().getTypeOfFailure(r),  dWState: RequestState.error)));


  }



  FutureOr<void> getDiamondsMonthly(GetDiamondsMonthlyEvent event, Emitter<TopStates> emit) async {
    final result = await getTopUseCase.call(TopPramiter(
        sendOrReceiver: event.sendOrReceiver,
        isHome: event.isHome,
        date: event.date
    ));

    result.fold((l) => emit(state.copyWith(usersRankDM: l,dMState: RequestState.loaded)),
            (r) => emit(state.copyWith(dMError: DioHelper().getTypeOfFailure(r),  dMState: RequestState.error)));
  }




  FutureOr<void> getCoinsDay(GetCoinsDayEvent event, Emitter<TopStates> emit)async {
    final result = await getTopUseCase.call(TopPramiter(
        sendOrReceiver: event.sendOrReceiver,
        isHome: event.isHome,
        date: event.date
    ));

    result.fold((l) => emit(state.copyWith(usersRankCD: l,cDState: RequestState.loaded)),
            (r) => emit(state.copyWith(cDError: DioHelper().getTypeOfFailure(r),  cDState: RequestState.error)));

  }


  FutureOr<void> getCoinsWeekly(GetCoinsWeeklyEvent event, Emitter<TopStates> emit)async{
    final result = await getTopUseCase.call(TopPramiter(
        sendOrReceiver: event.sendOrReceiver,
        isHome: event.isHome,
        date: event.date
    ));

    result.fold((l) => emit(state.copyWith(usersRankCW: l,cWState: RequestState.loaded)),
            (r) => emit(state.copyWith(cWError: DioHelper().getTypeOfFailure(r),  cWState: RequestState.error)));
  }

  FutureOr<void> getCoinsMonthly(GetCoinsMonthlyEvent event, Emitter<TopStates> emit) async {
    final result = await getTopUseCase.call(TopPramiter(
        sendOrReceiver: event.sendOrReceiver,
        isHome: event.isHome,
        date: event.date
    ));

    result.fold((l) => emit(state.copyWith(usersRankCM: l,cMState: RequestState.loaded)),
            (r) => emit(state.copyWith(cMError: DioHelper().getTypeOfFailure(r),  cMState: RequestState.error)));
  }

  FutureOr<void> loadMore(LoadMoreEvent event, Emitter<TopStates> emit)async {
    isLoadMore = true ;
    page++ ;
  //  switch(event.type){
  //    case 'SendDaily' :
        final result = await getTopUseCase.call(TopPramiter(
            sendOrReceiver: '2',
            isHome: event.isHome,
            date: event.date,
           page:  page.toString()
        ));
        result.fold((l) {
          if(l.userOtherModel.isEmpty){
            emit(state.copyWith(usersRankDD: state.usersRankDD,dDState: RequestState.loaded,dDError: "roomsIsEmpty" ));
            isLoadMore = false ;
          } else{
            isLoadMore = false ;
            RankingModel rankingModel = l ;
            rankingModel.setMoreUsers = state.usersRankDD!.userOtherModel;
            emit(state.copyWith(usersRankDD:rankingModel,dDState: RequestState.loaded,));
          }

        },(r)=>  (r) => emit(state.copyWith(dDError: DioHelper().getTypeOfFailure(r),  dDState: RequestState.error)) );


   // }

  }
}