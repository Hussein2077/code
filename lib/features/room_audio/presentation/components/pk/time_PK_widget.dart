import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/pk/pk_functions.dart';


class TimePKWidget extends StatefulWidget {
  const TimePKWidget({Key? key}) : super(key: key);

  @override
  _TimePKWidgetState createState() => _TimePKWidgetState();
}

class _TimePKWidgetState extends State<TimePKWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              PkController.timeMinutePK = 5;
            });
          },
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: PkController.timeMinutePK == 5
                    ? ColorManager.yellow
                    : ColorManager.whiteColor,
              ),
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
              child: Text(
                "5 min",
                style: TextStyle(
                    color: PkController.timeMinutePK == 5
                        ? Colors.black
                        : ColorManager.darkBlack,
                    fontSize: 14,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              PkController.timeMinutePK = 15;
            });
          },
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: PkController.timeMinutePK == 15
                    ? ColorManager.yellow
                    : ColorManager.whiteColor,
              ),
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
              child: Text(
                "15 min",
                style: TextStyle(
                    color: PkController.timeMinutePK == 15
                        ? Colors.black
                        : ColorManager.darkBlack,
                    fontSize: 14,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {
            setState(() {
              PkController.timeMinutePK = 30;
            });
          },
          child: Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
            ),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: PkController.timeMinutePK == 30
                    ? ColorManager.yellow
                    : ColorManager.whiteColor,
              ),
              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
              child: Text(
                "30 min",
                style: TextStyle(
                    color: PkController.timeMinutePK == 30
                        ? Colors.black
                        : ColorManager.darkBlack,
                    fontSize: 14,
                    fontWeight: FontWeight.w700),
              ),
            ),
          ),
        )
      ],
    );
  }
}
