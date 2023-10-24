import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

class ItemInvoiceDetails extends StatelessWidget {
 final String date,withdrawalAmount,userID , type;

  const ItemInvoiceDetails({
    super.key,
    required this.date,
    required this.userID,
    required this.withdrawalAmount,
    required this.type
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ConfigSize.defaultSize!*2.0,),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal:  ConfigSize.defaultSize!*2.0
          , vertical: ConfigSize.defaultSize!*1.0,),
        margin: EdgeInsets.symmetric(vertical:  ConfigSize.defaultSize!*1.0,),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular( ConfigSize.defaultSize!*1.0,),
            border: Border.all(
                color: ColorManager.mainColor,
                width: 1)),
        child: Column(
          children: [
            SizedBox(
              height:  ConfigSize.defaultSize!*3.0,
            ),

            Text(
              StringManager.successfulOperation.tr(),
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(
              height:  ConfigSize.defaultSize!*2.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    StringManager.date.tr(),
                    style: Theme.of(context).textTheme.bodyMedium
                ),
                Text(
                  date,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            SizedBox(
              height:  ConfigSize.defaultSize!*2.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    StringManager.withdrawalAmount.tr(),
                    style: Theme.of(context).textTheme.bodyMedium
                ),
                Text(
                  withdrawalAmount,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
            SizedBox(
              height:  ConfigSize.defaultSize!*2.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  StringManager.userID.tr(),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  userID,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
             SizedBox(
              height:  ConfigSize.defaultSize!*2.0,
            ),
            if(type!="")
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  StringManager.type.tr(),
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  type,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
