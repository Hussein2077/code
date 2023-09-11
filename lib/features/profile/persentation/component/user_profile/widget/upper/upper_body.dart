import 'dart:developer';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/api_healper/constant_api.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/gredin_text_vip.dart';
import 'package:tik_chat_v2/core/widgets/user_image.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/user_profile/widget/upper/header.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';


class UpperProfileBody extends StatelessWidget {
  final MyDataModel myDataModel;
  final bool myProfile; 
  const UpperProfileBody({required this.myProfile , required this.myDataModel, super.key});

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: (){
  showImageViewer(context, CachedNetworkImageProvider(ConstentApi().getImage(myDataModel.profile!.image)),
             swipeDismissible: false);
      },
      child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 2.3,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: CachedNetworkImageProvider(
                  ConstentApi().getImage(myDataModel.profile!.image)),
              fit: BoxFit.cover,
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
            child: Container(
              color: Colors.black.withOpacity(0.4),
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: ConfigSize.defaultSize!),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Spacer(
                      flex: 6,
                    ),
                     HeaderProfile(myProfile: myProfile , myDataModel: myDataModel),
                    const Spacer(
                      flex: 6,
                    ),
                    UserImage(
                        image: myDataModel.profile!.image!,
                        boxFit: BoxFit.cover,
                        imageSize: ConfigSize.defaultSize! * 8),
                    const Spacer(
                      flex: 1,
                    ),
                    GradientTextVip(
                      text: myDataModel.name!,
                      textStyle:TextStyle(
                          color: Colors.white,
                          fontSize: ConfigSize.defaultSize! * 1.7,
                          fontWeight: FontWeight.bold),
    
                      isVip: myDataModel.hasColorName!,
                    ),
                 /*   Text(
                      myDataModel.name!,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: ConfigSize.defaultSize! * 1.7,
                          fontWeight: FontWeight.bold),
                    ),*/
                    const Spacer(
                      flex: 1,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: ConfigSize.defaultSize!,
                        ),
                        if(!myDataModel.isCountryHiden!)
                        Text(
                          myDataModel.profile!.country,
                          style:
                              TextStyle(fontSize: ConfigSize.defaultSize! * 1.8),
                        ),
                        SizedBox(
                          width: ConfigSize.defaultSize!,
                        ),
                        itemContiner(
                            title: myDataModel.profile!.age.toString(),
                            gender: myDataModel.profile!.gender
                        ),
                        SizedBox(
                          width: ConfigSize.defaultSize!,
                        ),
                        itemContiner(
                          title: "ID ${myDataModel.uuid}",
                        ),
    
                        SizedBox(
                          width: ConfigSize.defaultSize!,
                        ),
    
                        // if(!myDataModel.lastActiveHidden!)
                        // itemContiner(
                        //   title: "${StringManager.lastActive.tr()}${myDataModel.onlineTime!}",
                        // ),
    
                      ],
                    ),
                    const Spacer(
                      flex: 1,
                    ),
                    Text(
                    myDataModel.bio!,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: ConfigSize.defaultSize! * 1.2,
                      ),
                    ),
                    const Spacer(
                      flex: 3,
                    ),
                      if(!myDataModel.lastActiveHidden!&&myDataModel.onlineTime!="")
                        SizedBox(
                          width: ConfigSize.defaultSize!*15,
                          child: itemContiner(
                            title: "${StringManager.lastActive.tr()}${myDataModel.onlineTime!}",
                          ),
                        ),
                   
                   
                    const Spacer(
                      flex: 2,
                    ),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}

Widget itemContiner({int? gender, required String title}) {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(ConfigSize.defaultSize!),
      color: (gender==null)?Colors.white.withOpacity(0.5): (gender==0)? Colors.pink[200]: Colors.blue[300],

      //
    ),
    child: Row(children: [
      Text(
        "$title ",
        style: TextStyle(
            color: Colors.white, fontSize: ConfigSize.defaultSize! * 1),
      ),
      if (gender != null)

        Image.asset(
          (gender==0)?
          AssetsPath.whiteFemaleIcon:           AssetsPath.whiteMaleIcon,

          scale: 2,
        )


    ]),
  );
}
