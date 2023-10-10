import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

import 'tik_tok_animition.dart';


class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
              height: MediaQuery.of(context).size.height*.7,
              width: MediaQuery.of(context).size.width,

              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                   Padding(
                    padding:  EdgeInsets.symmetric(horizontal: ConfigSize.defaultSize!*18.0),
                    child: SizedBox(
                      height: ConfigSize.defaultSize!*3,

                        child: const TikTokLoadingAnimation()),
                  ),
        

                ],
              ),
            );
  }
}