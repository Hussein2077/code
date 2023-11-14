import 'dart:developer';


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/chat/Presentation/Chat_Screen/Manger/get_group_massage/get_group_massage_event.dart';
import 'package:tik_chat_v2/features/chat/Presentation/Chat_Screen/Manger/get_group_massage/get_group_massage_state.dart';
import 'package:tik_chat_v2/features/chat/domine/usecases/get_group_massage.dart';

class GetGroupMassageBloc
    extends Bloc<BaseGetGroupMassageEvent, GetGroupMassageState> {
  GetGroupMassageUseCase getGroupMassageUseCase;
  // List<OwnerDataModel> data = [];
  bool isLoadingMore = false;
  GetGroupMassageBloc({required this.getGroupMassageUseCase})
      : super(GetGroupMassageInitial(null)) {
    on<GetGroupMassageEvent>((event, emit) async {
      emit(GetGroupMassageLoading(null));
      final result = await getGroupMassageUseCase.call(null);
      result.fold(
          (l) {
            // data=l;
             emit(GetGroupMassageSucsses(data: l));},
          (r) => emit(
              (GetGroupMassageError(null, DioHelper().getTypeOfFailure(r)))));
    });

    on<GetMoreGroupMassageEvent>((event, emit) async {
      // log("pagnation");
            isLoadingMore = true;

      // emit(GetGroupMassageLoading(oldData: data));

      var result = await getGroupMassageUseCase.call(event.page);
      result.fold((l) {
        // log(data.length.toString());
        isLoadingMore = false;
        // data = data + l;
        // log(data.length.toString());

if(l!=[]){
          emit(GetGroupMassageSucsses(data: [...state.data!,...l]));

}
      }, (r) {
        isLoadingMore = false;
        emit(GetGroupMassageError(null, DioHelper().getTypeOfFailure(r)));
        // log("pagnation");
      });
    });
    on<GetGroupChatMessageReelTime>((event, emit) async {
      var data = state.data ;
          data!.insert(0, event.message);
          log(event.message.groupMessage.toString());
          log(data[0].groupMessage.toString());
          emit(GetGroupMassageSucsses(data: data));




    });

  }



}
