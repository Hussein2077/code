import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/loading_widget.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/income_screen/component/withdrawal_screen/component/widget/item_list_invoice_details.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_wallet_history/charge_history_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_wallet_history/charge_history_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_wallet_history/charge_history_state.dart';

class TabBarViewDetailsScreen extends StatelessWidget {
  const TabBarViewDetailsScreen({Key? key, required this.flag})
      : super(key: key);

  final String? flag;


  @override
  Widget build(BuildContext context) {
    if (flag == 'send') {
      BlocProvider.of<ChargeHistoryBloc>(context)
          .add(ChargeHistory(sent: 'sent'));
    } else {
      BlocProvider.of<ChargeHistoryBloc>(context)
          .add(ChargeHistory(sent: 'received'));
    }

    return BlocBuilder<ChargeHistoryBloc, ChargeHistoryState>(
      builder: (context, state) {
        if(state is ChargeHistorySuccessReceivedState){
          return  Column(
            children: [
              SizedBox(
                height: ConfigSize.defaultSize! * 4.0,
              ),
              ListView.builder(
                itemBuilder: (context, index) {
                  return  ItemInvoiceDetails(
                    date: state.received.data![index].time.toString(),
                    userID: state.received.data![index].sender!.id.toString(),
                    withdrawalAmount:state.received.data![index].value!.toString(),
                  );
                },
                shrinkWrap: true,
                itemCount: state.received.data!.length,
              ),
            ],
          );
        }
        else if (state is ChargeHistoryLoadingReceived) {
          return const LoadingWidget();
        } else if (state is ChargeHistoryErrorReceivedState) {
          return Center(
            child: Text(state.error),
          );
        } else {
          return const Text('Something wrong');
        }
      },
    );
  }
}
