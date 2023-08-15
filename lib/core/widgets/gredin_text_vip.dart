
import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class GradientTextVip extends StatelessWidget {
  final bool isVip;
  final String text;
  final TextStyle textStyle;
  final TextAlign? textAlign ; 

  const GradientTextVip(
      {Key? key,
      required this.text,
      required this.textStyle,
      required this.isVip,
      this.textAlign
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return isVip
        ?  GradientText(
      text,
      style:textStyle,
      colors: const [Colors.blue, Colors.purple],
              textAlign: textAlign,

    ) :Text(
        text,
        style: textStyle,
        textAlign: textAlign,
    );
  }
}
