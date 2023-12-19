import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

class CardInfoMomentReals extends StatelessWidget {
  final String like;
  final String comment;
  final String upload;
  const CardInfoMomentReals({super.key,required this.like,required this.comment,required this.upload});



  @override
  Widget build(BuildContext context) {
    Brightness currentBrightness = Theme.of(context).brightness;
    bool isDarkTheme = currentBrightness == Brightness.dark;
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
      ),
      child: Container(
        height: ConfigSize.defaultSize!*7,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(

          border: isDarkTheme ?Border.all(
            color: ColorManager.mainColor,
          ):null,
          borderRadius: BorderRadius.circular(10),

        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
                Text(like,style: Theme.of(context).textTheme.bodyMedium),
                Text(StringManager.like.tr(),style:  TextStyle(color: Colors.grey,fontSize: ConfigSize.defaultSize! +2),)
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(comment,style:Theme.of(context).textTheme.bodyMedium),
                Text(StringManager.comments.tr(),style:  TextStyle(color: Colors.grey,fontSize: ConfigSize.defaultSize! +2),)
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
                Text(upload,style: Theme.of(context).textTheme.bodyMedium),
                Text(StringManager.upload.tr(),style: TextStyle(color: Colors.grey,fontSize: ConfigSize.defaultSize! +2),)
              ],
            ),

          ],
        ),
      ),
    );
  }
}
