
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/utils/api_healper/constant_api.dart';
import 'package:tik_chat_v2/core/utils/api_healper/methods.dart';
import 'package:tik_chat_v2/core/widgets/aristocracy_level.dart';
import 'package:tik_chat_v2/core/widgets/gredin_text_vip.dart';
import 'package:tik_chat_v2/core/widgets/level_continer.dart';
import 'package:tik_chat_v2/core/widgets/show_svga.dart';
import 'package:tik_chat_v2/core/widgets/user_image.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_my_data_manager/get_my_data_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_my_data_manager/get_my_data_state.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/room_screen_controler.dart';

import '../../../../../../../core/utils/config_size.dart';
import '../../../../../data/models/group_chat_model.dart';

class GroupChatRow extends StatelessWidget {
  final GroupChatModel userData;
  const GroupChatRow({required this.userData, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                BlocBuilder<GetMyDataBloc, GetMyDataState>(
                  builder: (context, state) {
                    if(state is GetMyDataSucssesState){
    return InkWell(
                      onTap: () {


                        Methods().userProfileNvgator(context: context , userId: userData.id.toString() );


                      },
                      child: UserImage(
                        image: userData.profile!.image!,
                       imageSize:  ConfigSize.defaultSize! * 5.3,

                      ),
                    );
                    }else {
                          return InkWell(
                      onTap: () {
                        Methods().userProfileNvgator(context: context , userId: userData.id.toString() );

                      },
                            child: UserImage(
                              image: userData.profile!.image!,
                              imageSize:  ConfigSize.defaultSize! * 5.3,

                            ),
                    );
                    }
                
                  },
                ),
                ShowSVGA(
                  hieght: ConfigSize.defaultSize! * 7.3,
                  width: ConfigSize.defaultSize! * 7.3,
                  imageId: '${userData.frameId}$cacheFrameKey',
                  url: userData.frame!,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GradientTextVip(
                isVip:    userData.hasColorName??false,
                  text: userData.name!,
                  textStyle: TextStyle(
                      fontSize: ConfigSize.defaultSize! * 1.5,
                      color: const Color(0xff262628)),
                ),
                Padding(
                    padding:
                        EdgeInsets.only(top: ConfigSize.defaultSize! * 0.7),
                    child: Row(
                      children: [
                        SizedBox(
                          width: ConfigSize.defaultSize! * 0.3,
                        ),
                        if(userData.level!.senderImage != '')
                          LevelContainer(
                           height: ConfigSize.defaultSize! * 2.2,
                            width: ConfigSize.defaultSize! * 4.1,
                          image:
                              userData.level!.senderImage!,
                        ),
                        SizedBox(
                          width: ConfigSize.defaultSize! * 0.3,
                        ),
                        if(userData.level!.receiverImage != '')
                          LevelContainer(
                            height: ConfigSize.defaultSize! * 2.2,
                            width: ConfigSize.defaultSize! * 4.1,
                          image: userData.level!.receiverImage!,
                        ),
                        SizedBox(
                          width: ConfigSize.defaultSize! * 0.3,
                        ),
                        // if (userData.vip1 != null ||
                        //     userData.vip1!.level != null)
                        //   VipContainer(
                        //       hight: ConfigSize.defaultSize! * 1.6,
                        //       width: ConfigSize.defaultSize! * 4,
                        //       vip: userData.vip1!.level!)


                        if (userData.vipLevel!= null )
                          AristocracyLevel(
                            level:userData.vipLevel! ,
                             )
                      ],
                    )),
              ],
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.only(left: ConfigSize.defaultSize!),
          padding: EdgeInsets.all(ConfigSize.defaultSize!),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(ConfigSize.defaultSize!),
              gradient:
                   LinearGradient(colors: ColorManager.mainColorListLight)),
          child: Text(
            userData.groupMessage!,
            overflow: TextOverflow.visible,
            style: TextStyle(
                fontSize: ConfigSize.defaultSize! * 2,
                color: ColorManager.darkBlack),
          ),
        ),

        Text(
          userData.massageCreatedAt!,
          style: TextStyle(
              fontSize: ConfigSize.defaultSize!,
              color: ColorManager.darkBlack),
        ),
      ],
    );
  }
}
