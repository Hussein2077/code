
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/utils/api_healper/methods.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/sign_in_with_paltform_manager/sign_in_with_platform_bloc.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/sign_in_with_paltform_manager/sign_in_with_platform_event.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/sign_in_with_paltform_manager/sign_in_with_platform_state.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_my_data_manager/get_my_data_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_my_data_manager/get_my_data_event.dart';

class GoogleAuth extends StatelessWidget {
  const GoogleAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInWithPlatformBloc, SignInWithPlatformState>(
      listener: (context, state) {
        if(state is SiginWithGoogleSuccesMessageState){
                    Methods().clearAuthData();
                    //todo check this event if still here or not
                    BlocProvider.of<GetMyDataBloc>(context).add(GetMyDataEvent());
    if(state.userData.apiUserData.isFirst!){
          Navigator.pushNamedAndRemoveUntil(context, Routes.addInfo ,arguments:state.userData.userData , (route) => false, );

    }else {
          Navigator.pushNamedAndRemoveUntil(context, Routes.mainScreen  , (route) => false, );

    }
        }else if (state is SiginWithGoogleErrorMessageState){
          errorToast(context: context, title: state.errorMessage);
        }else {

        }
      },
      builder: (context, state) {
        return InkWell(
          onTap: (){
            

            BlocProvider.of<SignInWithPlatformBloc>(context).add(SiginGoogleEvent());
          },
          child: SizedBox(
              width: ConfigSize.defaultSize! * 5,
              height: ConfigSize.defaultSize! * 5,
              child: Center(
                child: Image.asset(AssetsPath.googleIcon),
              )),
        );
      },
    );
  }
}
