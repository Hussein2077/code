


import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

class DilogForPrivecyScreen extends StatelessWidget {
  final BuildContext buildContext;
  final bool flag;

  final void Function() confirm;
  final void Function() refuse;
  final String text;
  final int minPrice;
  final MyDataModel myData;


  const DilogForPrivecyScreen({
    Key? key,
    required this.buildContext,
    required this.confirm,
    required this.refuse,
    required this.text,
    required this.flag,
    required this.minPrice,
    required this.myData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: ConfigSize.defaultSize! *2.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ConfigSize.defaultSize! *1.0),
      ),
      child: Container(
        height: ConfigSize.defaultSize! *20.5,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background, borderRadius: BorderRadius.circular(ConfigSize.defaultSize! *1.0)),
        width: ConfigSize.screenWidth,
        child: Padding(
          padding: EdgeInsets.all(ConfigSize.defaultSize! *1.6,),
          child: Column(
            children: [
              Text(
                StringManager.advice.tr(),
                style: Theme.of(context).textTheme.headlineSmall,),
              SizedBox(
                height: ConfigSize.defaultSize! *2.0,
              ),
              Text(
                text,
                maxLines: 2,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: ConfigSize.defaultSize! *1.8,),
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: ConfigSize.defaultSize! *1.5,),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: flag ? confirm : refuse,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient:  LinearGradient(
                            colors: flag
                                ? ColorManager.mainColorList
                                : [Colors.grey,Colors.grey.shade700]
                          ),

                          borderRadius: BorderRadius.circular(ConfigSize.defaultSize! *0.8,),
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical:ConfigSize.defaultSize! *0.7,
                          horizontal: ConfigSize.defaultSize! *4,
                        ),
                        child: Text(
                         flag? StringManager.active.tr(): (minPrice>myData.myStore!.coins)? StringManager.chargeCoins.tr():StringManager.buy.tr(),

                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              fontSize: ConfigSize.defaultSize! *1.5,),
                        ),
                      ),
                    ),

                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(ConfigSize.defaultSize! *0.8,),

                            border: Border.all(
                              color: Colors.grey,
                              width: 1,
                            )),
                        padding: EdgeInsets.symmetric(
                          vertical:ConfigSize.defaultSize! *0.7,
                          horizontal: ConfigSize.defaultSize! *4,
                        ),
                        child: Text(
                          StringManager.cancle.tr(),
                          style:  TextStyle(
                              fontSize: ConfigSize.defaultSize! *1.5,
                              fontWeight: FontWeight.w700,
                            color: Colors.grey),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
