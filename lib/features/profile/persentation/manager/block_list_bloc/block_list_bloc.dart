import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/get_black_list_usecase.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/block_list_bloc/block_list_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/block_list_bloc/block_list_state.dart';
class GetBlockListBloc extends Bloc<BaseGetBlockListEvent, GetBlockListState> {
  final GetBlackListUseCase getBlackListUseCase;

  GetBlockListBloc({required this.getBlackListUseCase}) : super(GetBlockListInitial()) {
    on<GetBlockListEvent>((event, emit) async{
      emit(GetBlockListLoadingState());
      final result = await getBlackListUseCase.getBlackList();

      result.fold(
              (l) {
            emit(GetBlockListSuccessState(
              blackListModel: l,
            ));},
              (r) =>
              emit(GetBlockListErrorState(errorMassage: DioHelper().getTypeOfFailure(r))));


    });
  }
}
