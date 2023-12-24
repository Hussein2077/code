import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

class BreakMomentReals extends StatelessWidget {
  final String title;
  const BreakMomentReals({super.key,required this.title});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding:  EdgeInsets.only(
        top: ConfigSize.defaultSize!,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(Icons.arrow_right,size: ConfigSize.defaultSize!*2.7,color: Colors.grey[500],),
          SizedBox(width: ConfigSize.defaultSize),
          Text(title,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey[500],fontSize: ConfigSize.defaultSize! +4)),

        ],
      ),
    );
  }
}
