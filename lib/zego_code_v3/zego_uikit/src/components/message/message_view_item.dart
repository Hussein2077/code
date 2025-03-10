// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/components/audio_video/avatar/avatar.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/components/defines.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/components/internal/icon_defines.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/components/screen_util/screen_util.dart';
import 'package:tik_chat_v2/zego_code_v3/zego_uikit/src/services/services.dart';

/// @nodoc
typedef ZegoInRoomMessageViewItemPressEvent = void Function(
  ZegoInRoomMessage message,
);

/// @nodoc
class ZegoInRoomMessageViewItem extends StatefulWidget {
  const ZegoInRoomMessageViewItem({
    Key? key,
    required this.message,
    this.isHorizontal = true,
    this.showName = true,
    this.showAvatar = true,
    this.namePrefix,
    this.avatarBuilder,
    this.resendIcon,
    this.borderRadius,
    this.paddings,
    this.opacity,
    this.backgroundColor,
    this.maxLines,
    this.nameTextStyle,
    this.messageTextStyle,
    this.onItemClick,
    this.onItemLongPress,
  }) : super(key: key);

  final String? namePrefix;
  final ZegoInRoomMessage message;
  final bool isHorizontal;

  /// Triggered when has click on the message item
  final ZegoInRoomMessageViewItemPressEvent? onItemClick;

  /// Triggered when a pointer has remained in contact with the message item at
  /// the same location for a long period of time.
  final ZegoInRoomMessageViewItemPressEvent? onItemLongPress;

  /// display user name in message list view or not
  final bool showName;

  /// display user avatar in message list view or not
  final bool showAvatar;

  /// display user avatar in message list view or not
  final ZegoAvatarBuilder? avatarBuilder;

  /// resend button icon
  final Widget? resendIcon;

  /// The border radius of chat message list items
  final BorderRadiusGeometry? borderRadius;

  /// The paddings of chat message list items
  final EdgeInsetsGeometry? paddings;

  /// The opacity of the background color for chat message list items, default value of 0.5.
  /// If you set the [backgroundColor], the [opacity] setting will be overridden.
  final double? opacity;

  /// The background of chat message list items
  /// If you set the [backgroundColor], the [opacity] setting will be overridden.
  /// You can use `backgroundColor.withOpacity(0.5)` to set the opacity of the background color.
  final Color? backgroundColor;

  /// The max lines of chat message list items, default value is not limit.
  final int? maxLines;

  /// The name text style of chat message list items
  final TextStyle? nameTextStyle;

  /// The message text style of chat message list items
  final TextStyle? messageTextStyle;

  @override
  State<ZegoInRoomMessageViewItem> createState() =>
      _ZegoInRoomLiveMessageViewItemState();
}

/// @nodoc
class _ZegoInRoomLiveMessageViewItemState
    extends State<ZegoInRoomMessageViewItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onItemClick?.call(widget.message);
      },
      onLongPress: () {
        widget.onItemLongPress?.call(widget.message);
      },
      child: item(),
    );
  }

  Widget item() {
    final defaultBackgroundColor =
        const Color(0xff2a2a2a).withOpacity(widget.opacity ?? 0.5);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          color: widget.backgroundColor ?? defaultBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius:
                widget.borderRadius ?? BorderRadius.all(Radius.circular(26.zR)),
          ),
          child: Padding(
            padding: widget.paddings ??
                EdgeInsets.fromLTRB(20.zR, 10.zR, 20.zR, 10.zR),
            child: Stack(
              children: [
            //    message(),
                Positioned(
                  top: 1.zR,
                  right: 1.zR,
                  child: state(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget message() {
    const defaultMessageNameColor = Color(0xffFFB763);

    final padding =
        widget.paddings ?? EdgeInsets.fromLTRB(20.zR, 10.zR, 20.zR, 10.zR);
    return RichText(
      maxLines: widget.maxLines,
      overflow:
          null == widget.maxLines ? TextOverflow.clip : TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          ...widget.showAvatar
              ? [
                  WidgetSpan(
                    child: SizedBox(
                      width: 26.zR + padding.vertical / 2 - 1,
                      height: 26.zR + padding.vertical / 2 - 1,
                      child: ZegoAvatar(
                        user: widget.message.user,
                        avatarSize: Size(30.zR, 30.zR),
                        avatarBuilder: widget.avatarBuilder,
                      ),
                    ),
                  ),
                  WidgetSpan(child: SizedBox(width: 1.zR))
                ]
              : [],
          ...widget.showName
              ? [
                  if (widget.namePrefix != null) prefix(),
                  TextSpan(
                    text: widget.message.user.name,
                    style: widget.nameTextStyle ??
                        TextStyle(
                          fontSize: 26.zR,
                          fontWeight: FontWeight.w500,
                          color: defaultMessageNameColor,
                        ),
                  ),
                  WidgetSpan(child: SizedBox(width: 10.zR)),
                ]
              : [],
          TextSpan(
            text: widget.isHorizontal
                ? widget.message.message
                : '\n${widget.message.message}',
            style: widget.messageTextStyle ??
                TextStyle(
                  fontSize: 26.zR,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
          ),
        ],
      ),
    );
  }

  TextSpan prefix() {
    const messageHostColor = Color(0xff9f76ff);

    return TextSpan(
      children: [
        WidgetSpan(
          child: Transform.translate(
            offset: Offset(0, 0.zR),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 34.zR + widget.namePrefix!.length * 12.zR,
                minWidth: 34.zR,
                minHeight: 36.zR,
                maxHeight: 36.zR,
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: messageHostColor,
                  borderRadius: BorderRadius.all(Radius.circular(20.zR)),
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(12.zR, 4.zR, 12.zR, 4.zR),
                  child: Center(
                    child: Text(
                      widget.namePrefix!,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.zR,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        WidgetSpan(child: SizedBox(width: 10.zR)),
      ],
    );
  }

  Widget state() {
    if (ZegoInRoomMessageState.idle == widget.message.state.value ||
        ZegoInRoomMessageState.success == widget.message.state.value) {
      return const SizedBox(width: 0, height: 0);
    }

    return ValueListenableBuilder<ZegoInRoomMessageState>(
      valueListenable: widget.message.state,
      builder: (context, state, _) {
        if (ZegoInRoomMessageState.idle == state ||
            ZegoInRoomMessageState.success == state) {
          return const SizedBox(width: 0, height: 0);
        }

        var imageUrl = '';
        switch (state) {
          case ZegoInRoomMessageState.sending:
            imageUrl = StyleIconUrls.messageLoading;
            break;
          case ZegoInRoomMessageState.failed:
            imageUrl = StyleIconUrls.messageFail;
            break;
          default:
            break;
        }

        return GestureDetector(
          onTap: () {
            if (state == ZegoInRoomMessageState.failed) {
              ZegoUIKit().resendInRoomMessage(widget.message);
            }
          },
          child: null != widget.resendIcon
              ? SizedBox(
                  width: 30.zR,
                  height: 30.zR,
                  child: widget.resendIcon,
                )
              : Container(
                  width: 30.zR,
                  height: 30.zR,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: UIKitImage.asset(imageUrl).image,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
        );
      },
    );
  }
}
