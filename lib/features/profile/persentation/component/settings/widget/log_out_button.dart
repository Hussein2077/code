import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/service/service_locator.dart';
import 'package:tik_chat_v2/core/utils/api_healper/methods.dart';
import 'package:tik_chat_v2/core/widgets/mian_button.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/chat_auth_manager/log_out_chat/log_out_chat_bloc.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/chat_auth_manager/log_out_chat/log_out_chat_event.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/log_out_manager/log_out_bloc.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/log_out_manager/log_out_event.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/log_out_manager/log_out_state.dart';
import 'package:tik_chat_v2/main_screen/main_screen.dart';
import 'dialog_pop_up.dart';

class LogOutOrDeleteAccountButton extends StatefulWidget {
  const LogOutOrDeleteAccountButton(
      {Key? key, required this.logOut, required this.text, this.image})
      : super(key: key);
  final bool logOut;
  final String text;
  final Widget? image;
  static bool isFirstTabInAcceptButton = true;

  @override
  State<LogOutOrDeleteAccountButton> createState() =>
      _LogOutOrDeleteAccountButtonState();
}

class _LogOutOrDeleteAccountButtonState
    extends State<LogOutOrDeleteAccountButton> {
  @override
  void initState() {
    LogOutOrDeleteAccountButton.isFirstTabInAcceptButton = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LogOutBloc, LogOutState>(
        listener: (context, state) async {
          if (state is LogOutSucssesState ||
              state is DeleteAccountSucssesState||state is LogOutErrorState) {
            BlocProvider.of<LogOutChatBloc>(context).add(LogOutChatEvent());

            Future.delayed(Duration.zero, () async {
              if(MainScreen.iskeepInRoom.value){
                await Methods.instance.exitFromRoom(MainScreen
                    .roomData!.ownerId
                    .toString(), context);
                MainScreen.iskeepInRoom.value = false ;
              }
              await FirebaseAuth.instance.signOut();
              SharedPreferences preference = getIt();
              preference.remove(StringManager.keepLogin);
              preference.remove(StringManager.userDataKey);
              preference.remove(StringManager.userTokenKey);
              preference.remove(StringManager.deviceToken);
              MyDataModel.getInstance().clearObject();
              Methods().removeUserData();
              // ignore: use_build_context_synchronously
            }).then((value) =>
                Navigator.pushNamedAndRemoveUntil(
                    context, Routes.login, (route) => false));

          } else if (state is LogOutLoadingState ||
              state is DeleteAccountLoadingState) {
          } else if (state is DeleteAccountErrorState) {
            LogOutOrDeleteAccountButton.isFirstTabInAcceptButton = true;
          }
        },
        child: MainButton(
          onTap: () {
            if (widget.logOut) {
              showDialog(
                  context: context,
                  builder: (context) {
                    return DialogPopUp(
                        headerText: StringManager.wanaLogeOut.tr(),
                        accpetText: () async {
                          if (LogOutOrDeleteAccountButton
                              .isFirstTabInAcceptButton) {

                            setState(() {
                              LogOutOrDeleteAccountButton
                                  .isFirstTabInAcceptButton = false;
                            });
                            final googleSignIn = GoogleSignIn();
                            googleSignIn.disconnect();
                            BlocProvider.of<LogOutBloc>(context)
                                .add(LogOutEvent());
                          }
                        });
                    // BlocProvider.of<LogOutBloc>(context).add(LogOutEvent());
                  });
            } else {
              log('${widget.logOut.toString()}innnn');
              showDialog(
                  context: context,
                  builder: (context) {
                    return DialogPopUp(
                        headerText: StringManager.wanaDeletAccout.tr(),
                        accpetText: () async {
                          if (LogOutOrDeleteAccountButton
                              .isFirstTabInAcceptButton) {
                            log('One tab');
                            setState(() {
                              LogOutOrDeleteAccountButton
                                  .isFirstTabInAcceptButton = false;
                            });
                            BlocProvider.of<LogOutBloc>(context)
                                .add(DeleteAccountEvent());
                          }
                        });
                  });
            }
          },
          title: widget.text,
        ));
  }
}
