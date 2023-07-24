import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resours_manger/string_manger.dart';
import 'package:tik_chat_v2/core/utils/config_sizee.dart';


class PopUpDialog extends StatelessWidget {
  final String headerText;
  final String greenText;
  final String redText;
  final Widget widget;
  final VoidCallback cancelText;
  final VoidCallback accpetText;

  const PopUpDialog({Key? key,
    required this.headerText,
    required this.greenText,
    required this.redText,
    required this.widget,
    required this.cancelText,
    required this.accpetText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ConfigSize.defaultSize!),
      ),
      child: Container(
        height: ConfigSize.defaultSize!*20,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xffEFFFDB),
              Color(0xffFFF1CC),
            ]
          ),
          borderRadius: BorderRadius.circular(ConfigSize.defaultSize!),
        ),
        child: Column(
          children: [

            SizedBox(height: ConfigSize.defaultSize!*1.5,),
            Text(headerText , style: Theme.of(context).textTheme.bodyLarge,),
       
            SizedBox(height: ConfigSize.defaultSize!*3,),
            SizedBox(
              height: ConfigSize.defaultSize!*2,
                child: widget),
            SizedBox(height:ConfigSize.defaultSize!,),
            Divider(
              color: Colors.black.withOpacity(0.12),
            ),
            SizedBox(height:ConfigSize.defaultSize!,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: ()=>cancelText(),
                  child: Text(StringManager.cancel , style: Theme.of(context).textTheme.bodyMedium,)
                ),
                SizedBox(
                  height: ConfigSize.defaultSize,
                  child: const VerticalDivider(
                    color: Color(0xffB5B5B5),
                    width: 1,
                  ),
                ),
                InkWell(
                  onTap: ()=>accpetText(),
                  child: Text(StringManager.accept , style: Theme.of(context).textTheme.bodyMedium,)
                ),
              ],
            )

          ],
        ),
      ),
    );
  }
}
