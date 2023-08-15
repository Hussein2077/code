import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

class DialogForPrivecyScreen extends StatelessWidget {
  final BuildContext buildContext;
  final bool flag;
  final void Function() confirm;
  final String text;

  const DialogForPrivecyScreen({
    Key? key,
    required this.buildContext,
    required this.confirm,
    required this.text,
    required this.flag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding:
          EdgeInsets.symmetric(horizontal: ConfigSize.screenWidth! * 0.06),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ConfigSize.defaultSize! * 2),
      ),
      child: Container(
        height: ConfigSize.screenHeight! * 0.26,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(ConfigSize.defaultSize! * 2)),
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: EdgeInsets.all(ConfigSize.defaultSize! * 2.0),
          child: Column(
            children: [
              Text(
                StringManager.advice.tr(),
                style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: ConfigSize.defaultSize! * 2.1),
              ),
              SizedBox(
                height: ConfigSize.screenHeight! * 0.03,
              ),
              Text(
                text,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: ConfigSize.defaultSize! * 1.5),
              ),
              SizedBox(
                height: ConfigSize.screenHeight! * 0.04,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: flag ? confirm : () {},
                    child: Container(
                      decoration: BoxDecoration(
                        color: flag
                            ? ColorManager.mainColor
                            : ColorManager.lightGray,
                        borderRadius: BorderRadius.circular(
                            ConfigSize.defaultSize! * 0.8),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: ConfigSize.screenHeight! * 0.01,
                        horizontal: ConfigSize.screenWidth! * 0.1,
                      ),
                      child: Text(
                        StringManager.active.tr(),
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            fontSize: ConfigSize.defaultSize! * 1.50),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                              ConfigSize.defaultSize! * 0.8),
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.grey,
                            width: 1,
                          )),
                      padding: EdgeInsets.symmetric(
                        vertical: ConfigSize.screenHeight! * 0.01,
                        horizontal: ConfigSize.screenWidth! * 0.1,
                      ),
                      child: Text(
                        StringManager.cancle.tr(),
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: ConfigSize.defaultSize! * 1.50),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
