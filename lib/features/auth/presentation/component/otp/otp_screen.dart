import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import 'package:tik_chat_v2/features/auth/presentation/manager/register_verification_bloc/Register_verification_event.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/register_verification_bloc/register_verification_bloc.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/register_verification_bloc/register_verification_states.dart';
import 'widget/otp_continers.dart';
import 'widget/resend_code_widget.dart';

class OtpScreen extends StatelessWidget {
  final String? phone;
  final String? uuid;
  final OtpFrom otpFrom;

  const OtpScreen({this.phone, super.key, this.uuid, required this.otpFrom});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterVerificationBloc, RegisterVerificationState>(
      listener: (context, state)async {
        if (state is RegisterVerificationSuccessMessageState) {
          switch (otpFrom) {
            case OtpFrom.forgetPassword:
              break;
            case OtpFrom.register:
              Methods.instance.clearAuthData();
              Navigator.pushNamedAndRemoveUntil(
                  context, Routes.addInfo, (route) => false);
              break;
            default:
          }
        } else if (state is RegisterVerificationErrorMessageState) {
          errorToast(context: context, title: state.errorMessage);
        }
      },
      builder: (context, state) {
        return BlocConsumer<ForgetPasswordBloc, ForgetPasswordState>(
          listener: (context, state) {
            if (state is CheckCodeForgetPasswordSuccessState) {
              if (otpFrom == OtpFrom.forgetPassword) {
                Navigator.pushNamed(context, Routes.resetPassword,
                    arguments: ResetPasswordParm(phone: phone!,code:  OtpContiners.code,));
              }
            }
            if (state is CheckCodeForgetPasswordErrorState) {
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
                        fontFamily: "Inter",
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                        fontSize: ConfigSize.defaultSize! + 6),
                  ),
                  const Spacer(
                    flex: 2,
                  ),
                  const OtpContiners(),
                  ResendCodeWidget(
                    uuid: uuid,
                  ),
                  const Spacer(
                    flex: 7,
                  ),
                  MainButton(
                      onTap: () async {
                        switch (otpFrom) {
                          case OtpFrom.forgetPassword:
                            BlocProvider.of<ForgetPasswordBloc>(context)
                                .add(CheckCodeForgetPasswordEvent(
                              code: OtpContiners.code,
                              phone: phone!,
                            ));
                            break;
                          case OtpFrom.register:
                            BlocProvider.of<RegisterVerificationBloc>(context)
                                .add(RegisterVerificationEvent(
                                code: OtpContiners.code,
                                uuid: uuid ?? '',
                                deviceID: ''));
                            break;
                          case OtpFrom.changePhone:
                          // TODO: Handle this case.
                            break;
                          case OtpFrom.changePassword:
                          // TODO: Handle this case.
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
  }
}
