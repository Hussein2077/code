// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/utils/api_healper/methods.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/features/auth/data/model/third_party_auth_model.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/add_info_bloc/add_info_bloc.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/add_info_bloc/add_info_event.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/sign_in_with_paltform_manager/sign_in_with_platform_bloc.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/sign_in_with_paltform_manager/sign_in_with_platform_event.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/sign_in_with_paltform_manager/sign_in_with_platform_state.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_my_data_manager/get_my_data_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_my_data_manager/get_my_data_event.dart';
import 'package:tik_chat_v2/splash.dart';

class GoogleAndAppleAuth extends StatelessWidget {

  GoogleAndAppleAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInWithPlatformBloc, SignInWithPlatformState>(
      listener: (context, state) async {
        if (state is SiginWithGoogleSuccesMessageState) {
          Methods.instance.clearAuthData();
          BlocProvider.of<GetMyDataBloc>(context).add(GetMyDataEvent());
          if (state.userData.apiUserData.isFirst!) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.addInfo,
              arguments: ThirdPartyAuthModel(
                data: state.userData.userData,
                type: "google",
              ),
              (route) => false,
            );
          } else {
            BlocProvider.of<AddInfoBloc>(context).add(AddInfoEvent(email: state.userData.userData.email.toString()));
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.mainScreen,
              (route) => false,
            );
          }
        } else if (state is SiginWithGoogleErrorMessageState) {
          errorToast(context: context, title: state.errorMessage);
        } else if (state is SiginWithPlatFormLoadingState) {
          loadingToast(context: context);
        }
        if (state is SiginWithAppleSuccesMessageState) {
          Methods.instance.clearAuthData();
          BlocProvider.of<GetMyDataBloc>(context).add(GetMyDataEvent());
          if (state.userModel.apiUserData.isFirst!) {
            Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.addInfo,
                arguments: ThirdPartyAuthModel(
                  data: state.userModel.userData,
                  type: "apple",
                ),
                (route) => false);
          } else {
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.mainScreen,
              (route) => false,
            );
          }
        } else if (state is SiginWithHuaweiSuccesMessageState){
          Methods.instance.clearAuthData();
          BlocProvider.of<GetMyDataBloc>(context).add(GetMyDataEvent());
          if (state.userModel.apiUserData.isFirst!){

            log("state.userModel.apiUserData.isFirst!");
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.addInfo,
              arguments: ThirdPartyAuthModel(
                data: state.userModel.userData,
                type: "huawei",
              ),
                  (route) => false,
            );
          } else {
            BlocProvider.of<AddInfoBloc>(context).add(AddInfoEvent(email: state.userModel.userData.email.toString()));
            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.mainScreen,
                  (route) => false,
            );
          }
        } else if (state is SiginWithHuaweiErrorMessageState) {
          errorToast(context: context, title: state.errorMessage);
        }
      },
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [

            if(SplashScreen.isGoogle) InkWell(
              onTap: () {
                BlocProvider.of<SignInWithPlatformBloc>(context).add(SiginGoogleEvent());
              },
              child: SizedBox(
                  width: ConfigSize.defaultSize! * 5,
                  height: ConfigSize.defaultSize! * 5,
                  child: Center(
                    child: Image.asset(AssetsPath.googleIcon),
                  )),
            ),
            if(SplashScreen.isHuawei) InkWell(
              onTap: () {
                BlocProvider.of<SignInWithPlatformBloc>(context).add(SiginHuaweiEvent());
              },
              child: CircleAvatar(
                backgroundColor: Colors.red,
                radius: ConfigSize.defaultSize! * 2.5,
                child: Center(
                  child: Image.asset(AssetsPath.huaweiIcon, color: ColorManager.whiteColor, scale: 20,),
                ),
              ),
            ),

            if (Platform.isIOS) InkWell(
                onTap: () {
                  BlocProvider.of<SignInWithPlatformBloc>(context)
                      .add(SiginAppleEvent());
                },
                child: CircleAvatar(
                  radius: ConfigSize.defaultSize! * 2.8,
                  backgroundColor: ColorManager.whiteColor,
                  child: Center(
                    child: Icon(
                      Icons.apple,
                      color: ColorManager.gray,
                      size: ConfigSize.defaultSize! * 4.8,
                    ),
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
