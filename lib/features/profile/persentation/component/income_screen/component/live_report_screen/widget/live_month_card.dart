import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

class CardInfoMonthOrAllInfo extends StatelessWidget {
  final String infoDay;
  final String infoHours;
  final String infoDiamond;
  const CardInfoMonthOrAllInfo({super.key,required this.infoDay,required this.infoHours,required this.infoDiamond});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10)
      ),
      child: Container(
        height: ConfigSize.defaultSize!*7,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.white,
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
                 Text(infoDay,style:  const TextStyle(color: Colors.black)),
                Text(StringManager.day.tr(),style:  TextStyle(color: Colors.grey,fontSize: ConfigSize.defaultSize! +2),)
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                 Text(infoHours,style: const TextStyle(color: Colors.black)),
                Text(StringManager.hours.tr(),style:  TextStyle(color: Colors.grey,fontSize: ConfigSize.defaultSize! +2),)
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
                 Text(infoDiamond,style: const TextStyle(color: Colors.black)),
                Text(StringManager.diamond.tr(),style: TextStyle(color: Colors.grey,fontSize: ConfigSize.defaultSize! +2),)
              ],
            ),

          ],
        ),
      ),
    );
  }
}
