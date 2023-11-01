// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/components/defines.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/components/internal/internal.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/components/screen_util/screen_util.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/services.dart';

/// @nodoc
class ZegoScreenSharingToggleButton extends StatefulWidget {
  const ZegoScreenSharingToggleButton({
    Key? key,
    this.iconStartSharing,
    this.iconStopSharing,
    this.buttonSize,
    this.iconSize,
    this.onPressed,
  }) : super(key: key);

  final ButtonIcon? iconStartSharing;
  final ButtonIcon? iconStopSharing;

  /// the size of button's icon
  final Size? iconSize;

  /// the size of button
  final Size? buttonSize;

  ///  You can do what you want after pressed.
  final void Function(bool isStart)? onPressed;

  @override
  State<ZegoScreenSharingToggleButton> createState() =>
      _ZegoScreenSharingToggleButtonState();
}

/// @nodoc
class _ZegoScreenSharingToggleButtonState
    extends State<ZegoScreenSharingToggleButton> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final containerSize = widget.buttonSize ?? Size(96.zR, 96.zR);
    final sizeBoxSize = widget.iconSize ?? Size(56.zR, 56.zR);
    return ValueListenableBuilder<bool>(
      valueListenable: ZegoUIKit().getScreenSharingStateNotifier(),
      builder: (context, isScreenSharing, _) {
        return GestureDetector(
          onTap: onPressed,
          child: Container(
            width: containerSize.width,
            height: containerSize.height,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: SizedBox.fromSize(
              size: sizeBoxSize,
              child: isScreenSharing
                  ? widget.iconStartSharing?.icon ??
                      UIKitImage.asset(StyleIconUrls.iconScreenShareStop)
                  : widget.iconStopSharing?.icon ??
                      UIKitImage.asset(StyleIconUrls.iconScreenShareStart),
            ),
          ),
        );
      },
    );
  }

  Future<void> onPressed() async {
    /// get current screen share state
    final valueNotifier = ZegoUIKit().getScreenSharingStateNotifier();

    final targetState = !valueNotifier.value;

    /// reverse current state
    if (targetState) {
      await ZegoUIKit().startSharingScreen();
    } else {
      await ZegoUIKit().stopSharingScreen();
    }

    if (widget.onPressed != null) {
      widget.onPressed!(targetState);
    }
  }
}
