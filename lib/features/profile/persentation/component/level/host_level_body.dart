import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/screen_color_back_ground.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_my_data_manager/get_my_data_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_my_data_manager/get_my_data_state.dart';
import 'widgets/lower_body.dart';
import 'widgets/upper_body.dart';

class HostLevelBody extends StatelessWidget {
  const HostLevelBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenColorBackGround(
        color: ColorManager.bageGriedinet,
        child: Column(
          children: [
            SizedBox(
              height: ConfigSize.defaultSize! * 3.5,
            ),
            BlocBuilder<GetMyDataBloc, GetMyDataState>(
              builder: (context, state) {
            if(state is GetMyDataSucssesState){
                  return LeveUpperBody(
                    level: state.myDataModel.level!.reciverLivel.toString(),
                     nextLevel: state.myDataModel.level!.nextReciverLevel.toString(),
                   percent: state.myDataModel.level!.reciverPer!,
                  userImage: state.myDataModel.profile!.image!,
                  levelRemining: state.myDataModel.level!.remReceiverLevel.toString(),
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
