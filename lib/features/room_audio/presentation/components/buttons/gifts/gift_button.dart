import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:svgaplayer_flutter/svgaplayer_flutter.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

import 'package:tik_chat_v2/core/widgets/bottom_dailog.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/ente_room_model.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/buttons/gifts/widgets/Gift_Room_Screen.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/buttons/gifts/widgets/anonymous_dialog_gifts.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/defines/user.dart';

class GiftButton extends StatefulWidget {
  const GiftButton(
      {required this.myDataModel,
      required this.listAllUsers,
      required this.roomData,
      super.key});

  final MyDataModel myDataModel;
  final List<ZegoUIKitUser> listAllUsers;

  final EnterRoomModel? roomData;

  @override
  State<GiftButton> createState() => _GiftButtonState();
}

class _GiftButtonState extends State<GiftButton> with TickerProviderStateMixin{
  late SVGAAnimationController animationController;

  void loadAnimation() async {
    final videoItem =
        await SVGAParser.shared.decodeFromAssets(AssetsPath.sendBoxSVGA);
    animationController.videoItem = videoItem;
    animationController
        .repeat() // Try to use .forward() .reverse()
        .whenComplete(() {
      return animationController.videoItem = null;
    });
  }
  @override
  void initState() {
    animationController = SVGAAnimationController(vsync: this);
    loadAnimation();
    super.initState();
  }
  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.myDataModel.id.toString().startsWith('-1')
            ? showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AnonymounsDialogGifts();
                })
            : bottomDailog(
                context: context,
                widget: GiftScreen(
                  listAllUsers: widget.listAllUsers,
                  roomData: widget.roomData!,
                  myDataModel: widget.myDataModel,
                  isSingleUser: false,
                  userId: null,
                  userImage: null,
                ));
      },
      child: SizedBox(
        height: ConfigSize.defaultSize! * 5,
        width: ConfigSize.defaultSize! * 5,
        child: SVGAImage(animationController),
      ),
    );
  }
}
