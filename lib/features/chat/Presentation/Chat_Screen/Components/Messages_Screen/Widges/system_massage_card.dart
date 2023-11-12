



import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/utils/api_healper/methods.dart';
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
        Row(
          crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(width: ConfigSize.defaultSize!*4 , height:  ConfigSize.defaultSize!*4,
              child: const Image(image: AssetImage(AssetsPath.system))),
           Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(ConfigSize.defaultSize!*2),
            ),
            elevation: 10,
             child: Container(
              width: ConfigSize.screenWidth!*0.8,
              height: ConfigSize.defaultSize!*10,
              margin: EdgeInsets.all( ConfigSize.defaultSize!*0.5),
              decoration: BoxDecoration(
                color: ColorManager.gold1.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(ConfigSize.defaultSize!*2),
                 ),
              child: Row(

                children: [
                  SizedBox(width: ConfigSize.defaultSize!,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: ConfigSize.defaultSize!*0.5,),
                   SizedBox(
                     width: ConfigSize.screenWidth!*0.7,
                     child: Text(title.toString(),
                       style: TextStyle(color: ColorManager.orang , fontSize: ConfigSize.defaultSize!*1.4 ,
                         fontWeight: FontWeight.bold ,),
                     overflow:TextOverflow.fade ,),
                   ),

                   SizedBox(height: ConfigSize.defaultSize!*0.5,),
                    Text(content ,style: TextStyle(color: Colors.black , fontSize: ConfigSize.defaultSize!*1.5),)
                    ],
                  ),
                ],
              ),
                     ),
           ),],),
          Padding(
            padding:  EdgeInsets.only(left: ConfigSize.defaultSize!*7, top:ConfigSize.defaultSize! ),
            child:     Text(
              Methods.instance.formatDateTime(
                  dateTime: creadet,
                  locale: context.locale.languageCode),
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .copyWith(
                  fontSize: ConfigSize.defaultSize! ),
            ),
          )
        ],
      ),
    );
  }
}
