




import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';

import '../../../../../../../core/utils/config_size.dart';

class GroupChatAppbar extends StatelessWidget {
  const GroupChatAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ConfigSize.defaultSize! * 5,
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children:  [
       const Spacer(
          flex: 1,
        ),
         InkWell(
           onTap: (){
             Navigator.pop(context);
           },
           child: const Icon(
            Icons.arrow_back_ios,
        ),
         ),
        const  Spacer(
          flex:1,
        ),
       Text(StringManager.groupChat.tr(),style: TextStyle(color: Colors.black , fontSize: ConfigSize.defaultSize!*2 ,fontWeight: FontWeight.w600 )),
        const Spacer(
          flex: 20,
        ),
      
      ]),
    );
  }
}
