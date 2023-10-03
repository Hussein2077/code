



import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/values_manger.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/room_audio/data/model/box_lucky_model.dart';
import '../lucky_box.dart';

class CoinsLuckyBox extends StatefulWidget {
  final List<TypeBox> boxes ;
  final void Function()  refresh;
  static int coinsSelectedBox = 666 ;
  const CoinsLuckyBox({required this.boxes, required this.refresh, Key? key}) : super(key: key);

  @override
  CoinsLuckyBoxState createState() => CoinsLuckyBoxState();
}

class CoinsLuckyBoxState extends State<CoinsLuckyBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ConfigSize.defaultSize! * 33,
      height: AppPadding.p45,
      decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(AppPadding.p20),
          border: Border.all(color: Colors.white)),
      child:  Row(
        children: [
          for(int i =0; widget.boxes.length > 4? i< 4 : i< widget.boxes.length ;   i++)
            i==0 ? Expanded(
              flex: 1,
              child: InkWell(
                onTap: (){
                  setState(() {
                    LuckyBox.coins = widget.boxes[i].coins.toString() ;
                    LuckyBox.currentBox = i+1 ;
                    widget.refresh();

                  });
                },
                child: Container(
                  decoration: BoxDecoration(
                    color:  LuckyBox.coins ==widget.boxes[i].coins.toString()?  Colors.white:  Colors.transparent,
                    borderRadius:  widget.boxes.length == 1 ? BorderRadius.circular(AppPadding.p17)  :  BorderRadius.only(
                        topLeft: Radius.circular(AppPadding.p17),
                        bottomLeft: Radius.circular(AppPadding.p17)),
                  ),
                  child: Center(
                    child: Text(
                      "${widget.boxes[i].coins}",
                      style: TextStyle(
                          color:  LuckyBox.coins ==widget.boxes[i].coins.toString()?
                          ColorManager.mainColor : Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: AppPadding.p16),
                    ),
                  ),
                ),
              )


          ) :
            (i !=widget.boxes.length-1)  ?
            Expanded(
                flex: 1,
                child: InkWell(
                  onTap: (){
                    setState(() {
                      LuckyBox.coins = widget.boxes[i].coins.toString() ;
                      LuckyBox.currentBox = i+1 ;
                      widget.refresh();

                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color:  LuckyBox.coins ==widget.boxes[i].coins.toString()?  Colors.white:  Colors.transparent,
                    ),
                    child: Center(
                      child: Text(
                        "${widget.boxes[i].coins}",
                        style: TextStyle(
                            color:  LuckyBox.coins ==widget.boxes[i].coins.toString()? ColorManager.mainColor : Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: AppPadding.p16),
                      ),
                    ),
                  ),
                )


            ) :
            Expanded(
                flex: 1,
                child: InkWell(
                  onTap: (){
                    setState(() {
                      LuckyBox.coins = widget.boxes[i].coins.toString() ;
                      LuckyBox.currentBox = i+1 ;
                      widget.refresh();
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color:  LuckyBox.coins ==widget.boxes[i].coins.toString()?  Colors.white:  Colors.transparent,
                      borderRadius:  widget.boxes.length == 1 ? BorderRadius.circular(AppPadding.p17)  :  BorderRadius.only(
                          topRight: Radius.circular(AppPadding.p17),
                          bottomRight: Radius.circular(AppPadding.p17)),
                    ),
                    child: Center(
                      child: Text(
                        "${widget.boxes[i].coins}",
                        style: TextStyle(
                            color:  LuckyBox.coins ==widget.boxes[i].coins.toString()? ColorManager.mainColor : Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: AppPadding.p16),
                      ),
                    ),
                  ),
                )


            )
        ],
      ),

    );
  }
}
