

 import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/widgets/show_svga.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/mall/widget/cashed_network_circle.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/room_screen_controler.dart';

class CustomAvtare extends StatelessWidget {
  final String image ;
  final double border ;
  final double size ;
  final  Color?  ColorBorder;
  final int? frameId ;
  final String? frame ;
  final void Function()? onPressed ;
  const CustomAvtare({ this.frame, this.frameId, this.onPressed ,this.ColorBorder,required this.image,this.border=0,required this.size, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return InkWell(
        onTap: onPressed,
        child: Stack(
          children: [
            CachedNetworkImgeCircular(hight: size,width: size,image: image,),
            frameId==null||frameId=='0'||frameId=='' ?
            const SizedBox():
            ShowSVGA(
              imageId:'$frameId$cacheFrameKey',url:frame??'' ,),

          ],
        )


    );
  }
}
