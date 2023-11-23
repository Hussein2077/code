


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/lucky_gift/widgets/luky_gift_image.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manger_lucky_gift_banner/lucky_gift_banner_bloc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manger_lucky_gift_banner/lucky_gift_banner_state.dart';
class LuckyGiftWithOverlay extends StatelessWidget {

  const LuckyGiftWithOverlay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    showOverlay(Widget widget) {
      OverlayState overlayState = Overlay.of(context);
      overlayState = Overlay.of(context);
      OverlayEntry overlayEntry = OverlayEntry(
        builder: (context) => Padding(
            padding: EdgeInsets.all(ConfigSize.defaultSize! * 1.5),
            child: widget),
      );
      overlayState.insert(overlayEntry);
      Future.delayed(const Duration(seconds:5)).then((value) {
        overlayEntry.remove();
      });
    }

    return  BlocBuilder<LuckyGiftBannerBloc, LuckyGiftBannerState>(
          builder: (context, state) {
        if (state is SendLuckyGiftSucssesState) {
          Future.delayed(const Duration(seconds: 2)).then((value) {
            return showOverlay( Align(
                alignment: Alignment.center,
                child:  LukyGiftImage(giftImg: state.data.giftImage,)));
          });
          return const SizedBox();
        }else{
          return const SizedBox();
        }
      },
    ) ;





  }
}
