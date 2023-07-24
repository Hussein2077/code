
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/resours_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resours_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resours_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resours_manger/string_manger.dart';
import 'package:tik_chat_v2/core/utils/config_sizee.dart';
import 'package:tik_chat_v2/core/widgets/mian_button.dart';
import 'package:tik_chat_v2/core/widgets/screen_back_ground.dart';
import 'package:tik_chat_v2/core/widgets/text_field.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/features/auth/presentation/auth_controller.dart';
import 'package:tik_chat_v2/features/auth/presentation/component/add_info/widgets/continer_with_icons.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/login_with_phone_manager/login_with_phone_bloc.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/login_with_phone_manager/login_with_phone_event.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/login_with_phone_manager/login_with_phone_state.dart';
import 'package:tik_chat_v2/features/auth/presentation/widgets/custom_horizental_dvider.dart';

import 'widgets/google_auth.dart';
import 'widgets/phone_wtih_country.dart';
import 'widgets/privcy_text_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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

    return BlocConsumer<LoginWithPhoneBloc, LoginWithPhoneState>(
    
      builder: (context, state) {
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
                          hintText: StringManager.password,
                          controller: passwordController))),
              const Spacer(
                flex: 2,
              ),
              MainButton(
                onTap: () {
                 
                  if (PhoneWithCountry.phoneIsValid) {
                    BlocProvider.of<LoginWithPhoneBloc>(context).add(
                        LoginWithPhoneEvent(
                            phone: PhoneWithCountry.number.phoneNumber!,
                            password: passwordController.text));
                  }
                },
                title: StringManager.login,
              ),
              const Spacer(
                flex: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomHorizntalDvider(width: ConfigSize.defaultSize! * 10),
                  Text(
                    StringManager.orLoginWith,
                    style: TextStyle(
                        fontSize: ConfigSize.defaultSize! + 4,
                        color: ColorManager.whiteColor),
                  ),
                  CustomHorizntalDvider(width: ConfigSize.defaultSize! * 10),
                ],
              ),
              const Spacer(
                flex: 1,
              ),
           Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:const [
                GoogleAuth(),
           ],),
              const Spacer(
                flex: 1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    StringManager.donnotHaveAccount,
                    style: TextStyle(
                        fontSize: ConfigSize.defaultSize! + 4,
                        color: ColorManager.whiteColor),
                  ),
                  InkWell(
                    onTap: () {
                      Authcontroller().clearAuth();
                      Navigator.pushNamed(context, Routes.signUp);
                    },
                    child: Text(
                      StringManager.createAcoount,
                      style: TextStyle(
                          fontSize: ConfigSize.defaultSize! + 4,
                          color: ColorManager.whiteColor),
                    ),
                  ),
                ],
              ),
              const PrivacyAndServiceTextWidget(),
              const Spacer(
                flex: 1,
              )
            ],
          ),
        ));
      },
        listener: (context, state) {
           if (state is LoginWithPhoneSuccesMessageState) {

                                    Authcontroller().clearAuth();

               Navigator.pushNamedAndRemoveUntil(context, Routes.mainScreen , (route) => false,);
                      //to do getmy data
                      

           }  else if (state is LoginWithPhoneErrorMessageState) {
            errorToast(context: context, title: state.errorMessage);
           }
      },
    );
  }
}
