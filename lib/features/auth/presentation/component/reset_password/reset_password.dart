import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/mian_button.dart';
import 'package:tik_chat_v2/core/widgets/screen_back_ground.dart';
import 'package:tik_chat_v2/core/widgets/snackbar.dart';
import 'package:tik_chat_v2/core/widgets/text_field.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/features/auth/presentation/component/add_info/widgets/continer_with_icons.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/forget_password/forget_pass_bloc.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/forget_password/forget_pass_event.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/forget_password/forget_pass_state.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({super.key, required this.phone, required this.code});

  final String phone;
  final String code;

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  late TextEditingController passwordController;

  @override
  void initState() {
    passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ForgetPasswordBloc, ForgetPasswordState>(
      listener: (context, state) {
        if (state is ResetPasswordSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            custoumSnackBar(context,state.message),
          );
            Navigator.pushNamedAndRemoveUntil(context, Routes.login,(route) => false);

        } else if (state is ResetPasswordErrorState) {
          errorToast(context: context, title: state.errorMessage);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: ScreenBackGround(
            image: AssetsPath.loginBackGround,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AssetsPath.iconAppWithTitle,
                  scale: 2.5,
                ),
                SizedBox(
                  height: ConfigSize.defaultSize! * 8,
                ),
                ContinerWithIcons(
                    color: Colors.white,
                    icon1: Icons.lock,
                    widget: SizedBox(
                        width: MediaQuery.of(context).size.width - 140,
                        child: TextFieldWidget(
                            hintColor: Colors.black.withOpacity(0.6),
                            hintText: StringManager.password.tr(),
                            controller: passwordController))),
                SizedBox(
                  height: ConfigSize.defaultSize! * 3,
                ),
                MainButton(
                  onTap: () {
                    if (passwordController.text == '') {
                      warningToast(
                          context: context,
                          title: StringManager.pleaseEnterPassword.tr());
                    } else {
                      if (passwordController.text.length >=8) {
                        BlocProvider.of<ForgetPasswordBloc>(context).add(
                            ResetPasswordEvent(
                                phone: widget.phone,
                                code: widget.code,
                                password: passwordController.text));
                      } else if (passwordController.text.length<8){
                        warningToast(
                            context: context,
                            title: StringManager.passwordMustBe.tr());
                      }
                    }
                  },
                  title: StringManager.changePassword.tr(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
