import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/get_all_shipping_agents_uc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_all_shipping_agents_manager/get_all_shipping_agents_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_all_shipping_agents_manager/get_all_shipping_agents_state.dart';


class AllShippingAgentsBloc extends Bloc<AllShippingAgentsEvent, AllShippingAgentsState> {

  int page = 1 ;
  final GetAllShippingAgentsUseCase getAllShippingAgentsUseCase;

  bool isLoadingMore = false;
  AllShippingAgentsBloc({required this.getAllShippingAgentsUseCase}) : super(GetAllShippingAgentsInitialState(null)) {

    on<GetAllShippingAgentsEvents>((event, emit) async {
      page = 1 ;
      emit(GetAllShippingAgentsLoadinglState(null));
      final result = await getAllShippingAgentsUseCase.getAllShippingAgents(GetAllShippingAgentsPram(page.toString()));

      result.fold((l) {
        emit(GetAllShippingAgentsSucssesState(
          data: l,

        ));
      }, (r) {
        emit(GetAllShippingAgentsErrorState( null , DioHelper().getTypeOfFailure(r)));
      });
    });

    on<GetMoreShippingAgentsEvents>((event, emit) async {
      page++;
      isLoadingMore = true;
      emit(GetAllShippingAgentsSucssesState(data: [
        ...state.data!,
      ]));

      var result = await getAllShippingAgentsUseCase.getAllShippingAgents(GetAllShippingAgentsPram(page.toString()));
      result.fold((l) {
        isLoadingMore = false;
        if (l != []) {
          emit(
              GetAllShippingAgentsSucssesState(data: [...state.data!, ...l]));
        }
        ;
      }, (r) {
        isLoadingMore = false;
        emit(GetAllShippingAgentsErrorState(
            null, DioHelper().getTypeOfFailure(r)));

      });
    });
  }
}
