
import 'package:flutter/material.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

class GradientTextVip extends StatelessWidget {
  final bool isVip;
  final String text;
  final int? typeUser;
  final TextStyle textStyle;
  final TextAlign? textAlign ; 

  const GradientTextVip(
      {Key? key,
      required this.text,
      required this.textStyle,
        this.typeUser,
      required this.isVip,
      this.textAlign
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        isVip ?  GradientText(
          text,
          style:textStyle,
          colors: const [Colors.blue, Colors.purple],
                  textAlign: textAlign,overflow: TextOverflow.ellipsis,

        ) :Text(
            text,
            style: textStyle,
            textAlign: textAlign,overflow: TextOverflow.ellipsis,
        ),
        Padding(
          padding: const EdgeInsets.all(4),
          child: typeUser ==2? Image.asset(AssetsPath.agent,scale: ConfigSize.defaultSize!*2,):typeUser ==3?
          Image.asset(AssetsPath.shippingAgent,scale: ConfigSize.defaultSize!*2,):const SizedBox(),
        ),
      ],
    );
  }
}
