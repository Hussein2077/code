import 'package:animated_icon/animate_icon.dart';
import 'package:animated_icon/animate_icons.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/aristocracy_level.dart';
import 'package:tik_chat_v2/core/widgets/bottom_dailog.dart';
import 'package:tik_chat_v2/core/widgets/gredin_text_vip.dart';
import 'package:tik_chat_v2/core/widgets/level_continer.dart';
import 'package:tik_chat_v2/core/widgets/user_image.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/ente_room_model.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/room_vistor_model.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/profile/general_room_profile.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/defines/user.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/uikit_service.dart';

class UserRow extends StatefulWidget {
  final RoomVistorModel roomVistorModel;
  final LayoutMode layoutMode ;
  final EnterRoomModel roomData ;

  const UserRow({super.key, required this.roomVistorModel, required this.layoutMode, required this.roomData,});

  @override
  State<UserRow> createState() => _UserRowState();
}

class _UserRowState extends State<UserRow> with TickerProviderStateMixin {
  final mediaUsers = ZegoUIKit().getMediaList();
  bool isPlayingMusic =false;
  late AnimationController controller;
  late Animation<double> animation;
  @override
  void initState() {

    for(int i =0; i<mediaUsers.length;i++){
      if(mediaUsers[i].id==widget.roomVistorModel.id.toString()){
      isPlayingMusic=true;
      }
    }


    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Widget animateIcon=    AnimateIcon(
      key: UniqueKey(),
      onTap: () {},
      iconType: IconType.continueAnimation,
      height:  ConfigSize.defaultSize! * 2,
      width:  ConfigSize.defaultSize! * 2,
      color: ColorManager.orange,
      animateIcon: AnimateIcons.tune,
    ) ;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          bottomDailog(
              context: context,
              widget: GeneralRoomProfile(

                userId:widget.roomVistorModel.id.toString() ,
                myData:MyDataModel.getInstance(),
                roomData:widget.roomData,
                layoutMode:widget.layoutMode,
              )
          );
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width:ConfigSize.defaultSize! ,),
            UserImage(image: widget.roomVistorModel.image,boxFit: BoxFit.cover,frame: widget.roomVistorModel.frame,
              frameId: widget.roomVistorModel.frameId,
              imageSize: ConfigSize.defaultSize! * 5,
            ),
            SizedBox(
              width: ConfigSize.defaultSize! * 2,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width:  ConfigSize.screenWidth! * .6,
                  child: Row(
                    children: [
                      GradientTextVip(
                        text: widget.roomVistorModel.name,
                        textStyle: Theme.of(context).textTheme.bodyLarge!,
                        isVip: widget.roomVistorModel.hasColorName,
                      ),
                      SizedBox(
                        width: ConfigSize.defaultSize! * 2,
                      ),
                      if(widget.roomVistorModel.type == 0) Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: ColorManager.orang),child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                        child: Icon(Icons.home, color: Colors.white, size: ConfigSize.defaultSize!*2,),
                      ),),
                      if(widget.roomVistorModel.type == 1) Image.asset(AssetsPath.adminMark, scale: 2,),
                      const Spacer(),
                            StreamBuilder<List<ZegoUIKitUser>>(
                                stream: ZegoUIKit().getMediaListStream(),
                                builder: (BuildContext context, AsyncSnapshot<List<ZegoUIKitUser>> snapshot){
                                  return Row(
                                    children: [
                                      if(snapshot.hasData)
                                        for(int i =0; i<snapshot.data!.length;i++)
                                          if(snapshot.data![i].id==widget.roomVistorModel.id.toString())
                                            animateIcon,
                                      if (!snapshot.hasData&&isPlayingMusic)
                                        animateIcon
                                    ],
                                  );
                                }
                            ),

                    ],
                  ),
                ),
                SizedBox(
                  height: ConfigSize.defaultSize!*3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      LevelContainer(
                        image: widget.roomVistorModel.revicerLevelImg,
                        width: ConfigSize.defaultSize!*5,
                        height: ConfigSize.defaultSize!*2,
                      ),
                      SizedBox(width:ConfigSize.defaultSize! ,),
                      LevelContainer(
                        width: ConfigSize.defaultSize!*5,
                        height: ConfigSize.defaultSize!*2,
                        image: widget.roomVistorModel.senderLevelImg,
                      ),             SizedBox(width:ConfigSize.defaultSize! ,),
                      AristocracyLevel(
                        level: widget.roomVistorModel.vipLevel,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
