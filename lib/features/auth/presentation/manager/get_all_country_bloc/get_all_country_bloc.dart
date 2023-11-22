import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/base_use_case/base_use_case.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/auth/domin/use_case/get_all_country_use_case.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/get_all_country_bloc/get_all_country_event.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/get_all_country_bloc/get_all_country_states.dart';
class GetAllCountriesBloc
    extends Bloc<BaseGetAllCountriesEvent, GetAllCountriesStates> {
  final GetAllCountriesUC getAllCountriesUC;

  GetAllCountriesBloc({required this.getAllCountriesUC})
      : super(GetAllCountriesInitial()) {
    on<GetAllCountriesEvent>(
      (event, emit) async {

        emit(GetAllCountriesLoading());
        final result =await getAllCountriesUC.call(const Noparamiter());
        result.fold(
            (l) => emit(GetAllCountriesSuccessState(getAllCountriesModel: l, )),
            (r) => emit(
                GetAllCountriesError(error: DioHelper().getTypeOfFailure(r))));
      },
    );
  }
}
