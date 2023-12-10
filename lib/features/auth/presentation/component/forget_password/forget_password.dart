import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/mian_button.dart';
import 'package:tik_chat_v2/core/widgets/screen_back_ground.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/forget_password/forget_pass_bloc.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/forget_password/forget_pass_event.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/forget_password/forget_pass_state.dart';
import 'package:tik_chat_v2/features/auth/presentation/widgets/phone_wtih_country.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  @override
  void dispose() {
    PhoneWithCountry.number = PhoneNumber(phoneNumber: null);
    super.dispose();
  }

  String? phone;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgetPasswordBloc, ForgetPasswordState>(
      listener: (context, state) {
        if (state is ForgetPasswordSuccessState) {
          Navigator.pushNamed(context, Routes.otp,
              arguments:
                  OtbScreenParm(otpFrom: OtpFrom.forgetPassword, phone: phone));
        }
        if (state is ForgetPasswordErrorState) {
          errorToast(context: context, title: state.errorMessage);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: ScreenBackGround(
            image: AssetsPath.loginBackGround,
            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Image.asset(
                AssetsPath.iconAppWithTitle,
                scale: 2.5,
              ),
              SizedBox(
                height: ConfigSize.defaultSize! * 8,
              ),
              const PhoneWithCountry(),
              SizedBox(
                height: ConfigSize.defaultSize! * 3,
              ),
              MainButton(
                onTap: () {
                  if (PhoneWithCountry.number.dialCode == null) {
                    warningToast(
                        context: context,
                        title: StringManager.pleaseEnterPhoneNum.tr());
                  } else {
                    if (PhoneWithCountry.phoneIsValid) {
                      phone = PhoneWithCountry.number.phoneNumber
                          .toString()
                          .replaceAll(
                              PhoneWithCountry.number.dialCode.toString(), '');
                      BlocProvider.of<ForgetPasswordBloc>(context)
                          .add(ForgetPasswordEvent(phone!));
                    } else {
                      warningToast(
                          context: context,
                          title: StringManager.enterPhoneNum.tr());
                    }
                  }
                },
                title: StringManager.signUp.tr(),
              ),
            ]),
          ),
        );
      },
    );
  }
}
