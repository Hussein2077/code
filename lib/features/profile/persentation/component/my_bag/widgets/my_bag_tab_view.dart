import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/core/widgets/custoum_error_widget.dart';
import 'package:tik_chat_v2/core/widgets/loading_widget.dart';

import 'package:tik_chat_v2/features/profile/domin/entitie/back_pack_entities.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/my_bag/widgets/my_bag_card.dart';

class MyBagTabView extends StatelessWidget {
    final List<BackPackEnities> myBagData;
  final RequestState stateRequest;
  final int viewIndex ;
  final String message ; 
  const MyBagTabView({required this.message ,  required this.viewIndex ,  required this.myBagData , required this.stateRequest , super.key});

  @override
  Widget build(BuildContext context) {
    switch (stateRequest){
    
      case RequestState.loaded:
      log(myBagData.length.toString());
       return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 1.2),
        itemCount: myBagData.length,
        itemBuilder: (context, index) {
          log(myBagData[0].type);
          log(myBagData[0].name);
          log(myBagData[0].expire);
          log(myBagData[0].showImg.toString());
          log(myBagData[0].firstUsed.toString());
          return MyBagCard(
            viewIndex: viewIndex,
            id: myBagData[index].id.toString(),
            image:myBagData[index].showImg ,
            time: myBagData[index].expire,
            name: myBagData[index].name,
            targetId:myBagData[index].targetId.toString(),
          );
        });
      case RequestState.loading:
       return const LoadingWidget();
      case RequestState.error:
       return CustomErrorWidget(message:message,);
    }
  }
}
