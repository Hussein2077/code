

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/custoum_error_widget.dart';
import 'package:tik_chat_v2/core/widgets/header_with_only_title.dart';
import 'package:tik_chat_v2/core/widgets/loading_widget.dart';
import 'package:tik_chat_v2/core/widgets/user_info_row.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/vistors_manager/vistors_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/vistors_manager/vistors_state.dart';

import '../../manager/vistors_manager/vistors_bloc.dart';

// ignore: must_be_immutable
class VistorScreen extends StatefulWidget {
   int page = 1;
    VistorScreen({super.key});

  @override
  State<VistorScreen> createState() => _VistorScreenState();
}

class _VistorScreenState extends State<VistorScreen> {
    final ScrollController scrollController = ScrollController();
    @override
  void initState() {
    scrollController.addListener(scrollListener);
              BlocProvider.of<VistorsBloc>(context).add(GetVistors());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: ConfigSize.defaultSize! * 3.2,
          ),
           HeaderWithOnlyTitle(title: StringManager.vistors.tr()),
         BlocBuilder<VistorsBloc,
              VistorsState>(
            builder: (context, state) {
         if (state is GetVistorsSucssesState){
               return Expanded(
                child: ListView.builder(
                  controller: scrollController,
                    itemCount: state.data!.length,
                    itemExtent: 80,
                    itemBuilder: (context, index) {
                      return UserInfoRow(
                        userData: state.data![index],
                        endIcon: Icon(
                          Icons.arrow_forward_ios,
                          color: Theme.of(context).colorScheme.primary,
                          size: ConfigSize.defaultSize! * 2,
                        ),
                      );
                    }),
              );
         }else if (state is GetVistorsLoadingState){
          return const LoadingWidget();
         }else if (state is GetVistorsErrorState){
        return  CustomErrorWidget(message: state.errorMassage,);
         } else {
                  return  const CustomErrorWidget(message: StringManager.unexcepectedError,);

         }
            },
          )
        ],
      ),
    );
  }
  void scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      widget.page++;
           BlocProvider.of<VistorsBloc>(context).add(GetMoreVistors(page: widget.page.toString()));

      
    } else {}
  }

}