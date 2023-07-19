

import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/utils/config_sizee.dart';
import 'package:tik_chat_v2/features/home/presentation/widget/body/aduio/audio_live_row.dart';
import 'package:tik_chat_v2/features/home/presentation/widget/body/country_icon.dart';
import 'package:tik_chat_v2/features/home/presentation/widget/body/page_view.dart';

class AduioBody extends StatelessWidget {
  
  const AduioBody({super.key});

  @override
  Widget build(BuildContext context) {
    return    Container(

      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(
    top: ConfigSize.defaultSize! * 2,
      ),
      decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.background,
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(ConfigSize.defaultSize! * 4),
          topLeft: Radius.circular(ConfigSize.defaultSize! * 4))),
      child: SingleChildScrollView(
      child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const PageViewWidget(),
      const CountryIcon(),
      ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 10,
          itemBuilder: (context, index) {
            int style = 0 ; 
            if(index==0 || index==1 ||index==2){
              style = index ; 
            }else {
              style = index % 3 ;
            }
        return  AduioLiveRow(style: style,);
          })
    ],
      )),
    );
  }
}