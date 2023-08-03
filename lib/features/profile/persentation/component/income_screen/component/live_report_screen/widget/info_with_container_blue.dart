import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

class LiveTodayCard extends StatelessWidget {
  final Widget widget;
  final String title;
  const LiveTodayCard({super.key,required this.widget,required this.title});

  @override
  Widget build(BuildContext context) {
    Brightness currentBrightness = Theme.of(context).brightness;
    bool isDarkTheme = currentBrightness == Brightness.dark;
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(10)),
      elevation: 10,
      child: Container(
        decoration: BoxDecoration(
          border: isDarkTheme?Border.all(
            style: BorderStyle.solid,
            color: ColorManager.mainColor,
          ):null,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.symmetric(
            vertical: ConfigSize.defaultSize! * 1,
            horizontal:
            ConfigSize.defaultSize! * 1.5),
        child: Column(
          mainAxisAlignment:
          MainAxisAlignment.center,
          children: [
            widget,
            SizedBox(
              height:
              ConfigSize.defaultSize! * 0.4,
            ),
            Text(
              title,
              style: const TextStyle(
                  color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}