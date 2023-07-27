import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/home/presentation/widget/body/room_type_widget.dart';
import 'package:tik_chat_v2/features/home/presentation/widget/num_of_vistor.dart';

class AduioLiveRow extends StatelessWidget {
  final int style;
  const AduioLiveRow({required this.style, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
            child: Container(
          decoration: BoxDecoration(
              image: style == 0
                  ? const DecorationImage(
                      image: AssetImage(AssetsPath.blueBackGround))
                  : style == 1
                      ? const DecorationImage(
                          image: AssetImage(AssetsPath.yellowBackGround))
                      : const DecorationImage(
                          image: AssetImage(AssetsPath.pinkBackGround)),
              borderRadius: BorderRadius.circular(ConfigSize.defaultSize! * 2)),
          margin:
              EdgeInsets.only(bottom: 20, left: ConfigSize.defaultSize! * 2.5),
          width: MediaQuery.of(context).size.width - 90,
          height: ConfigSize.defaultSize!*10,
        )),
        Row(
          children: [
            Container(
              margin: EdgeInsets.only(
                  left: ConfigSize.defaultSize! * 2.3,
                  top: ConfigSize.defaultSize! * 1.2),
              width: ConfigSize.defaultSize!*8.6,
              height: ConfigSize.defaultSize!*7.6,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: style == 0
                            ? ColorManager.blue.withOpacity(0.6)
                            : style == 1
                                ? ColorManager.orang.withOpacity(0.6)
                                : ColorManager.pink.withOpacity(0.6),
                        spreadRadius: 1,
                        blurRadius: 20),
                  ],
                  image: const DecorationImage(image: AssetImage(AssetsPath.splashBackGround , ) , fit: BoxFit.fill),
                  borderRadius:
                      BorderRadius.circular(ConfigSize.defaultSize! * 2)),
              child: const Align(
                  alignment: Alignment.bottomLeft,
                  child: NumVistor()),
            ),
            SizedBox(
              width: ConfigSize.defaultSize,
            ),
            Column(
              children: [
                Text(
                  'اسمي الحمودي',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: ConfigSize.defaultSize! * 1.8),
                ),
                Text(
                  'اسمي الحمودي',
                  style: TextStyle(
                      color: Colors.black.withOpacity(0.5),
                      fontSize: ConfigSize.defaultSize! * 1.2),
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                 RoomTypeWidget(style: style,),
                    SizedBox(
                      width: ConfigSize.defaultSize,
                    ),
                    Image.asset(
                      AssetsPath.globalIcon,
                      scale: 2,
                    ),
                  ],
                )
              ],
            ),
          ],
        )
      ],
    );
  }
}
