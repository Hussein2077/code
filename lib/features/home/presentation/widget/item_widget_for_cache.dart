import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

class ItemWidget extends StatelessWidget {
  const ItemWidget({
    super.key,
    required this.text,
    required this.iconData,
  });

  final String text;
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width:ConfigSize.defaultSize! * 7 ,
          child: Text(
            text,
            style: TextStyle(
              fontSize: ConfigSize.defaultSize! * 1,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
            overflow: TextOverflow.fade,
          ),
        ),
        Icon(
          iconData,
          size: ConfigSize.defaultSize!*1.6,
          color: ColorManager.orange,
        )
      ],
    );
  }
}
