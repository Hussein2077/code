import 'dart:convert';
import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/values_manger.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/pop_up_dialog.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/Room_Screen.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/defines/media.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/internal/core/core.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/uikit_service.dart';

class AdminMoreDailog extends StatelessWidget {
  final String ownerId;

  const AdminMoreDailog({required this.ownerId, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 6,
      width: MediaQuery.of(context).size.width,
      color: Theme.of(context).colorScheme.background,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
              width: ConfigSize.defaultSize! * 8,
              height: ConfigSize.defaultSize! * 10,
              padding: EdgeInsets.all(ConfigSize.defaultSize! * 0.5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(ConfigSize.defaultSize!),
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              ),
              alignment: Alignment.center,
              child: InkWell(
                onTap: () {
                  if (ZegoUIKit.instance.getMediaTypeNotifier().value !=
                      MediaType.Video) {
                    Navigator.pushNamed(context, Routes.music,
                        arguments: MusicPramiter(ownerId: ownerId));
                  } else if(ZegoUIKit.instance.getMediaTypeNotifier().value ==
                      MediaType.Video){
                    showDialog(
                        context: context,
                        builder: (context) {
                          return PopUpDialog(
                            headerText: StringManager.youHaveToStopVideo.tr(),
                            accpetText: () {
                              Navigator.pop(context);
                            },
                            accpettitle: StringManager.ok.tr(),
                          );
                        });
                  }
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: ConfigSize.defaultSize! * 5,
                      width: ConfigSize.defaultSize! * 5,
                      child: Image.asset(
                        AssetsPath.music2,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    SizedBox(
                      height: ConfigSize.defaultSize! * 0.1,
                      width: ConfigSize.defaultSize! * 0.1,
                    ),
                    Text(StringManager.music2.tr(),
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontSize: ConfigSize.defaultSize! * 1.5)),
                  ],
                ),
              )),
          Container(
              width: ConfigSize.defaultSize! * 12,
              height: ConfigSize.defaultSize! * 10,
              padding: EdgeInsets.all(ConfigSize.defaultSize! * 0.5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(ConfigSize.defaultSize!),
                color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              ),
              alignment: Alignment.center,
              child: InkWell(
                onTap: () {
                  clearChatDialog(context);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: ConfigSize.defaultSize! * 5,
                      width: ConfigSize.defaultSize! * 5,
                      child: Image.asset(
                        AssetsPath.chatLock,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    SizedBox(
                      height: ConfigSize.defaultSize! * 0.1,
                      width: ConfigSize.defaultSize! * 0.1,
                    ),
                    Text(StringManager.clearChat.tr(),
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontSize: ConfigSize.defaultSize! * 1.5)),
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Future<void> clearChat() async {
    ZegoUIKitCore.shared.coreMessage.clear();

    var mapInformation = {
      "messageContent": {
        "message": "removeChat",
      }
    };
    String map = jsonEncode(mapInformation);
    ZegoUIKit.instance.sendInRoomCommand(map, []);
  }

  clearChatDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            StringManager.areYouSure.tr(),
            style: TextStyle(color: Colors.black, fontSize: AppPadding.p18),
          ),
          actions: <Widget>[
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: Container(
                width: ConfigSize.defaultSize! * 9.2,
                height: AppPadding.p26,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: ColorManager.mainColor),
                child: Text(
                  StringManager.no.tr(),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: AppPadding.p16,
                      fontStyle: FontStyle.italic),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
                clearChat();
              },
              child: Container(
                width: ConfigSize.defaultSize! * 9.2,
                height: AppPadding.p26,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: ColorManager.deepPurble),
                child: Text(
                  StringManager.yes.tr(),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: AppPadding.p16,
                      fontStyle: FontStyle.italic),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
