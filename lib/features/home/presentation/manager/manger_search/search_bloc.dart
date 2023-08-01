

import 'dart:async';
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/search_use_case.dart';

import 'search_events.dart';
import 'search_states.dart';




class SearchBloc extends Bloc<SearchEvents, SearchStates> {
  final SearchUseCase searchUseCase;
  // final GetHestorySearchUsecase getHestorySearchUsecase;
  // final EmptyHistoryUsecase emptyHistoryUsecase;
  SearchBloc(
      {required this.searchUseCase,
      })
      : super(InitialSearchStates()) {
    on<SearchEvent>(search);
        on<SearchInitEvent>(init);

    // on<HestoryEvent>(histroy);
    // on<EmptyEvent>(emptyHistory);
  }

  FutureOr<void> search(SearchEvent event, Emitter<SearchStates> emit) async {
    emit(LoadingSearchStates());
    final result = await searchUseCase.call(event.keyWord);
    result.fold(
        (l) => emit(SuccessSearchStates(data: l)),
        (r) => emit(
            ErrorSearchStates(errorMessage: DioHelper().getTypeOfFailure(r))));
  }

  // FutureOr<void> histroy(HestoryEvent event, Emitter<SearchStates> emit) async {
  //   emit(LoadingHistoryStates());
  //   final result = await getHestorySearchUsecase.call(const Noparamiter());
  //   result.fold(
  //       (l) => emit(SuccessHistoryStates(listSearches: l)),
  //       (r) => emit(
  //           ErrorHistoryStates(errorMessage: DioHelper().getTypeOfFailure(r))));
  // }

  // FutureOr<void> emptyHistory(
  //     EmptyEvent event, Emitter<SearchStates> emit) async {
  //   emit(LoadingEmptyStates());
  //   final result = await emptyHistoryUsecase.call(const Noparamiter());

  //   result.fold(
  //       (l) => emit(SuccessEmptyStates(successMessage: l)),
  //       (r) => emit(
  //           ErrorEmptyStates(errorMessage: DioHelper().getTypeOfFailure(r))));
  // }

  FutureOr<void> init(SearchInitEvent event, Emitter<SearchStates> emit) {
    log("heeeeeeeeeeeeeeeerrr");
        emit(InitialSearchStates());

  }
}
