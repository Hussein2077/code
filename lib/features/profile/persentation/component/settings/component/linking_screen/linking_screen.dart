import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/model/owner_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/sign_in_with_paltform_manager/sign_in_with_platform_bloc.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/sign_in_with_paltform_manager/sign_in_with_platform_state.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/settings/component/linking_screen/linking_screen_body.dart';

import 'package:tik_chat_v2/features/profile/persentation/manager/get_my_data_manager/get_my_data_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_my_data_manager/get_my_data_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_my_data_manager/get_my_data_state.dart';

// ignore: must_be_immutable
class LinkingScreen extends StatelessWidget {
  MyDataModel? tempMyData;
  LinkingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignInWithPlatformBloc, SignInWithPlatformState>(
      listener: (context, state) {
        if(state is SiginWithGoogleSuccesMessageState ){
          sucssesToast(context: context, title: StringManager.sucsses);
          BlocProvider.of<GetMyDataBloc>(context).add(GetMyDataEvent());
        }else if (state is SiginWithGoogleErrorMessageState){
          errorToast(context: context, title: state.errorMessage);
        }
      },
      child: BlocBuilder<GetMyDataBloc, GetMyDataState>(
        builder: (context, state) {
          if (state is GetMyDataSucssesState) {
            tempMyData = state.myDataModel;
            return LinkingScreenBody(
              myData: state.myDataModel,
            );
          } else {
            return LinkingScreenBody(
              myData: tempMyData!,
            );
          }
        },
      ),
    );
  }
}
