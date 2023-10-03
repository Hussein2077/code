import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/moment/presentation/componants/giftbox/widgets/moment_gift_bottom_bar_body.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/Gift_manger/gift_bloc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/Gift_manger/gift_states.dart';


class MomentGiftboxBottomBar extends StatefulWidget {
  //final MyDataModel  myDataModel;
  //final EnterRoomModel roomData;
  const MomentGiftboxBottomBar(
      {
      //required this.myDataModel,
      //required this.roomData,
      super.key});

  static int giftId = 0;
  static int giftPrice = 0;
  static int numOfGift = -1;

  @override
  State<MomentGiftboxBottomBar> createState() => _MomentGiftboxBottomBarState();
}

class _MomentGiftboxBottomBarState extends State<MomentGiftboxBottomBar>
    with TickerProviderStateMixin {
  TabController? giftControler;

  @override
  void initState() {
    super.initState();
    giftControler = TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GiftBloc, GiftsStates>(builder: (context, state) {
      return BlurryContainer(
        blur: 8,
        elevation: 0,
        height: ConfigSize.defaultSize!*11.421,
        width: double.infinity,
        color: Colors.black.withOpacity(0.5),

        borderRadius:  BorderRadius.only(
            topLeft: Radius.circular(ConfigSize.defaultSize!*1.4), topRight: Radius.circular(ConfigSize.defaultSize!*1.4)),
        child: Center(
          child: Container(
              color: Colors.transparent,
              child: MomtentGiftBottomBarBody()),
        ),
      );
    });
  }
}
