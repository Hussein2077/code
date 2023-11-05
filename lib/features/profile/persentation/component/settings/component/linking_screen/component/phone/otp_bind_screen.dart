import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/service/service_locator.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/header_with_only_title.dart';
import 'package:tik_chat_v2/core/widgets/mian_button.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/features/auth/data/data_soruce/fire_base_datasource.dart';
import 'package:tik_chat_v2/features/auth/presentation/component/otp/widget/otp_continers.dart';
import 'package:tik_chat_v2/features/auth/presentation/component/otp/widget/resend_code_widget.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/settings/component/linking_screen/component/phone/change_number_screen.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_acount/account_events.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_acount/account_states.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_acount/acount_bloc.dart';

class OtpBindScreen extends StatefulWidget {
  final String? phone;
  final String? password;
  final String? codePhone;
  final String? type;

  const OtpBindScreen(
      {
        this.password,
        this.codePhone ,
        this.type ,

        this.phone,
        super.key,
      });

  @override
  State<OtpBindScreen> createState() => _OtpBindScreenState();
}

class _OtpBindScreenState extends State<OtpBindScreen> {
  String code = "";

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AcountBloc, AccountStates>(
        listener: (BuildContext context, AccountStates state) async {
      log('lllllllllll1');

      if (state is ChangeNumberSuccessState) {
        sucssesToast(context: context, title: state.successMessage);
        // // ignore: use_build_context_synchronously
        // Navigator.pop(context);
        // // ignore: use_build_context_synchronously
        // Navigator.pop(context);
      } else if (state is ChangeNumberErrorState) {
        log(state.errorMessage);
        errorToast(context: context, title: state.errorMessage);
      } else if (state is ChangeNumberLoading) {
        //loadingToast(context: context, );
      }

      else if (state is ChangePasswordSuccessState) {
        sucssesToast(context: context, title:
        state.successMessage);
        // // ignore: use_build_context_synchronously
        // Navigator.pop(context);
      }
      else if (state is ChangePasswordLoading) {
         loadingToast(context: context, );
      }
      else if (state is ChangePasswordErrorState) {
        errorToast(context: context, title: state.errorMessage);
      }

      else if (state is NumberAccountSuccessState) {
            log('lllllllllll3');
        sucssesToast(context: context, title: state.successMessage);
        // // ignore: use_build_context_synchronously
        // Navigator.pop(context);
      } else if (state is NumberAccountLoading) {
        log('lllllllllll2');

        //loadingToast(context: context, );
      } else if (state is NumberAccountErrorState) {
        errorToast(context: context, title: state.errorMessage);
      }
    }, builder: (BuildContext context, AccountStates state) {
      log('lllllllllll4');
      return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Column(
          children: [
            const Spacer(
              flex: 4,
            ),
            const HeaderWithOnlyTitle(
              title: StringManager.enterTheVerificatiOnCode,
            ),
            const Spacer(
              flex: 7,
            ),
            Image.asset(
              AssetsPath.iconApp,
              scale: 2.5,
            ),
            const Spacer(
              flex: 1,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width - 50,
              child: Text(StringManager.verificatiCodeWiilBeSent,
                  style: Theme.of(context).textTheme.titleMedium),
            ),
            const Spacer(
              flex: 1,
            ),
            Text(
              widget.phone ?? "",
              style: TextStyle(
                  fontFamily: "Inter",
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                  fontSize: ConfigSize.defaultSize! + 6),
            ),
            const Spacer(
              flex: 2,
            ),
            const OtpContiners(),
            const ResendCodeWidget(),
            const Spacer(
              flex: 7,
            ),
            MainButton(
                onTap: () async {
                  log('llllllll${widget.type}');
                  var userCredential = await getIt<FireBaseDataSource>()
                      .verifyOTP(OtpContiners.code, context);
                  if (userCredential?.user != null) {
                    String? token = await userCredential!.user!.getIdToken();
                    if (widget.type == 'bindNumber') {
                      // ignore: use_build_context_synchronously
                      BlocProvider.of<AcountBloc>(context)
                          .add(BindNumberAccountEvent(
                              credential: token ?? '',
                              phoneNumber: widget.phone.toString(),
                              //   phoneNumber: ChangeNumberScreenState.number.phoneNumber.toString(),
                              password: widget.password ?? '',
                              vrCode: OtpContiners.code));
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                      // ignore: use_build_context_synchronously
                      Navigator.pop(context);
                    }
                    else if (widget.type == 'changeNumber') {


                      // ignore: use_build_context_synchronously
                      BlocProvider.of<AcountBloc>(context)
                          .add(ChangeNumberAccountEvent(
                        currentPhoneNumber:
                            MyDataModel.getInstance().phone.toString(),
                        vrCode: code,
                        newtPhoneNumber: ChangeNumberScreenState
                            .number.phoneNumber
                            .toString(),
                        credential: token ?? '',
                      ));
                    }
                    else if (widget.type == 'changePassword') {
                      log('kkkkkkkk${MyDataModel.getInstance().phone.toString()}');
                      log('kkkkkkkk${code}');
                      log('kkkkkkkk changePassword');
                      log('kkkkkkkk${widget.password}');
                      String? token = await userCredential.user!.getIdToken();
                      // ignore: use_build_context_synchronously
                      BlocProvider.of<AcountBloc>(context)
                          .add(ChangePasswordAccountEvent(
                        phone: MyDataModel.getInstance().phone.toString(),
                        password: widget.password ?? '',
                        credential: token ?? "",
                        vrCode: code,
                      ));
                    }
                  } else {
                    // ignore: use_build_context_synchronously
                    errorToast(context: context, title: StringManager.theOtp);
                  }
                },
                title: StringManager.done),
            const Spacer(
              flex: 20,
            ),
          ],
        ),
      );
    });
  }
}
