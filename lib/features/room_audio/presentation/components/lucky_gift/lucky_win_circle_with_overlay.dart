import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/lucky_gift/widgets/lucky_candy.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/lucky_gift/widgets/lucky_gift_win_circle.dart';

class LuckyWinCircleWithOverlay extends StatelessWidget {
  const LuckyWinCircleWithOverlay({super.key});

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
      Future.delayed(const Duration(seconds: 2)).then((value) {
        overlayEntry.remove();
      });
    }
    return ValueListenableBuilder<int>(
        valueListenable: LuckyCandy.winCircularluckyGift,
        builder: (context, sohw, _) {
          if (sohw != 0) {
            Future.delayed(const Duration(seconds: 1)).then((value) {
              return showOverlay(const Align(
                  alignment: Alignment.topCenter, child: LuckyGiftWinCircle()));
            });
            return const SizedBox();
          } else {
            return const SizedBox();
          }
        });
  }
}
