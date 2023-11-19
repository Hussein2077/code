import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/send_item_usecase.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manger_send/bloc/send_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manger_send/bloc/send_state.dart';


class SendBloc extends Bloc<SendEvent, SendState> {
  SendItemUsecase sendItemUsecase;


  SendBloc({required this.sendItemUsecase}) : super(SendInitial()) {
    on<sendItemEvent>((event, emit) async {
      emit(SendLoadingState());
      final result = await sendItemUsecase.sendItem(event.packId, event.touId);

      result.fold((l) => emit(SendSucssesState(massage: l)),
          (r) => emit(SendErrorState(massage: DioHelper().getTypeOfFailure(r))));
    });


  }
}
