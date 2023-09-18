



import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/model/user_data_model.dart';

import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/service/service_locator.dart';
import 'package:tik_chat_v2/core/widgets/custoum_error_widget.dart';
import 'package:tik_chat_v2/core/widgets/loading_widget.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_my_data_manager/get_my_data_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_my_data_manager/get_my_data_state.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_get_user_reels/get_user_reels_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_get_user_reels/get_user_reels_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manger_getuser/get_user_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manger_getuser/get_user_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manger_getuser/get_user_state.dart';
import 'widget/lower/lower_body.dart';
import 'widget/profile_bottom_bar.dart';
import 'widget/upper/upper_body.dart';

class UserProfile extends StatefulWidget {
  final String? userId;
  final UserDataModel? userData ;
  const UserProfile({this.userId,this.userData ,   super.key});

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
               BlocProvider.of<GetUserReelsBloc>(context)
          .add(GetUserReelEvent(id:  widget.userId!));

    }else if (widget.userData!=null){
            myProfile = false;

    }
    
     else {
      myProfile = true;
                    BlocProvider.of<GetUserReelsBloc>(context)
          .add(const GetUserReelEvent(id: null));
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: (widget.userId == null&&widget.userData==null)

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
                          userDataModel: state.myDataModel.convertToUserObject(),
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
                        userDataModel: getIt<MyDataModel>().convertToUserObject(),
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
                      //TODO you should remove this function
                      UpperProfileBody(
                          myProfile: myProfile!,
                          myDataModel:widget.userData!=null?widget.userData!.convertToMyDataObject():
                          state.data.convertToMyDataObject()),
                      LowerProfileBody(
                          myProfile: myProfile!,
                          userDataModel:widget.userData!=null?widget.userData!: state.data),
                      ProfileBottomBar(
                        userData:widget.userData!=null? widget.userData!: state.data,
                      )
                    ],
                  );
                }
                else if (state is GetUserLoddingState) {
                  return const LoadingWidget();
                } else if (state is GetUserErorrState) {
                  return CustomErrorWidget(message: state.error);
                } else {
                  return widget.userData!=null?
                      Column(
                    children: [
                      UpperProfileBody(
                          myProfile: myProfile!,
                          myDataModel: widget.userData!.convertToMyDataObject()),
                      LowerProfileBody(
                          myProfile: myProfile!,
                          userDataModel: widget.userData!),
                      ProfileBottomBar(
                        userData: widget.userData!,
                      )
                    ],
                  ) :
                  const CustomErrorWidget(
                      message: StringManager.unexcepectedError);
                }
              },
            ),
    );
  }
}
