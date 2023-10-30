



import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';

import '../../../../../../../core/utils/config_size.dart';

class SystemMaasageCard extends StatelessWidget {
  final String img;
  final String title;
  final String content;
  final String creadet;
  const SystemMaasageCard(
      {required this.creadet,
      required this.title,
      required this.content,
      required this.img,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: [  
          SizedBox(width: ConfigSize.defaultSize!*4 , height:  ConfigSize.defaultSize!*4, child: const Image(image: AssetImage(AssetsPath.system))),
           Card(
            shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(ConfigSize.defaultSize!*2)),
            elevation: 10,
             child: Container(
              width: ConfigSize.screenWidth!-100,
              height: ConfigSize.defaultSize!*10,
              
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 185, 217, 243),
                // image: DecorationImage(image: AssetImage(AssetsPath.cardChat), fit: BoxFit.fill),
                  borderRadius: BorderRadius.circular(20),
                 ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // CachImageWidght(
                  //   url: ConstentApi().getImage(img),
                  //   height: ConfigSize.defaultSize! * 24,
                  //   width: double.maxFinite,
                  // ),
                               SizedBox(height: ConfigSize.defaultSize!,),
           
               Text(title.toString(),style: TextStyle(color: ColorManager.orang , fontSize: ConfigSize.defaultSize!*2 , fontWeight: FontWeight.bold ,),),
               
               SizedBox(height: ConfigSize.defaultSize!*2,),
                Text(content ,style: TextStyle(color: Colors.black , fontSize: ConfigSize.defaultSize!*1.5),)
                ],
              ),
                     ),
           ),],),
          Padding(
            padding:  EdgeInsets.only(left: ConfigSize.defaultSize!*7, top:ConfigSize.defaultSize! ),
            child: Text(creadet),
          )
        ],
      ),
    );
  }
}
