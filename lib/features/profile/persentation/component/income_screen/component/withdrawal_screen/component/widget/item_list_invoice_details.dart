import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

class ItemInvoiceDetails extends StatelessWidget {
 final String date,withdrawalAmount,userID;

  const ItemInvoiceDetails({
    super.key,
    required this.date,
    required this.userID,
    required this.withdrawalAmount
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
              StringManager.successfulOperation,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(
              height:  ConfigSize.defaultSize!*2.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                    StringManager.date,
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
                    StringManager.withdrawalAmount,
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
                  StringManager.userID,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  userID,
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
