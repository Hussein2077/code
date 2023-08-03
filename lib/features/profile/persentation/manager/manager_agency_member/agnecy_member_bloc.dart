import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/agency_member_uc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_agency_member/agnecy_member_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_agency_member/agnecy_member_state.dart';

class AgnecyMemberBloc extends Bloc<BaseAgnecyMemberEvent, AgnecyMemberState> {
  final AgencyMembermUsecase agencyMembermUsecase;
  AgnecyMemberBloc({required this.agencyMembermUsecase})
      : super(AgnecyMemberInitial(null)) {
    on<AgnecyMemberEvent>((event, emit) async {
      emit(AgnecyMemberLoadingState(null));
      final result = await agencyMembermUsecase.agencyMember(event.page);
      result.fold(
          (l) => emit(AgnecyMemberSucsessState(data: l)),
          (r) => emit(
              AgnecyMemberErrorState(DioHelper().getTypeOfFailure(r), null)));
    });

    on<LoadMoreAgnecyMemberEvent>((event, emit) async {
      //  isLoadingMore = true ;

      var result = await agencyMembermUsecase.agencyMember(event.page);
      result.fold((l) {
        // isLoadingMore = false ;
        if (l != []) {
          emit(AgnecyMemberSucsessState(data: [...state.data!, ...l]));
        }
      }, (r) {
        // isLoadingMore = false;
        emit(AgnecyMemberErrorState(DioHelper().getTypeOfFailure(r), null));
      });
    });
  }
}
