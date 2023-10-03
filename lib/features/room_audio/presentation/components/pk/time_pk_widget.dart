
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/Room_Screen.dart';

//todo hana
class TimePKWidget extends StatefulWidget {
  const TimePKWidget({Key? key}) : super(key: key);

  @override
  TimePKWidgetState createState() => TimePKWidgetState();
}

class TimePKWidgetState extends State<TimePKWidget> {
  @override
  Widget build(BuildContext context) {
    Brightness currentBrightness = Theme.of(context).brightness;
    bool isDarkTheme = currentBrightness == Brightness.dark;
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () {
              setState(() {
                RoomScreen.timeMinutePK = 5;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: RoomScreen.timeMinutePK == 5
                    ?
    ColorManager.mainColor
                    : ColorManager.lightGray.withOpacity(0.8),
              ),
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
              child: Text(
                StringManager.fiveMin.tr(),
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                RoomScreen.timeMinutePK = 15;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: RoomScreen.timeMinutePK == 15
                    ?ColorManager.orang
                    : ColorManager.lightGray.withOpacity(0.8),
              ),
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
              child: Text(
                StringManager.fiftyMin.tr(),
                style:   Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
          InkWell(
            onTap: () {
              setState(() {
                RoomScreen.timeMinutePK = 30;
              });
            },
            child: Container(
              decoration: BoxDecoration(
              //  color: Theme.of(context).colorScheme.background,

                borderRadius: BorderRadius.circular(4),
                color: RoomScreen.timeMinutePK == 30
                    ? ColorManager.gold
                    : ColorManager.lightGray.withOpacity(0.8),

                //Theme.of(context).colorScheme.background,

                //ColorManager.lightGray,
              ),
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
              child: Text(
               StringManager.thirtyMin.tr(),
                style:    Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          )
        ],
      );
  }
}
