


import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/home/presentation/home_screen.dart';

class GroupChatCounterWidget extends StatelessWidget {

  const GroupChatCounterWidget(
      {Key? key,

      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   ValueListenableBuilder<int>(
        valueListenable: HomeScreen.groupChatCounter,
        builder: (context, show, _) {
          return
            Container(
              padding: const EdgeInsets.all(4),
              decoration:  BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red.shade900),
              child: Text(
                HomeScreen.groupChatCounter.value == 0 ? "  " :
                '${HomeScreen.groupChatCounter.value}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: ConfigSize.defaultSize! + 2,
                ),
                textAlign: TextAlign.center,
              ),
            );

        }
    ) ;
  }
}
