

import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/model/owner_data_model.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/get_family_member_usecase.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/family_manager/manager_family_member/bloc/family_member_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/family_manager/manager_family_member/bloc/family_member_state.dart';




class FamilyMemberBloc extends Bloc<FamilyMemberEvent, FamilyMemberState> {
  GetFamilyMemberUseCase getfamilymember;
    bool isLoadingMore = false ;
    List<UserDataModel>? tempMembers ;

  FamilyMemberBloc({required this.getfamilymember})
      : super(FamilyMemberInitial(null)) {
    on<GetFamilyMemberEvent>((event, emit) async {
      emit(GetFamilyMemberLoadingState(null));
      final result = await getfamilymember.getFamilyMember(event.familyId , null);

      result.fold(
          (l) { 
                         log(l.members.length.toString()); 

            tempMembers = l.members;
            emit(GetFamilyMemberSucssesState(data: l));},
          (r) => emit(
              GetFamilyMemberErrorState(null, DioHelper().getTypeOfFailure(r))));
    });

        on<GetMoreFamilyMemberEvent>((event, emit) async {
          isLoadingMore = true;
           emit(GetFamilyMemberSucssesState(data: state.data));
      final result = await getfamilymember.getFamilyMember(event.familyId ,event.page);

      result.fold(
          (l) { 
            isLoadingMore = false;
           tempMembers=tempMembers!+l.members;
             l.members = tempMembers!;
             log(l.members.length.toString()); 
            emit(GetFamilyMemberSucssesState(data: l));},
          (r) { 
                isLoadingMore = false;
            emit(
              GetFamilyMemberErrorState(null, DioHelper().getTypeOfFailure(r)) );});
    });
  }
}
