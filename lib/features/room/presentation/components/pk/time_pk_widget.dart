
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/features/room/presentation/Room_Screen.dart';

//todo hana 
class TimePKWidget extends StatefulWidget {
  const TimePKWidget({Key? key}) : super(key: key);

  @override
  TimePKWidgetState createState() => TimePKWidgetState();
}

class TimePKWidgetState extends State<TimePKWidget> {
  @override
  Widget build(BuildContext context) {
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
                  ? ColorManager.mainColor
                  : ColorManager.lightGray,
            ),
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
            child: Text(
              "5 min",
              style: TextStyle(
                  color: RoomScreen.timeMinutePK == 5
                      ? Colors.white
                      : ColorManager.lightGray,
                  fontSize: 14,
                  fontWeight: FontWeight.w700),
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
                  ? ColorManager.mainColor
                  : ColorManager.lightGray,
            ),
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
            child: Text(
              "15 min",
              style: TextStyle(
                  color: RoomScreen.timeMinutePK == 15
                      ? Colors.white
                      : ColorManager.lightGray,
                  fontSize: 14,
                  fontWeight: FontWeight.w700),
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
              borderRadius: BorderRadius.circular(4),
              color: RoomScreen.timeMinutePK == 30
                  ? ColorManager.mainColor
                  : ColorManager.lightGray,
            ),
            padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
            child: Text(
              "30 min",
              style: TextStyle(
                  color: RoomScreen.timeMinutePK == 30
                      ? Colors.white
                      : ColorManager.lightGray,
                  fontSize: 14,
                  fontWeight: FontWeight.w700),
            ),
          ),
        )
      ],
    );
  }
}
