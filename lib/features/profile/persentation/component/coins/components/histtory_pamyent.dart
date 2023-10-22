import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/service/service_locator.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/core/widgets/custoum_error_widget.dart';
import 'package:tik_chat_v2/core/widgets/header_with_only_title.dart';
import 'package:tik_chat_v2/core/widgets/loading_widget.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/income_screen/component/withdrawal_screen/component/widget/item_list_invoice_details.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_wallet_history/charge_history_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_wallet_history/charge_history_state.dart';

import '../../../../../../../core/utils/config_size.dart';
import '../../../manager/manager_wallet_history/charge_history_event.dart';


class PaymentHistory extends StatefulWidget {
  const PaymentHistory({Key? key}) : super(key: key);

  @override
  State<PaymentHistory> createState() => _PaymentHistoryState();
}

class _PaymentHistoryState extends State<PaymentHistory>{


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: ConfigSize.defaultSize!*3,
          ),
          HeaderWithOnlyTitle(title: StringManager.payment.tr()),

          BlocProvider(
              create: (context) => getIt<ChargeHistoryBloc>()

                ..add(ChargeRecivedHistory(recived: "received")),
              child: BlocBuilder<ChargeHistoryBloc, ChargeHistoryState>(
                  builder: (context, state) {
                    switch (state.recivedState) {
                      case RequestState.loaded:
                        return  Expanded(
                          child: ListView.builder(
                            itemBuilder: (context, index) {
                              return  Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: ConfigSize.defaultSize!,
                                    horizontal:ConfigSize.defaultSize!,
                                ),
                                child: ItemInvoiceDetails(

                                  date: state.recived!.data![index].time.toString(),
                                  userID: state.recived!.data![index].receiver!.uid.toString(),
                                  withdrawalAmount:state.recived!.data![index].value!.toString(),
                                  type:state.recived!.data![index].sender!.type.toString(),

                                ),
                              );
                            },

                            shrinkWrap: true,
                            itemCount: state.recived!.data!.length,
                          ),
                        );

                      case RequestState.loading:
                        return const Expanded(child: LoadingWidget());
                      case RequestState.error:
                        return CustomErrorWidget(message: state.sentMessage);
                    }
                  }))

        ],
      ),
    );
  }
}
