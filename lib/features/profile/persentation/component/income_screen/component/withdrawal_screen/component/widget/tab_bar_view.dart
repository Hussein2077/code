import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/income_screen/component/withdrawal_screen/component/widget/item_list_invoice_details.dart';

class TabBarViewDetailsScreen extends StatelessWidget {
  const TabBarViewDetailsScreen({Key? key,}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return Column(
        children: [
          SizedBox(
            height: ConfigSize.defaultSize!*4.0,
          ),
          ListView.builder(
            itemBuilder: (context, index) {
              return const ItemInvoiceDetails(
                date: '12/5/2023',
                userID: '159357',
                withdrawalAmount: '150,000',
              );
            },
            shrinkWrap: true,
            itemCount:2,
          ),
        ],
      );
  }
}
