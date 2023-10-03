import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';


class CustomTabBar extends StatelessWidget {
  final double? width ;
  final int tabIndex;
  const CustomTabBar({this.width,  Key? key, required this.titels, required this.controller,required this.tabIndex})
      : super(key: key);
  final List<String> titels;
  final TabController controller;
  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: controller,
      padding: EdgeInsets.symmetric(
        vertical: ConfigSize.defaultSize!-5
      ),
      indicator: const BoxDecoration(),
      labelColor: Colors.white,
      labelStyle: TextStyle(
        fontFamily:'BalooBhaijaan2' ,
        fontSize: ConfigSize.defaultSize! * 1.4,
        overflow: TextOverflow.ellipsis,
      ),
      unselectedLabelColor: Colors.black,

      tabs: [
        for (int i = 0; i < titels.length; i++)
          Tab(
            child:customContainer(
                text: titels[i],
                isSelected: tabIndex == i
            ),
          ),
      ],
    );
  }
  Widget customContainer({required String text,required bool isSelected}){
    return Container(
      alignment: Alignment.center,
      width: ConfigSize.defaultSize! * 15.7,
      decoration: BoxDecoration(
        color: isSelected ? ColorManager.orang :  Colors.white,
        borderRadius: BorderRadius.circular(
          25.0,
        ),
      ),
      child: Text(text),
    );

  }
}