import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/service/service_locator.dart';
import 'package:tik_chat_v2/core/widgets/mian_button.dart';
import 'package:tik_chat_v2/core/widgets/screen_back_ground.dart';
import 'package:tik_chat_v2/core/widgets/text_field.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/features/auth/data/data_soruce/fire_base_datasource.dart';
import 'package:tik_chat_v2/features/auth/presentation/component/add_info/widgets/continer_with_icons.dart';

import 'package:tik_chat_v2/features/auth/presentation/widgets/phone_wtih_country.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
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
    return Scaffold(
        body: ScreenBackGround(
      image: AssetsPath.loginBackGround,
      child: Column(
        children: [
          const Spacer(
            flex: 20,
          ),
          Image.asset(
            AssetsPath.iconAppWithTitle,
            scale: 2.5,
          ),
          const Spacer(
            flex: 20,
          ),
          const PhoneWithCountry(),
          const Spacer(
            flex: 2,
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
          const Spacer(
            flex: 2,
          ),
          MainButton(
            onTap: () {
              if (PhoneWithCountry.number.dialCode == null) {
                warningToast(
                    context: context,
                    title: StringManager.pleaseSelectYourCountry.tr());
              } else {
                if (PhoneWithCountry.phoneIsValid) {
            // todo


                } else {
                  warningToast(
                      context: context, title: StringManager.enterPhoneNum.tr());
                }
              }
            },
            title: StringManager.signUp.tr(),
          ),
          const Spacer(
            flex: 30,
          ),
        ],
      ),
    ));
  }
}
