import 'package:flutter/cupertino.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/widgets/cached_network_image.dart';

import '../../../../../../../core/utils/config_size.dart';



class ChatWidget extends StatelessWidget {
  final String img;
  final String title;
  final String content;
  final String creadet;
  const ChatWidget(
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
          Container(
            width: ConfigSize.screenWidth,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                    color: ColorManager.lightGray,
                    width: 1 // red as border color
                    )),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustoumCachedImage(
                  url: img,
                  height: ConfigSize.defaultSize! * 24,
                  width: double.maxFinite,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [Text(title.toString()), Text(content)],
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(creadet),
          )
        ],
      ),
    );
  }
}
