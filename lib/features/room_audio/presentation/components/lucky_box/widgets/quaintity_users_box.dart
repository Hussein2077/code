import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/values_manger.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/box_lucky_model.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/lucky_box/lucky_box_controller.dart';

class QuaintityUsersBox extends StatefulWidget {
  final List<TypeBox> boxes ;

  const QuaintityUsersBox({required this.boxes,  Key? key}) : super(key: key);

  @override
  QuaintityUsersBoxState createState() => QuaintityUsersBoxState();
}

class QuaintityUsersBoxState extends State<QuaintityUsersBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ConfigSize.defaultSize! * 33,
      height: AppPadding.p45,
      decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(AppPadding.p20),
          border: Border.all(color: Colors.white)),
      child:
      Row(
        children: [
          Expanded(
              flex: 1,
              child:  InkWell(
                onTap: (){
                setState(() {
                  LuckyBoxVariables.luckyBoxMap['quantity'] = '25' ;
                });
              },child: Container(

                decoration: BoxDecoration(
                  color: LuckyBoxVariables.luckyBoxMap['quantity'] == '25' ? Colors.white :Colors.transparent,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(AppPadding.p17),
                      bottomLeft: Radius.circular(AppPadding.p17)),
                ),
                child: Center (
                  child: Text(
                    "25",
                    style: TextStyle(
                        color:LuckyBoxVariables.luckyBoxMap['quantity'] == '25' ? ColorManager.mainColor :Colors.white  ,
                        fontWeight: FontWeight.w700,
                        fontSize: AppPadding.p16),
                  ),
                ),
              ),)),
          Expanded(
              flex: 1,
              child: InkWell(onTap: (){
                setState(() {
                  LuckyBoxVariables.luckyBoxMap['quantity'] = '50';
                });},child: Container(
                decoration:   BoxDecoration(
                  color:LuckyBoxVariables.luckyBoxMap['quantity'] == '50' ? Colors.white :Colors.transparent,
                ),
                child: Center(
                  child: Text(
                    "50",
                    style: TextStyle(
                        color:LuckyBoxVariables.luckyBoxMap['quantity'] == '50' ?  ColorManager.mainColor:Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: AppPadding.p16),
                  ),
                ),
              ),)),
          Expanded(
              flex: 1,
              child: InkWell(onTap: (){
                setState(() {
                  LuckyBoxVariables.luckyBoxMap['quantity'] = '75';
                });},child: Container(
                color:LuckyBoxVariables.luckyBoxMap['quantity'] == '75' ? Colors.white : Colors.transparent,
                child: Center(
                  child: Text(
                    "75",
                    style: TextStyle(
                        color:LuckyBoxVariables.luckyBoxMap['quantity'] == '75' ? ColorManager.mainColor: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: AppPadding.p16),
                  ),
                ),
              ),)),
          Expanded(
              flex: 1,
              child: InkWell(onTap: (){
                setState(() {
                  LuckyBoxVariables.luckyBoxMap['quantity'] = '100' ;
                });},child: Container(
                  decoration: BoxDecoration(
                    color:LuckyBoxVariables.luckyBoxMap['quantity'] == '100'?  Colors.white:Colors.transparent,
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(AppPadding.p17),
                        bottomRight: Radius.circular(AppPadding.p17)),
                  ),
                  child: Center(
                    child: Text(
                      "100",
                      style: TextStyle(
                          color:LuckyBoxVariables.luckyBoxMap['quantity'] == '100'?  ColorManager.mainColor : Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: AppPadding.p16),
                    ),
                  )),))
        ],
      )
    );
  }
}
