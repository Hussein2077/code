import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/auth/domin/use_case/add_info_use_case.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/add_info_bloc/add_info_event.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/add_info_bloc/add_info_state.dart';

class AddInfoBloc extends Bloc<BaseAddInfoEvent, AddInfoState> {
  final AddInFormationUC addInFormationUC;
  AddInfoBloc({required this.addInFormationUC}) : super(AddInfoInitial()) {
    on<AddInfoEvent>((event, emit) async {
      emit(const AddInfoLoadingState());
      final result = await addInFormationUC.call(InformationPramiter(
        image: event.image,
          bio: event.bio,
          gender: event.gender,
          date: event.date,
          email: event.email,
          name: event.name,
          countryID: event.countryID));
      result.fold(
          (l) => emit(AddInfoSuccesMessageState(myDataModel: l)),
          (r) => emit(AddInfoErrorMessageState(
              errorMessage: DioHelper().getTypeOfFailure(r))));
    });
  }
}
