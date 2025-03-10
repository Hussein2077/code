import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

class PopUpDialog extends StatelessWidget {
  final String headerText;
  final Widget? widget;
  final VoidCallback accpetText;
  final bool? unShowCancle ;
    final String? accpettitle;


  const PopUpDialog({
    Key? key,
    required this.headerText,
    this.widget,
    required this.accpetText,
    this.unShowCancle,
    this.accpettitle
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ConfigSize.defaultSize!),
      ),
      child: Container(
        height: ConfigSize.defaultSize! * 20,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: const LinearGradient(colors: ColorManager.bageGriedinet),
          borderRadius: BorderRadius.circular(ConfigSize.defaultSize!),
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
                      color: Colors.white,
                      fontSize: ConfigSize.defaultSize! * 1.7,
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
              flex: 3,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if(!(unShowCancle??false))
                InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Text(
                      StringManager.cancel.tr(),
                      style: Theme.of(context).textTheme.bodyMedium,
                    )),
                if(!(unShowCancle??false))
                SizedBox(
                  height: ConfigSize.defaultSize! * 2,
                  child: const VerticalDivider(
                    color: Color(0xffB5B5B5),
                    width: 2,
                  ),
                ),
                InkWell(
                    onTap: () => accpetText(),
                    child: Text(
                     accpettitle?? StringManager.accept.tr(),
                      style: Theme.of(context).textTheme.bodyMedium,
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
