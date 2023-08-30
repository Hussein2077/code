import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/tik_tok_animition.dart';



class DialogLoadingWidget extends StatelessWidget {
  const DialogLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: ConfigSize.defaultSize!*6,
        height: ConfigSize.defaultSize!*6,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical:ConfigSize.defaultSize!*2, ),
          child: const  TikTokLoadingAnimation(),
        ),
      ),
    );
  }
}
