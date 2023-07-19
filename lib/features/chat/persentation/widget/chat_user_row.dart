import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resours_manger/asset_path.dart';
import 'package:tik_chat_v2/core/utils/config_sizee.dart';

class ChatUserRow extends StatelessWidget {
  const ChatUserRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(
          flex: 1,
        ),

        Stack(children: [
            Container(
          width: ConfigSize.defaultSize! * 5,
          height: ConfigSize.defaultSize! * 5,
          decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                  image: AssetImage(AssetsPath.testImage), fit: BoxFit.fill)),
        
        ),
          Container(
            margin: EdgeInsets.only(left: ConfigSize.defaultSize!*4),
           padding: const EdgeInsets.all(5),
            decoration:
                const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
            child: Text(
              "1",
              style: TextStyle(
                  color: Colors.white, fontSize: ConfigSize.defaultSize!),
            ),
          ),
        ],),
      
        const Spacer(
          flex: 1,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "حمودي ابن المحافظ",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            Text(
              "بحبك",
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        const Spacer(
          flex: 20,
        ),
        Text(
          "7:44 pm",
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const Spacer(
          flex: 1,
        ),
      ],
    );
  }
}
