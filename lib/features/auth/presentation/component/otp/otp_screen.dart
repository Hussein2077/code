import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/core/utils/api_healper/methods.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/header_with_only_title.dart';
import 'package:tik_chat_v2/core/widgets/mian_button.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/forget_password/forget_pass_bloc.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/forget_password/forget_pass_event.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/forget_password/forget_pass_state.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/register_with_phone_manager/register_with_phone_bloc.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/register_with_phone_manager/register_with_phone_event.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/register_with_phone_manager/register_with_phone_state.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_acount/account_events.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_acount/account_states.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_acount/acount_bloc.dart';
import 'widget/otp_continers.dart';
import 'widget/resend_code_widget.dart';

class OtpScreen extends StatelessWidget {
  final String? phone;
  final String? password;
  final OtpFrom otpFrom;
  final String? oldCode;

  const OtpScreen({this.phone, super.key, this.password, required this.otpFrom, this.oldCode});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AcountBloc, AccountStates>(
      listener: (context, state) {
        if (state is ChangePasswordSuccessState) {
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
        } else if (state is ChangePasswordErrorState) {
          errorToast(context: context, title: state.errorMessage);
        } else if(state is ChangeNumberSuccessState){
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
        } else if (state is ChangeNumberErrorState) {
          errorToast(context: context, title: state.errorMessage);
        }
      },
      builder: (context, state){
        return BlocConsumer<RegisterWithPhoneBloc, RegisterWithPhoneState>(
          listener: (context, state) {
            if (state is RegisterPhoneSuccesMessageState) {
              Methods.instance.clearAuthData();
              Navigator.pushNamedAndRemoveUntil(context, Routes.addInfo, (route) => false);
            } else if (state is RegisterPhoneErrorMessageState) {
              errorToast(context: context, title: state.errorMessage);
            }
          },
          builder: (context, state) {
            return BlocConsumer<ForgetPasswordBloc, ForgetPasswordState>(
              listener: (context, state) {
                if (state is ForgetPasswordCodeVerificationSuccessState) {
                  if (otpFrom == OtpFrom.forgetPassword) {
                    Navigator.pushNamed(context, Routes.resetPassword,
                        arguments: ResetPasswordParm(phone: phone!, code:  OtpContiners.code,));
                  }else if(otpFrom == OtpFrom.changePhoneOld){
                    Navigator.pushNamed(context, Routes.changeNumberNewScreen, arguments: OtpContiners.code);
                  }
                }
                if (state is ForgetPasswordCodeVerificationErrorState) {
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
                      HeaderWithOnlyTitle(
                        title: StringManager.enterTheVerificatiOnCode.tr(),
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
                            fontFamily: "GothamMedium",
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: ConfigSize.defaultSize! + 6),
                      ),
                      const Spacer(
                        flex: 2,
                      ),
                      const OtpContiners(),
                      ResendCodeWidget(phone: phone!),
                      const Spacer(
                        flex: 7,
                      ),
                      MainButton(
                          onTap: () async {
                            switch (otpFrom) {
                              case OtpFrom.forgetPassword:
                                BlocProvider.of<ForgetPasswordBloc>(context).add(forgetPasswordCodeVerificationEvent(
                                  code: OtpContiners.code,
                                  phone: phone!,
                                ));
                                break;
                              case OtpFrom.register:
                                BlocProvider.of<RegisterWithPhoneBloc>(context).add(RegisterWithPhoneEvent(
                                  code: OtpContiners.code,
                                  phone: phone!,
                                  password: password!,
                                ));
                                break;
                              case OtpFrom.changePhoneOld:
                                BlocProvider.of<ForgetPasswordBloc>(context).add(forgetPasswordCodeVerificationEvent(
                                  code: OtpContiners.code,
                                  phone: phone!,
                                ));
                                break;
                              case OtpFrom.changePhoneNew:
                                BlocProvider.of<AcountBloc>(context).add(ChangeNumberAccountEvent(
                                  currentPhoneNumber: MyDataModel.getInstance().phone!,
                                  newtPhoneNumber: phone!,
                                  oldCode: oldCode,
                                  newCode: OtpContiners.code,
                                ));
                                break;
                              case OtpFrom.changePassword:
                                BlocProvider.of<AcountBloc>(context).add(ChangePasswordAccountEvent(
                                  vrCode: OtpContiners.code,
                                  phone: phone!,
                                  password: password!,
                                ));
                                break;
                            }
                          },
                          title: StringManager.done.tr()),
                      const Spacer(
                        flex: 20,
                      ),
                    ],
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
