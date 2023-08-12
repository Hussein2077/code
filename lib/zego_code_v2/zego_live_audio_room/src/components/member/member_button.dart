// Flutter imports:
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/features/room/data/model/ente_room_model.dart';
import 'package:tik_chat_v2/features/room/presentation/Room_Screen.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:flutter_screenutil/flutter_screenutil.dart';


import '../../../../zego_uikit/zego_uikit.dart';

// Project imports:
import 'package:tik_chat_v2/zego_code_v2/zego_live_audio_room/src/components/defines.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_live_audio_room/src/components/member/member_list_sheet.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_live_audio_room/src/connect/connect_manager.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_live_audio_room/src/live_audio_room_inner_text.dart';
import 'package:tik_chat_v2/zego_code_v2/zego_live_audio_room/src/seat/seat_manager.dart';



class ZegoMemberButton extends StatefulWidget {
  const ZegoMemberButton({
    Key? key,
    this.avatarBuilder,
    required this.isPluginEnabled,
    required this.seatManager,
    required this.connectManager,
    required this.innerText,
    required this.onMoreButtonPressed,
    required this.roomData,
    required this.myDataModel,
    this.iconSize,
    this.buttonSize,
    this.icon,
    required this.layoutMode,
  }) : super(key: key);

  final bool isPluginEnabled;
  final ZegoAvatarBuilder? avatarBuilder;
  final ZegoLiveSeatManager seatManager;
  final ZegoLiveConnectManager connectManager;
  final ZegoInnerText innerText;
  final EnterRoomModel roomData ;
  final MyDataModel myDataModel ;
  final Size? iconSize;
  final Size? buttonSize;
  final ButtonIcon? icon;
  final LayoutMode layoutMode ;


  final ZegoMemberListSheetMoreButtonPressed? onMoreButtonPressed;

  @override
  State<ZegoMemberButton> createState() => _ZegoMemberButtonState();
}

class _ZegoMemberButtonState extends State<ZegoMemberButton> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final containerSize = widget.buttonSize ?? Size(96.r, 96.r);
    final sizeBoxSize = widget.iconSize ?? Size(56.r, 56.r);

    return GestureDetector(
      onTap: () {
        showMemberListSheet(
          context: context,
          avatarBuilder: widget.avatarBuilder,
          isPluginEnabled: widget.isPluginEnabled,
          seatManager: widget.seatManager,
          connectManager: widget.connectManager,
          innerText: widget.innerText,
          onMoreButtonPressed: widget.onMoreButtonPressed,
          roomData: widget.roomData,
          layoutMode: widget.layoutMode, myDataModel: widget.myDataModel,
        );
      },
      child: Stack(
        children: [
          Container(
            width: containerSize.width,
            height: containerSize.height,
            decoration: BoxDecoration(
              color: widget.icon?.backgroundColor ?? Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: SizedBox.fromSize(
              size: sizeBoxSize,
              child: widget.icon?.icon ??
                  PrebuiltLiveAudioRoomImage.asset(
                      PrebuiltLiveAudioRoomIconUrls.toolbarMember),
            ),
          ),
          redPoint(),
        ],
      ),
    );
  }

  Widget redPoint() {
    return ValueListenableBuilder<bool>(
      valueListenable: widget.seatManager.isSeatLockedNotifier,
      builder: (context, isSeatLocked, _) {
        if (!isSeatLocked) {
          /// if seat not locked, red point is hidden
          return Container();
        }

        return ValueListenableBuilder<List<ZegoUIKitUser>>(
          valueListenable:
              widget.connectManager.audiencesRequestingTakeSeatNotifier,
          builder: (context, requestTakeSeatUsers, _) {
            if (requestTakeSeatUsers.isEmpty) {
              return Container();
            } else {
              return Positioned(
                top: 0,
                right: 0,
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red,
                  ),
                  width: 20.r,
                  height: 20.r,
                ),
              );
            }
          },
        );
      },
    );
  }
}
