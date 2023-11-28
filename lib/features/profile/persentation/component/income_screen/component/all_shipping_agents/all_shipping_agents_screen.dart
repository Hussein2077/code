import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/widgets/custoum_error_widget.dart';
import 'package:tik_chat_v2/core/widgets/transparent_loading_widget.dart';
import 'package:tik_chat_v2/core/widgets/user_info_row.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_all_shipping_agents_manager/get_all_shipping_agents_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_all_shipping_agents_manager/get_all_shipping_agents_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_all_shipping_agents_manager/get_all_shipping_agents_state.dart';

class AllShippingAgent extends StatefulWidget {
  const AllShippingAgent({super.key});

  @override
  State<AllShippingAgent> createState() => _AllShippingAgentState();
}

class _AllShippingAgentState extends State<AllShippingAgent> {

  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    scrollController.addListener(scrollListener);
    BlocProvider.of<AllShippingAgentsBloc>(context).add(GetAllShippingAgentsEvents());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AllShippingAgentsBloc, AllShippingAgentsState>(
        builder: (context, state) {
          if (state is GetAllShippingAgentsSucssesState) {
            return Scaffold(
              body: SafeArea(
                child: ListView.builder(
                    itemCount: state.data!.length,
                    controller: scrollController,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: UserInfoRow(
                          userData: state.data![index],
                          endIcon: const SizedBox(),
                          onTap: (){},
                        ),
                      );
                    }),
              ),
            );
          } else if (state is GetAllShippingAgentsLoadinglState) {
            return const TransparentLoadingWidget();
          } else if (state is GetAllShippingAgentsErrorState) {
            return CustomErrorWidget(
              message: state.errorMassage,
            );
          } else {
            return CustomErrorWidget(message: StringManager.unexcepectedError.tr());
          }
        });
  }

  void scrollListener() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      BlocProvider.of<AllShippingAgentsBloc>(context).add(GetMoreShippingAgentsEvents());
    }
  }
}
