import 'package:cometchat_chat_uikit/cometchat_chat_uikit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/api_healper/methods.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/user_image.dart';

import '../../../../core/model/user_data_model.dart';

class ProfileChatDetails extends StatefulWidget {
  final UserDataModel userData;

  const ProfileChatDetails({super.key, required this.userData});



  @override
  State<ProfileChatDetails> createState() => ProfileChatDetailsState();
}

class ProfileChatDetailsState extends State<ProfileChatDetails> {
  static ValueNotifier<bool>blockNotifier=ValueNotifier(false);
  List<String> strings = [
    StringManager.viewProfile.tr(),
    StringManager.block.tr(),

  ];
  List<Color> colors = [
    Colors.blue,
    Colors.red,
  ];

  @override
  Widget build(BuildContext context) {
    List<void Function()> onTaps = [
          () {

        Methods.instance.userProfileNvgator(context: context,userData: widget.userData );
      },
          () {
        //CometChat.blockUser(uids, onSuccess: onSuccess, onError: onError);,
        //     CometChat.unblockUser(uids, onSuccess: onSuccess, onError: onError),
        //blockNotifier=!blockNotifier;
      },
    ];
    return Scaffold(
      backgroundColor:Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: ConfigSize.defaultSize! * 2,
          ),
          SizedBox(
            width: ConfigSize.screenWidth,
            height: ConfigSize.defaultSize!*2,
            child: Row(
              children: [
                const Spacer(
                  flex: 1,
                ),
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close,color: Colors.black,)),
                const Spacer(
                  flex: 3,
                ),
                Text(
                  StringManager.details.tr(),
                  style: TextStyle(fontSize: ConfigSize.defaultSize!*2, fontWeight: FontWeight.w700,color: Colors.black,),
                ),
                const Spacer(
                  flex: 15,
                ),
              ],
            ),
          ),
          SizedBox(
            height: ConfigSize.defaultSize! * 2,
          ),
          SizedBox(
            width: ConfigSize.screenWidth,
            height: ConfigSize.defaultSize! * 8,
            child:  Row(
              children: [                SizedBox(width: ConfigSize.defaultSize!*3,),

                UserImage(image: widget.userData.profile!.image!),
                SizedBox(width: ConfigSize.defaultSize!*1.8,),
                Text(
                  widget.userData.name!,
                  style:
                  TextStyle(fontSize: ConfigSize.defaultSize!*1.8, fontWeight: FontWeight.w600,color: Colors.black,),
                )
              ],
            ),
          ),

          InkWell(
            onTap: (){
              Methods.instance.userProfileNvgator(context: context,userData: widget.userData );

            },
            child: ValueListenableBuilder(
              valueListenable: ProfileChatDetailsState.blockNotifier,
              builder: (context, value, child) {
                return  Text(
                  StringManager.viewProfile.tr(),
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: ConfigSize.defaultSize! * 1.5,
                  ),
                );
              },
            ),
          ),
          InkWell(
            onTap:      () {
              // CometChat.blockUser(uids, onSuccess: onSuccess, onError: onError);
              //     CometChat.unblockUser(uids, onSuccess: onSuccess, onError: onError);
              // blockNotifier=!blockNotifier;
            },
            child: ValueListenableBuilder(
              valueListenable: ProfileChatDetailsState.blockNotifier,
              builder: (context, value, child) {
                return  Text(
                  StringManager.block.tr(),
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: ConfigSize.defaultSize! * 1.5,
                  ),
                );
              },
            ),
          ),

        ],
      ),
    );
  }
}

class DetailsiItem extends StatelessWidget {
  final Color color;
  final String string;
  final void Function() onTap;

  const DetailsiItem({
    super.key,
    required this.color,
    required this.string,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: ConfigSize.defaultSize!*3,vertical:ConfigSize.defaultSize!*0.8),
      child: InkWell(
        onTap: onTap,
        child: ValueListenableBuilder(
          valueListenable: ProfileChatDetailsState.blockNotifier,
          builder: (context, value, child) {
            return  Text(
              string,
              style: TextStyle(
                color: color,
                fontSize: ConfigSize.defaultSize! * 1.5,
              ),
            );
          },
        ),
      ),
    );
  }
}
