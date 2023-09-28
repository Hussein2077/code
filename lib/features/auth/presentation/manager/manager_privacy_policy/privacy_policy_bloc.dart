





import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/auth/domin/use_case/privacy_policy_use_case.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/manager_privacy_policy/privacy_policy_event.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/manager_privacy_policy/privacy_policy_state.dart';

class PrivacyPolicyBloc extends Bloc<BaseprivacyPolicyEvent, PrivacyPolicyState> {
  PrivacyPolicyUseCase privacyPolicyUseCase ;
  PrivacyPolicyBloc({required this.privacyPolicyUseCase ,}) : super(PrivacyPolicyInitial()) {
    on<privacyPolicyEvent>((event, emit) async{
      emit (PrivacyPolicyLoadingState());
      final result = await privacyPolicyUseCase.call();

      result.fold((l) => emit(PrivacyPolicySucssesState(message: l)), (r) => emit(PrivacyPolicyErrorState(error: DioHelper().getTypeOfFailure(r))));
    });
  }
}


