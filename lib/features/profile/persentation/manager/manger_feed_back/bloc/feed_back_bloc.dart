

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/feed_back_usecase.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manger_feed_back/bloc/feed_back_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manger_feed_back/bloc/feed_back_state.dart';

class FeedBackBloc extends Bloc<BasseFeedBackEvent, FeedBackState> {
  FeedBackUseCase feedBackUseCase ; 
  FeedBackBloc({required this.feedBackUseCase}) : super(FeedBackInitial()) {
    on<FeedBackEvent>((event, emit) async{
      emit (FeedBackLoadingState());
     final result = await  feedBackUseCase.call(FeedBackPramiter(
         content:event.content , 
       phoneNumber : event.phoneNumber,
       image: event.image,
       userId: event.userId,
       description: event.description

     ));
     result.fold(
             (l) =>  emit( FeedBackSucssesState(massage: l,
                 )),
             (r) => emit( FeedBackErrorState(error:  DioHelper().getTypeOfFailure(r))));
    });
  }
}
