

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/my_store_uc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_my_store/my_store_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_my_store/my_store_state.dart';

class MyStoreBloc extends Bloc<BaseMyStoreEvent, MyStoreState> {
   final GetMyStoreUseCase  getMyStoreUseCase ;
  MyStoreBloc({required this.getMyStoreUseCase , }) : super(MyStoreInitial()) {
    on<GetMyStoreEvent>((event, emit)async {
     emit (MyStoreLoadingState());
     final result = await getMyStoreUseCase.getMyStore();
     result.fold((l) => emit(MyStoreSucssesState(myStore: l)), (r) => emit(MyStoreErrorState(error: DioHelper().getTypeOfFailure(r))));

    });
  }
}
