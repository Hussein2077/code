import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/service/service_locator.dart';
import 'package:tik_chat_v2/core/utils/api_healper/methods.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/header_with_only_title.dart';
import 'package:tik_chat_v2/core/widgets/mian_button.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/features/auth/data/data_soruce/fire_base_datasource.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/register_with_phone_manager/register_with_phone_bloc.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/register_with_phone_manager/register_with_phone_event.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/register_with_phone_manager/register_with_phone_state.dart';

import 'widget/otp_continers.dart';
import 'widget/resend_code_widget.dart';

class OtpScreen extends StatelessWidget {
  final String? phone;

  final String? password;

  final String? codeCountry;
  const OtpScreen(
      { this.codeCountry,
       this.password,
       this.phone,
      super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterWithPhoneBloc, RegisterWithPhoneState>(
      listener: (context, state)async {
       if (state is RegisterPhoneSuccesMessageState) {
        Methods().clearAuthData();
        await    Methods().addFireBaseNotifcationId();

          Navigator.pushNamedAndRemoveUntil(
              context, Routes.addInfo, (route) => false);
        } else if (state is RegisterPhoneErrorMessageState) {
       errorToast(context: context, title: state.errorMessage);
        }
      },
      builder: (context, state) {
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
                child: Text(StringManager.verificatiCodeWiilBeSent.tr(),
                    style: Theme.of(context).textTheme.titleMedium),
              ),
              const Spacer(
                flex: 1,
              ),
              Text(
                phone??'',
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
                    var userCredential = await getIt<FireBaseDataSource>()
                        .verifyOTP(OtpContiners.code, context);
                        log(userCredential.toString());

                    if (userCredential?.user != null) {
                      String? token = await userCredential!.user!.getIdToken();
                      // ignore: use_build_context_synchronously
                      BlocProvider.of<RegisterWithPhoneBloc>(context).add(
                          RegisterWithPhoneEvent(
                              code: OtpContiners.code,
                              password: password??'',
                              phone: phone??'',
                              credential: token ?? ""));
                    }
                    
                  },
                  title: StringManager.done),
              const Spacer(
                flex: 20,
              ),
            ],
          ),
        );
      },
    );
  }
}
