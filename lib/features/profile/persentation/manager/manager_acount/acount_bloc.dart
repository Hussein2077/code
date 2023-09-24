import 'dart:async';


import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/base_use_case/base_use_case.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/bound_platform_uc.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/delete_account_uc.dart';

import 'account_events.dart';
import 'account_states.dart';


class AcountBloc extends Bloc<AccountEvents,AccountStates>{
 final DeleteAccountUC deleteAccountUC ;
 final BoundPlatformUC boundPlatformUC ;
  AcountBloc( { required this.boundPlatformUC, required this.deleteAccountUC}) : super(InitialAccountState()) {
    on<DeleteAccountEvent>(deleteAccount);
    on<BindFacebookAccountEvent> (bountFacebook);
    on<BindNumberAccountEvent> (boundNubmer);
   on <BindGoolgeAccountEvent>(boundGoogle);
    on <ChangePasswordAccountEvent>(changePassword);
    on <ChangeNumberAccountEvent>(changeNubmer);
  }

  FutureOr<void> deleteAccount(DeleteAccountEvent event, Emitter<AccountStates> emit) async{
    emit(DeleteAccountLoading());
    final result = await deleteAccountUC.call(const Noparamiter()) ;

    result.fold((l) => emit(DeleteAccountSuccessState(successMessage: l)),
            (r) => emit(DeleteAccountErrorState(errorMessage:    DioHelper().getTypeOfFailure(r))));

  }

  FutureOr<void> bountFacebook(BindFacebookAccountEvent event, Emitter<AccountStates> emit) async{
    emit(FacebookAccountLoading());
    final result = await boundPlatformUC.boundFacebook() ;
    result.fold((l) =>emit( FacebookAccountSuccessState(successMessage: l)),
            (r) => emit( FacebookAccountErrorState(errorMessage: DioHelper().getTypeOfFailure(r))));
  }

  FutureOr<void> boundNubmer(BindNumberAccountEvent event, Emitter<AccountStates> emit)  async{
     emit(NumberAccountLoading());
     final result = await boundPlatformUC.boundNumber(
         BoundNumberPramiter(phoneNumber: event.phoneNumber,
             password: event.password, vrCode:event.vrCode , ));

     result.fold((l) => emit(NumberAccountSuccessState(successMessage: l)),
             (r) => emit(NumberAccountErrorState(errorMessage: DioHelper().getTypeOfFailure(r))));

  }

 FutureOr<void> changeNubmer(ChangeNumberAccountEvent event, Emitter<AccountStates> emit)  async{
   emit(ChangeNumberLoading());
   final result = await boundPlatformUC.changePhone(
       BoundNumberPramiter(currentPhone: event.currentPhoneNumber,
         phoneNumber: event.newtPhoneNumber,
         vrCode:event.vrCode , ));
   result.fold((l) => emit(ChangeNumberSuccessState(successMessage: l)),
           (r) => emit(ChangeNumberErrorState(errorMessage: DioHelper().getTypeOfFailure(r))));

 }

 FutureOr<void> changePassword(ChangePasswordAccountEvent event, Emitter<AccountStates> emit)  async{
   emit(ChangePasswordLoading());
   final result = await boundPlatformUC.changePassword(
       BoundNumberPramiter(
         password: event.password,
         phoneNumber: event.phone,
       ));

   result.fold((l) => emit(ChangePasswordSuccessState(successMessage: l)),
           (r) => emit(ChangePasswordErrorState(errorMessage: DioHelper().getTypeOfFailure(r))));

 }

 FutureOr<void> boundGoogle(BindGoolgeAccountEvent event, Emitter<AccountStates> emit)async {


     emit(GoogleAccountLoading());
    final result = await boundPlatformUC.boundGmail() ;
    result.fold((l) =>emit( GoogleAccountSuccessState(successMessage: l)),
            (r) => emit( GoogleAccountErrorState(errorMessage: DioHelper().getTypeOfFailure(r))));
  }
}