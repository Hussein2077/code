import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'dart:ui' as ui;
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
class ExpandableText extends StatefulWidget {


  final String text;
  final int trimLines;
  final TextStyle? style;
  final VoidCallback? onTap;


  const ExpandableText(
      this.text, {
        Key? key,
        this.trimLines = 2,
        this.style,
        this.onTap,

      })  : super(key: key);



  @override
  ExpandableTextState createState() => ExpandableTextState();
}

class ExpandableTextState extends State<ExpandableText> {
  bool _readMore = true;
  void _onTapLink() {
    setState(() => _readMore = !_readMore);
  }

  @override
  Widget build(BuildContext context) {
    TextSpan link = TextSpan(
        //text: _readMore ? 'read more': 'read less',
        text: _readMore ? StringManager.readMore.tr() : StringManager.readLess.tr(),
        style: const TextStyle(
          color: ColorManager.mainColor,
        ),
      recognizer: TapGestureRecognizer()..onTap = widget.onTap ?? _onTapLink,

    );
    Widget result = LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        assert(constraints.hasBoundedWidth);
        final double maxWidth = constraints.maxWidth;
        // Create a TextSpan with data
        final text = TextSpan(
          text: widget.text,
        );
        // Layout and measure link
        TextPainter textPainter = TextPainter(
          text: link,
          textDirection: ui.TextDirection.ltr, // or TextDirection.rtl, as needed
          maxLines: widget.trimLines,
          ellipsis: '...',
        );
        textPainter.layout(minWidth: constraints.minWidth, maxWidth: maxWidth);
        final linkSize = textPainter.size;
        // Layout and measure text
        textPainter.text = text;
        textPainter.layout(minWidth: constraints.minWidth, maxWidth: maxWidth);
        final textSize = textPainter.size;
        // Get the endIndex of data
        int? endIndex;
        final pos = textPainter.getPositionForOffset(Offset(
          textSize.width - linkSize.width,
          textSize.height,
        ));
        endIndex = textPainter.getOffsetBefore(pos.offset);
        TextSpan textSpan;
        if (textPainter.didExceedMaxLines) {
          textSpan = TextSpan(

            text: _readMore
                ? widget.text.substring(0, endIndex)
                : widget.text,
            style: widget.style ??Theme.of(context).textTheme.bodyMedium,

            children: <TextSpan>[link],
          );
        } else {
          textSpan = TextSpan(
            text: widget.text,
            style: widget.style ??Theme.of(context).textTheme.bodyMedium,

          );
        }
        return RichText(
          softWrap: true,
          overflow: TextOverflow.clip,
          text: textSpan,
        );
      },
    );
    return result;
  }
}