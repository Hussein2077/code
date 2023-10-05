import 'package:flutter/material.dart';
import 'package:tik_chat_v2/features/home/presentation/widget/body/aduio/audio_body.dart';
import 'package:tik_chat_v2/features/home/presentation/widget/body/video/video_body.dart';



class HomeBody extends StatelessWidget {
 final TabController liveController;
  const HomeBody({required this.liveController ,  super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TabBarView(
        
        controller: liveController,
        children:const [
          AduioBody(),
          VideoBody()

        ]),
    );
    
    
  
  }
}
