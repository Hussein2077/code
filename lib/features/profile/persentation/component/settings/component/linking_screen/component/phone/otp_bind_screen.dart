import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

import 'package:tik_chat_v2/features/profile/persentation/manager/get_my_data_manager/get_my_data_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_my_data_manager/get_my_data_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_acount/account_events.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_acount/account_states.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_acount/acount_bloc.dart';

class OtpBindScreen extends StatelessWidget {
  final String phone;

  final String password;

  final String codeCountry;
  const OtpBindScreen(
      {required this.codeCountry,
      required this.password,
      required this.phone,
      super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AcountBloc, AccountStates>(
      listener: (context, state) {
        if (state is NumberAccountSuccessState) {
          sucssesToast(context: context, title: state.successMessage);
          Navigator.pop(context);
          Navigator.pop(context);
          BlocProvider.of<GetMyDataBloc>(context).add(GetMyDataEvent());
        } else if (state is NumberAccountErrorState) {
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
                child: Text(StringManager.verificatiCodeWiilBeSent,
                    style: Theme.of(context).textTheme.titleMedium),
              ),
              const Spacer(
                flex: 1,
              ),
              Text(
                phone,
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
                    log(OtpContiners.code);
                    var userCredential = await getIt<FireBaseDataSource>()
                        .verifyOTP(OtpContiners.code, context);
                    log(userCredential.toString());

                    if (userCredential?.user != null) {
                      String? token = await userCredential!.user!.getIdToken();

                      // ignore: use_build_context_synchronously
                      BlocProvider.of<AcountBloc>(context).add(
                          BindNumberAccountEvent(
                              credential: token ?? "",
                              phoneNumber: phone,
                              password: password,
                              vrCode: OtpContiners.code));
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
