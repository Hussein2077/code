import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

class SelectionWidget extends StatelessWidget {
  List<String> chooises;
  int index;
  bool selected;
  SelectionWidget({super.key, required this.chooises, required this.index, required this.selected});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        selected ? Image.asset(AssetsPath.luckyDrawGameArrow) : const SizedBox(width: 35,),
        if(selected) const SizedBox(width: 10,),
        Container(
          width: ConfigSize.screenWidth! * .7,
          decoration: BoxDecoration(
            color: selected ? const Color.fromRGBO(233, 118, 0, 1.0) : const Color.fromRGBO(246, 140, 140, 1),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Text(chooises[index], style: TextStyle(color: const Color.fromRGBO(149, 72, 72, 1), fontSize: ConfigSize.defaultSize! * 2),),
          ),
        ),
      ],
    );
  }
}
