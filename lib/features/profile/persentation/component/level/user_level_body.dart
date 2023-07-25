import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:tik_chat_v2/core/resours_manger/color_manager.dart';
import 'package:tik_chat_v2/core/utils/config_sizee.dart';
import 'package:tik_chat_v2/core/widgets/screen_color_back_ground.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_my_data_manager/get_my_data_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_my_data_manager/get_my_data_state.dart';

import 'widgets/lower_body.dart';
import 'widgets/upper_body.dart';

class UserLevelBody extends StatelessWidget {
  const UserLevelBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenColorBackGround(
        color: ColorManager.mainColorList,
        child: Column(
          children: [
            SizedBox(
              height: ConfigSize.defaultSize! * 3.5,
            ),
             BlocBuilder<GetMyDataBloc, GetMyDataState>(
              builder: (context, state) {
                if(state is GetMyDataSucssesState){
                               return  LeveUpperBody(
level: state.userData.level!.senderLevel.toString(),
nextLevel: state.userData.level!.nextSenderLevel.toString(),
percent: state.userData.level!.senderPer!,
userImage: state.userData.profile!.image,
levelRemining: state.userData.level!.remSenderLevel.toString(),


                               );
                                  }else {
                                    return const SizedBox();
                                  }
   
              },
            ),
            const LowerBody(),
          ],
        ));
  }
}
