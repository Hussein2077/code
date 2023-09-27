import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/moment/presentation/componants/giftbox/widgets/moment_gift_view.dart';
import 'package:tik_chat_v2/features/moment/presentation/componants/giftbox/widgets/moment_giftbox_bottom_bar.dart';


class MomentGiftboxScreen extends StatelessWidget{
  const MomentGiftboxScreen({

    super.key});

  @override
  Widget build(BuildContext context) {
   return Container(
     color: Theme.of(context).colorScheme.background,
     height: ConfigSize.defaultSize!*45,
     child: Column(
     children:  [
       SizedBox(height: ConfigSize.defaultSize!,),
       Row(
         children: [
           const Spacer(flex: 1,),
           IconButton(
             icon: Icon(
               Icons.arrow_back_ios,
               color: Theme.of(context).colorScheme.secondary,
             ),
             onPressed:
                     () {
                   Navigator.pop(context);
                 },
           ),
           const Spacer(flex: 4,),

           Text(StringManager.giftBox.tr(),
           style: Theme.of(context).textTheme.headlineMedium,
           ),
           const Spacer(flex: 5,),

         ],
       ),

       const MomentGiftView(),
       const MomentGiftboxBottomBar(),
     ],
   ),
   );
  }


}