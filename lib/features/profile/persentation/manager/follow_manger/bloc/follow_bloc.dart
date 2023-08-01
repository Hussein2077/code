




import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/follow_unfollow_usecase.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/follow_manger/bloc/follow_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/follow_manger/bloc/follow_state.dart';

class FollowBloc extends Bloc<BaseFollowEvent, FollowState> {
 final FollowOrUnFollowUsecase followOrUnFollowUsecase ; 
  FollowBloc({required this.followOrUnFollowUsecase}) : super(FollowInitial()) {
    on<FollowEvent>((event, emit) async{
      emit(FollowLoadingState());
      final result = await followOrUnFollowUsecase.follow(userId: event.userId);

      result.fold((l) => emit(FollowErrorState(error: DioHelper().getTypeOfFailure(l))),
          (r) => emit(FollowSucssesState(massage:r )));
    }
    
    
    );
      on<UnFollowEvent>((event, emit) async{
      emit(FollowLoadingState());
      final result = await followOrUnFollowUsecase.unFollow(userId: event.userId);

      result.fold((l) => emit(UnFollowErrorState(error: DioHelper().getTypeOfFailure(l))),
          (r) => emit(UnFollowSucssesState(massage:r )));
    });
   
  }
}
