import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

class InfoWithWidget extends StatelessWidget {
 final String title;
  const InfoWithWidget({super.key,required this.title});

  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: ConfigSize.defaultSize !-5,
          height: 15,
          color: Colors.blue,
        ),
        SizedBox(width: ConfigSize.defaultSize),

        Text(title,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey[500],fontSize: ConfigSize.defaultSize! +5)),

      ],
    );
  }
}
