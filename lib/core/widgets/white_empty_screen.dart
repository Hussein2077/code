import 'package:flutter/material.dart';
import 'package:tik_chat_v2/features/home/presentation/component/create_live/reels/component/upload_reels/widgets/upload_video.dart';

class WhiteEmptyScreen extends StatelessWidget {


  const WhiteEmptyScreen({
    Key? key,

  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(child: Center(child: UploadVideo(),),),
    );
  }



}