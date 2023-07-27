import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

import 'tik_tok_animition.dart';


class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
              
              ),
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
                   SizedBox(
                    height: ConfigSize.defaultSize!*1.5,
                  ),
                  Text(StringManager.loading,style:Theme.of(context).textTheme.headlineLarge )

                ],
              ),
            );
  }
}