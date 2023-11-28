import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/moment/presentation/componants/giftbox/widgets/moment_gift_bottom_bar_body.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/Gift_manger/gift_bloc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/Gift_manger/gift_states.dart';


class MomentGiftboxBottomBar extends StatefulWidget {

  const MomentGiftboxBottomBar({super.key, required this.momentId,});
  final String momentId;

  @override
  State<MomentGiftboxBottomBar> createState() => _MomentGiftboxBottomBarState();
}
class _MomentGiftboxBottomBarState extends State<MomentGiftboxBottomBar> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GiftBloc, GiftsStates>(builder: (context, state) {
      return BlurryContainer(
        blur: 8,
        elevation: 0,
        width: double.infinity,
        color: Colors.black87.withOpacity(0.5),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(ConfigSize.defaultSize! * 1.4),
            topRight: Radius.circular(ConfigSize.defaultSize! * 1.4)),
        child: Center(
          child: Container(
              color: Colors.transparent,
              child: MomtentGiftBottomBarBody(
                momentId: widget.momentId,
              )),
        ),
      );
    });
  }
}