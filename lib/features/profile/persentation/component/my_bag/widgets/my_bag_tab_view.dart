import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';

import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/custoum_error_widget.dart';
import 'package:tik_chat_v2/core/widgets/loading_widget.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';

import 'package:tik_chat_v2/features/profile/domin/entitie/back_pack_entities.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/my_bag/widgets/my_bag_card.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_my_data_manager/get_my_data_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_my_data_manager/get_my_data_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manger_send/bloc/send_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manger_send/bloc/send_state.dart';

class MyBagTabView extends StatelessWidget {
  final List<BackPackEnities> myBagData;
  final RequestState stateRequest;
  final int viewIndex;
  static int itemIndex = -1;
  final String message;

  const MyBagTabView(
      {required this.message, required this.viewIndex, required this.myBagData, required this.stateRequest, super.key});

  @override
  Widget build(BuildContext context) {
    switch (stateRequest) {
      case RequestState.loaded:
        log(myBagData.length.toString());
        return  BlocConsumer<SendBloc, SendState>(
          listener: (context, state) {
            if (state is SendSucssesState) {
              BlocProvider.of<GetMyDataBloc>(context).add(GetMyDataEvent());
              myBagData.removeAt(MyBagTabView.itemIndex);
              sucssesToast(
                  context: context,
                  title: state.massage);

            } else if (state is SendErrorState) {
              errorToast(
                  context: context,
                  title: state.massage);
            } else if (state is SendLoadingState) {
              loadingToast(
                  context: context,
                  title: StringManager.loading.tr());
            }
          },
          builder: (context, state) {
            return GridView.builder(
              padding: EdgeInsets.only(top: ConfigSize.defaultSize! * 3),
                gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisSpacing: ConfigSize.defaultSize! * 1,
                    crossAxisCount: 2, childAspectRatio: 1.15),
                itemCount: myBagData.length,
                itemBuilder: (context, index) {
                  log(myBagData[0].type);
                  log(myBagData[0].name);
                  log(myBagData[0].expire);
                  log(myBagData[0].showImg.toString());
                  log(myBagData[0].firstUsed.toString());
                  return MyBagCard(
                    viewIndex: viewIndex,
                    index: index,
                    id: myBagData[index].id.toString(),
                    image: myBagData[index].showImg,
                    time: myBagData[index].expire,
                    name: myBagData[index].name,
                    isFirst: myBagData[index].firstUsed,
                    targetId: myBagData[index].targetId.toString(),
                  );
                });
          },
        );
      case RequestState.loading:
        return const LoadingWidget();
      case RequestState.error:
        return CustomErrorWidget(message: message,);
    }
  }
}
