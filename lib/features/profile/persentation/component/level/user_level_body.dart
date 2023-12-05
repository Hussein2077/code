import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/model/user_data_model.dart';

import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/screen_color_back_ground.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_my_data_manager/get_my_data_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_my_data_manager/get_my_data_state.dart';

import 'widgets/lower_body.dart';
import 'widgets/upper_body.dart';

class UserLevelBody extends StatelessWidget {
  UserDataModel? userData ;

   UserLevelBody({this.userData ,  super.key});

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
level: userData==null ?   state.myDataModel.level!.senderLevel.toString(): userData!.level!.senderLevel.toString(),
nextLevel: userData==null ? state.myDataModel.level!.nextSenderLevel.toString() : userData!.level!.nextSenderLevel.toString(),
percent: userData==null ? state.myDataModel.level!.senderPer! : userData!.level!.senderPer!,
userImage: userData==null ? state.myDataModel.profile!.image! : userData!.profile!.image!,
levelRemining: userData==null ? state.myDataModel.level!.remSenderLevel.toString() : userData!.level!.remSenderLevel.toString(),


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
