import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';

import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/service/service_locator.dart';
import 'package:tik_chat_v2/core/widgets/custoum_error_widget.dart';
import 'package:tik_chat_v2/core/widgets/loading_widget.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_my_data_manager/get_my_data_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_my_data_manager/get_my_data_state.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manger_getuser/get_user_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manger_getuser/get_user_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manger_getuser/get_user_state.dart';
import 'widget/lower/lower_body.dart';
import 'widget/profile_bottom_bar.dart';
import 'widget/upper/upper_body.dart';

class UserProfile extends StatefulWidget {
  final String? userId;
  const UserProfile({this.userId, super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  bool? myProfile;
  @override
  void initState() {
    if (widget.userId != null) {
      myProfile = false;
      BlocProvider.of<GetUserBloc>(context)
          .add(GetuserEvent(userId: widget.userId!));
    } else {
      myProfile = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: widget.userId == null

          //MyProfile
          ? BlocBuilder<GetMyDataBloc, GetMyDataState>(
              builder: (context, state) {
                if (state is GetMyDataSucssesState) {
                  return Column(
                    children: [
                      UpperProfileBody(
                          myDataModel: state.myDataModel,
                          myProfile: myProfile!),
                      LowerProfileBody(
                          myDataModel: state.myDataModel,
                          myProfile: myProfile!),
                    ],
                  );
                } else if (state is GetMyDataLoadingState) {
                  return const LoadingWidget();
                } else {
                  return Column(
                    children: [
                      UpperProfileBody(
                          myDataModel: getIt<MyDataModel>(),
                          myProfile: myProfile!),
                      LowerProfileBody(
                        myProfile: myProfile!,
                        myDataModel: getIt<MyDataModel>(),
                      ),
                    ],
                  );
                }
              },
            )

          //UserProfile
          : BlocBuilder<GetUserBloc, GetUserState>(
              builder: (context, state) {
                if (state is GetUserSucssesState) {
                  return Column(
                    children: [
                      //TODO detect which values should br in convert method
                      UpperProfileBody(
                          myProfile: myProfile!,
                          myDataModel: state.data.convertToMyDataObject()),
                      LowerProfileBody(
                          myProfile: myProfile!,
                          myDataModel: state.data.convertToMyDataObject()),
                      ProfileBottomBar(
                        userData: state.data,
                      )
                    ],
                  );
                } else if (state is GetUserLoddingState) {
                  return const LoadingWidget();
                } else if (state is GetUserErorrState) {
                  return CustomErrorWidget(message: state.error);
                } else {
                  return const CustomErrorWidget(
                      message: StringManager.unexcepectedError);
                }
              },
            ),
    );
  }
}
