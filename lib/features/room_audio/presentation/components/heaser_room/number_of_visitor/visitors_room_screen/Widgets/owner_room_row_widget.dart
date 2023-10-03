
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/model/user_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/utils/api_healper/constant_api.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/aristocracy_level.dart';
import 'package:tik_chat_v2/core/widgets/level_continer.dart';
import 'package:tik_chat_v2/core/widgets/male_female_icon.dart';
import 'package:tik_chat_v2/core/widgets/show_svga.dart';
import 'package:tik_chat_v2/core/widgets/user_image.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/room_screen_controler.dart';



class OwnerRoomRowWidget extends StatelessWidget {
 const  OwnerRoomRowWidget(
      {required this.userData,
     required this.isInVisitor,
      super.key});
 final UserDataModel userData;
 final  bool isInVisitor ;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(width: ConfigSize.defaultSize! * 0.5,),
             Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                UserImage(
                  image:userData.profile!.image! ,
                  imageSize: ConfigSize.defaultSize! * 5.3,
                ),
                if (userData.frame != "")
                  Positioned(
                    width: ConfigSize.defaultSize! * 8.0,
                    height: ConfigSize.defaultSize! * 8.0,
                    child: SizedBox(
                      child: ShowSVGA(
                        imageId: '${userData.familyId}$cacheFrameKey',
                        url: userData.frame??'',
                      ),
                    ),
                  ),
              ],
            ),

            SizedBox(
              width: ConfigSize.defaultSize! * 1,
            ),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width-ConfigSize.defaultSize!*12,
                  child: Row(
                    children: [
                      Text(
                        userData!.name??''
                          ,
                          style:  Theme.of(context).textTheme.bodyMedium,
                        ),
                        SizedBox(width: ConfigSize.defaultSize!,),
                        SizedBox(width: ConfigSize.defaultSize!*2.5,
                            height:  ConfigSize.defaultSize!*2.5,
                            child: const Image(image: AssetImage(AssetsPath.hostMark))),
                        
 //TODO create find me
                    //   if((userData.nowRoom!.isnInRoom??false) && !isInVisitor)
                    //  SizedBox(
                    //   child: BlocBuilder<GetMyDataBloc, GetMyDataState>(
                    //     builder: (context, state) {
                    //  if (state is GetMyDataSucssesState){
                    //        return FindMeItem(
                    //                             userData: userData,
                    //                             myData:state.userData ,
                    //                           );
                    //  }else {
                    //   return SizedBox();
                    //  }
                    //     },
                    //   )
                    // )


                        ],),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width-ConfigSize.defaultSize!*12,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          userData.vip1 == null?
                               Container()
                              : AristocracyLevel(level: userData.vip1!.level!),
                          MaleFemaleIcon(
                              maleOrFeamle: userData.profile!.gender!, age:  userData.profile!.age, ),
                          SizedBox(width: ConfigSize.defaultSize!*0.5),

                          if(userData.level!.senderImage != '')
                            LevelContainer(
                            image:ConstentApi().getImage(userData.level!.senderImage),

                          ),

                          SizedBox(width: ConfigSize.defaultSize!*0.5),

                          if(userData.level!.receiverImage != '')
                           LevelContainer(
                            image:ConstentApi().getImage(userData.level!.receiverImage),

                          ),
                        ],
                      ),

                      // Text(userData!.visitTime!,style: const TextStyle(color: Colors.grey,fontSize: 10),)
                    ],
                  ),
                )
              ],
            ), // name & details

          ],
        ),
        Divider(
    indent: ConfigSize.defaultSize! * 8,
    endIndent: 0,
    thickness: 1,
    height: ConfigSize.defaultSize! * 2,
    color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
    )
      ],
    );
  }
}
