


import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

class DilogForPrivecyScreen extends StatelessWidget {
   final BuildContext buildContext;
  final bool flag;

  final void Function() confirm;
  final String text;

  const DilogForPrivecyScreen({
    Key? key,
    required this.buildContext,
    required this.confirm,
    required this.text,
    required this.flag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: ConfigSize.defaultSize! *2.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ConfigSize.defaultSize! *1.0),
      ),
      child: Container(
        height: ConfigSize.defaultSize! *14.5,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(ConfigSize.defaultSize! *1.0)),
        width: ConfigSize.screenWidth,
        child: Padding(
          padding: EdgeInsets.all(ConfigSize.defaultSize! *1.5,),
          child: Column(
            children: [
              Text(
                StringManager.advice.tr(),
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: ConfigSize.defaultSize! *1.8,),
              ),
              SizedBox(
                height: ConfigSize.defaultSize! *1.0,
              ),
              Text(
                text,
                maxLines: 2,
                style: TextStyle(fontWeight: FontWeight.w500, fontSize: ConfigSize.defaultSize! *1.4,),
              ),
              const Spacer(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: ConfigSize.defaultSize! *1.0,),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: flag ? confirm : () {

                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: flag
                              ? ColorManager.mainColor
                              : ColorManager.gray,
                          borderRadius: BorderRadius.circular(ConfigSize.defaultSize! *0.8,),
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical:ConfigSize.defaultSize! *0.3,
                          horizontal: ConfigSize.defaultSize! *0.75,
                        ),
                        child: Text(
                          StringManager.active.tr(),
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
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.grey,
                              width: 1,
                            )),
                        padding: EdgeInsets.symmetric(
                          vertical: 3,
                          horizontal: ConfigSize.defaultSize! *0.75,
                        ),
                        child: Text(
                          StringManager.cancle.tr(),
                          style: TextStyle(
                              fontWeight: FontWeight.w700, fontSize: ConfigSize.defaultSize! *1.4,),
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
