import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/values_manger.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';



class ErrorLuckWidget extends StatelessWidget {
  final  bool  isNotLucky ;
  const ErrorLuckWidget({ required this.isNotLucky, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ConfigSize.defaultSize!*30,
      width: ConfigSize.defaultSize!*10,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppPadding.p20),
          gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF4EF54E),
                Color(0xFF00FFB9),
              ])
      ),
      child:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width:   ConfigSize.defaultSize!*15,
            height:  ConfigSize.defaultSize!*14,
            decoration: const  BoxDecoration(
              shape: BoxShape.circle,
            ),
            child: Image.asset(AssetsPath.badLucky,scale: 1.8,),
          )
 ,
          SizedBox(
            height: ConfigSize.defaultSize!*3,
          ),
          Text(isNotLucky ? StringManager.hardLuck.tr():StringManager.youCantTakeMoreOne.tr(),
            style: TextStyle(color: Colors.white,fontSize: AppPadding.p14,fontStyle: FontStyle.italic),)
        ],
      )
    );
  }
}
