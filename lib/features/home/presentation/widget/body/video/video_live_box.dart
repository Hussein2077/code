import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resours_manger/asset_path.dart';
import 'package:tik_chat_v2/core/utils/config_sizee.dart';
import 'package:tik_chat_v2/features/home/presentation/widget/body/room_type_widget.dart';

import '../../num_of_vistor.dart';

class VideoLiveBox extends StatelessWidget {
  final int style;
  const VideoLiveBox({required this.style, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
            width: ConfigSize.defaultSize! * 18,
            height: ConfigSize.defaultSize! * 14,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(ConfigSize.defaultSize! * 2),
              image: const DecorationImage(
                  image: AssetImage(AssetsPath.splashBackGround),
                  fit: BoxFit.fill),
            ),
            child: Column(
              children: [
                SizedBox(
                  height: ConfigSize.defaultSize,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: ConfigSize.defaultSize!,
                    ),
                    Image.asset(
                      AssetsPath.globalIcon,
                      scale: 2,
                    ),
                    SizedBox(
                      width: ConfigSize.defaultSize!,
                    ),
                    RoomTypeWidget(
                      style: style,
                    ),
                    SizedBox(
                      width: ConfigSize.defaultSize,
                    ),
                  ],
                ),
                Padding(
                    padding: EdgeInsets.only(
                        top: ConfigSize.defaultSize! * 6,
                        left: ConfigSize.defaultSize! * 12),
                    child: const NumVistor())
              ],
            )),
        Text(
          "غرفة الحمود واصحابة",
          style: Theme.of(context).textTheme.bodyLarge,
        ),
        Text(
          " غرفة الحمود واصحابة",
          style: Theme.of(context).textTheme.titleSmall,
        )
      ],
    );
  }
}
