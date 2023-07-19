

import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resours_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resours_manger/string_manger.dart';
import 'package:tik_chat_v2/core/utils/config_sizee.dart';
import 'package:tik_chat_v2/features/auth/presentation/widgets/custom_horizental_dvider.dart';

class ChooseTopicDailog extends StatelessWidget {
  const ChooseTopicDailog({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2,
      child: Scaffold(
        body: Column(children: [
          SizedBox(height: ConfigSize.defaultSize!*2,),
          Text(StringManager.chooseTheTopic , style: Theme.of(context).textTheme.headlineMedium,),
          CustomHorizntalDvider(width: ConfigSize.defaultSize!*4 , color: ColorManager.orang,),

          Expanded(
            child: ListView.builder(
              itemExtent: 50 ,
              itemCount: 10,
              itemBuilder: (context, index) {
                return topicRow(context: context , title:"نعنشه" );
              }),
          ),
        ],)
      ),
    );
  }
}


Widget topicRow ({
  required BuildContext context , 
   required String title 
}){
  return Row(
      children: [
        const Spacer(
          flex: 1,
        ),
       
        Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        const Spacer(
          flex: 15,
        ),
        Icon(
          Icons.arrow_forward_ios,
          color: Theme.of(context).colorScheme.primary,
          size: ConfigSize.defaultSize! * 1.6,
        ),
        const Spacer(
          flex: 1,
        ),
      ],
    );
}