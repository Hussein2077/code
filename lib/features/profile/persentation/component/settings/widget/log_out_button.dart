import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/service/service_locator.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/log_out_manager/log_out_bloc.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/log_out_manager/log_out_event.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/log_out_manager/log_out_state.dart';
import '../../../../../../core/utils/config_size.dart';
import 'dialog_pop_up.dart';

class LogOutOrDeleteAccountButton extends StatelessWidget {
  const LogOutOrDeleteAccountButton({Key? key, required this.logOut, this.text, this.image})
      : super(key: key);
  final bool logOut;
  final String? text;
  final Widget? image;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LogOutBloc, LogOutState>(
      listener: (context, state) async {
        if (state is LogOutSucssesState || state is DeleteAccountSucssesState) {
          print('success hussein');
          await FirebaseAuth.instance.signOut();
          SharedPreferences preference = getIt();
          preference.remove(StringManager.keepLogin);
          preference.remove(StringManager.userDataKey);
          preference.remove(StringManager.userTokenKey);
          preference.remove(StringManager.deviceToken);

          // ignore: use_build_context_synchronously
          Navigator.pushNamedAndRemoveUntil(
              context, Routes.login, (route) => false);
        } else if (state is LogOutErrorState) {
          errorToast(context: context, title: state.error);
          SharedPreferences preference = getIt();
          preference.remove(StringManager.keepLogin);
          preference.remove(StringManager.userDataKey);
          preference.remove(StringManager.userTokenKey);
          preference.remove(StringManager.deviceToken);
        }   else if (state is LogOutLoadingState || state is DeleteAccountLoadingState){
        // ShowMToast().loadingToast(context, message: StringManager.errorInPayment, alignment: Alignment.bottomCenter);
        }
        else if (state is DeleteAccountErrorState){
          // showToastWidget(ToastWidget().errorToast(state.error),
          //     context: context, position: StyledToastPosition.top);
        }
      },
      child: InkWell(
        onTap: () {
          log('${logOut.toString()}huuuuuuuuuuu');
          if (logOut) {

            showDialog(
                context: context,
                builder: (context) {
                  return DialogPopUp(
                      headerText: StringManager.wanaLogeOut.tr(),
                      accpetText: () async {
                        BlocProvider.of<LogOutBloc>(context).add(LogOutEvent());
                      });
                  // BlocProvider.of<LogOutBloc>(context).add(LogOutEvent());
                });
          } else {
            log('${logOut.toString()}innnn');
            showDialog(
                context: context,
                builder: (context) {
                  return DialogPopUp(
                      headerText: StringManager.wanaDeletAccout.tr(),
                      accpetText: () async {
                        BlocProvider.of<LogOutBloc>(context).add(DeleteAccountEvent());
                      });
                });
          }
        },
        child: Container(
          width: MediaQuery.of(context).size.width - 50,
          height: ConfigSize.defaultSize! * 5.5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(ConfigSize.defaultSize! * 5),
            gradient: const LinearGradient(
              end: Alignment.topRight,
              begin: Alignment.bottomLeft,
              colors: [
                Color(0xFFFF382C),
                Color(0xFFFFBB0D),
              ],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ConfigSize.defaultSize! * 3.0,
            ),
            child: Center(
              child: Text(
                text ?? StringManager.logOut.tr(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: ConfigSize.defaultSize! * 1.8,
                    fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
