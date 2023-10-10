import 'dart:developer';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

class DialogPopUp extends StatelessWidget {
  final String headerText;
  final Widget? widget;
  final VoidCallback accpetText;
  final bool? unShowCancle;

  Color? color;

  DialogPopUp({Key? key,
    required this.headerText,
    this.widget,
    required this.accpetText,
    this.unShowCancle,
    this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    log("unShowCancle$unShowCancle");
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ConfigSize.defaultSize!),
      ),
      //backgroundColor: Colors.transparent.opacity,
      child: Container(
        height: ConfigSize.defaultSize! * 18,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(ConfigSize.defaultSize!),
            color: (color = null) ?? Colors.white
          //   : ColorManager.scandryColor.withOpacity(0.2),
        ),
        child: Column(
          children: [
            const Spacer(
              flex: 1,
            ),
            Padding(
                padding:
                EdgeInsets.symmetric(horizontal: ConfigSize.defaultSize!),
                child: Text(
                  headerText,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: ConfigSize.defaultSize! * 1.7,
                      //  fontWeight: FontWeight.w700,
                      overflow: TextOverflow.fade),
                )),
            const Spacer(
              flex: 1,
            ),
            if (widget != null) widget!,
            const Spacer(
              flex: 1,
            ),
            Divider(
              color: Colors.black.withOpacity(0.12),
            ),
            const Spacer(
              flex: 2,
            ),
            (unShowCancle ?? false)
                ? SizedBox(
              width: ConfigSize.screenWidth! * 0.3,
              height: ConfigSize.screenHeight! * 0.05,
              child: InkWell(
                  onTap: () => Navigator.pop(context),
                  child: Center(
                    child: Text(
                      StringManager.ok.tr(),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  )),
            )
                : Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: ConfigSize.screenHeight!*0.04,
                  width: ConfigSize.screenWidth!*0.2,
                  child: Center(
                    child: InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Text(
                          StringManager.cancle.tr(),
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Colors.black,
                          ),
                        )),
                  ),
                ),
                SizedBox(
                  height: ConfigSize.defaultSize! * 2,
                  child: const VerticalDivider(
                    color: Color(0xffB5B5B5),
                    width: 2,
                  ),
                ),
                InkWell(
                    onTap: () => accpetText(),
                    child: SizedBox(

                      height: ConfigSize.screenHeight!*0.04,
                      width: ConfigSize.screenWidth!*0.2,
                      child: Center(
                        child: Text(
                          StringManager.accept.tr(),
                          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Colors.red
                          ),
                        ),
                      ),
                    )),
              ],
            ),
            const Spacer(
              flex: 1,
            ),
          ],
        ),
      ),
    );
  }
}
