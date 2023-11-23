import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/profile/data/model/charge_history_model.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/income_screen/component/withdrawal_screen/component/widget/item_list_invoice_details.dart';


class TabBarViewDetailsScreen extends StatelessWidget {
    final ChargeHistoryModel? data;
    final String flag ;

  const TabBarViewDetailsScreen({
    required this.flag ,  
    this.data ,

    
    Key? key,})
      : super(key: key);



  @override
  Widget build(BuildContext context) {
    
    
  

    return ListView.builder(
      primary: true,
      padding: EdgeInsets.only(
        top: ConfigSize.defaultSize!*2
      ),
      itemBuilder: (context, index) {
        return  ItemInvoiceDetails(
          date: data!.data![index].time.toString(),
          userID: flag=="sent"? data!.data![index].receiver!.uid.toString():data!.data![index].sender!.uid.toString(),
          withdrawalAmount:data!.data![index].value!.toString(),
          type:flag=="sent"?"":data!.data![index].sender!.type.toString(),

        );
      },
      shrinkWrap: true,
      itemCount: data!.data!.length,
    );
  }
}
