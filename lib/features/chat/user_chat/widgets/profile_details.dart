
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/model/user_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/api_healper/methods.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/user_image.dart';
import 'package:tik_chat_v2/features/chat/data/data_source/remoted_dataSource_chat.dart';


class ProfileChatDetails extends StatefulWidget {
  final UserDataModel userData;

  const ProfileChatDetails({super.key, required this.userData});

  @override
  State<ProfileChatDetails> createState() => ProfileChatDetailsState();
}

class ProfileChatDetailsState extends State<ProfileChatDetails> {
  static bool chick = false;
  static ValueNotifier<bool> blockNotifier = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: ConfigSize.defaultSize! * 2,
            ),
            SizedBox(
              width: ConfigSize.screenWidth,
              height: ConfigSize.screenHeight! * 0.03,
              child: Row(
                children: [
                  const Spacer(
                    flex: 1,
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.close,
                        color: Colors.black,
                      )),
                  const Spacer(
                    flex: 3,
                  ),
                  Text(
                    StringManager.details.tr(),
                    style: TextStyle(
                      fontSize: ConfigSize.defaultSize! * 2,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
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
              child: Row(
                children: [
                  SizedBox(
                    width: ConfigSize.defaultSize! * 3,
                  ),
                  UserImage(image: widget.userData.profile!.image!),
                  SizedBox(
                    width: ConfigSize.defaultSize! * 1.8,
                  ),
                  Text(
                    widget.userData.name!,
                    style: TextStyle(
                      fontSize: ConfigSize.defaultSize! * 1.8,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: ConfigSize.defaultSize! * 3,
                  vertical: ConfigSize.defaultSize! * 0.8),
              child: InkWell(
                onTap: () {
                  Methods.instance.userProfileNvgator(
                      context: context, userData: widget.userData);
                },
                child: Text(
                  StringManager.viewProfile.tr(),
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: ConfigSize.defaultSize! * 1.5,
                  ),
                ),
              ),
            ),
            // FutureBuilder<bool>(
            //   future: checker(),
            //   builder: (context, snapshot) {
            //     bool isBlocked = snapshot.data ??
            //         false;
            //
            //     return Padding(
            //       padding: EdgeInsets.symmetric(
            //         horizontal: ConfigSize.defaultSize! * 3,
            //         vertical: ConfigSize.defaultSize! * 0.8,
            //       ),
            //       child: InkWell(
            //         onTap: () async {
            //           if (isBlocked) {
            //             BlocProvider.of<AddBlockBloc>(context).add(
            //               AddBlockEvent(
            //                   userId: widget.userData.id.toString()),
            //             );
            //
            //             // CometChat.blockUser(uids, onSuccess: (Map<String, dynamic>){
            //             //
            //             //
            //             // }, onError: onError);
            //           } else {
            //             BlocProvider.of<RemoveBlockBloc>(context).add(
            //               RemoveBlockEvent(
            //                   userId: widget.userData.id.toString()),
            //             );
            //             // CometChat.unblockUser(uids, onSuccess: onSuccess, onError: onError);
            //           }
            //         },
            //         child: Text(
            //           isBlocked
            //               ? StringManager.block.tr()
            //               : StringManager.unBlock.tr(),
            //           style: TextStyle(
            //             color: Colors.red,
            //             fontSize: ConfigSize.defaultSize! * 1.5,
            //           ),
            //         ),
            //       ),
            //     );
            //   },
            // ),

          ],
        ),
      ),
    );
  }

  Future<bool> checker() async {
    bool check = await
    RemotedDataSourceChat().blockUnblock(widget.userData.id.toString());
    return check;
  }


}





