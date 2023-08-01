import 'package:flutter/material.dart';

import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';

import 'package:tik_chat_v2/features/profile/domin/entitie/back_pack_entities.dart';
import 'package:tik_chat_v2/features/profile/presentation/component/my_bag/widgets/my_bag_card.dart';

class MyBagTabView extends StatelessWidget {
    final List<BackPackEnities> myBagData;
  final RequestState stateRequest;
  final int viewIndex ;
  const MyBagTabView({required this.viewIndex ,  required this.myBagData , required this.stateRequest , super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 1.2),
        itemCount: myBagData.length,
        itemBuilder: (context, index) {
          return MyBagCard(
            viewIndex: viewIndex,
            id: myBagData[index].id.toString(),
            image:myBagData[index].showImg ,
            time: myBagData[index].expire,
            name: myBagData[index].name,
            targetId:myBagData[index].targetId.toString(),
          );
        });
  }
}
