import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/add_block_usecase.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/remove_block_usecase.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/add_or_delete_block/add_or_delete_block_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/add_or_delete_block/add_or_delete_block_state.dart';


class AddOrDeleteBLockListBloc
    extends Bloc<BaseAddOrDeleteBlockListEvent, AddOrDeleteBlockListState> {
  final AddBlockUseCase addBlockUseCase;
  final RemoveBlockUseCase removeBlockUseCase;

  AddOrDeleteBLockListBloc({
    required this.addBlockUseCase,
    required this.removeBlockUseCase,
  }) : super(AddOrDeleteBlockListInitial()) {
    on<AddBlockListEvent>((event, emit) async {
      emit(AddBlockListLoadingState());
      final result = await addBlockUseCase.addBlock(event.userID);

      result.fold((l) {
        emit(AddBlockListSuccessState(message: l));
      },
          (r) => emit(AddBlockListErrorState(
              errorMassage: DioHelper().getTypeOfFailure(r))));
    });
    on<DeleteBlockListEvent>((event, emit) async {
      emit(DeleteBlockListLoadingState());
      final result = await removeBlockUseCase.removeBlock(event.userID);

      result.fold((l) {
        emit(DeleteBlockListSuccessState(message: l));
      },
          (r) => emit(DeleteBlockListErrorState(
              errorMassage: DioHelper().getTypeOfFailure(r))));
    });
  }
}
