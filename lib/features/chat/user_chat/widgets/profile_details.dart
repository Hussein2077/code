import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/user_image.dart';

import '../../../../core/model/user_data_model.dart';

class ProfileChatDetails extends StatefulWidget {
  final UserDataModel userData;

  const ProfileChatDetails({super.key, required this.userData});



  @override
  State<ProfileChatDetails> createState() => _ProfileChatDetailsState();
}

class _ProfileChatDetailsState extends State<ProfileChatDetails> {
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
     // Navigator.pushNamed(context, )
      },
      () {
      //CometChat.blockUser(uids, onSuccess: onSuccess, onError: onError);,
        //     CometChat.unblockUser(uids, onSuccess: onSuccess, onError: onError),
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
          Expanded(

            child: ListView.builder(
              itemCount: 3,
              itemBuilder: (context, i) {
                return DetailsiItem(
                  color: colors[i],
                  onTap: onTaps[i],
                  string: strings[i],
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
        child: Text(
          string,
          style: TextStyle(
            color: color,
            fontSize: ConfigSize.defaultSize! * 1.5,
          ),
        ),
      ),
    );
  }
}
