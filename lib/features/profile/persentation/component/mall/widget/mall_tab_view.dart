

import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/features/profile/domin/entitie/data_mall_entities.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/mall/widget/mall_card.dart';

class MallTabView extends StatelessWidget {
    final List<DataMallEntities> dataMall;
  final RequestState stateRequest;
  final String dataMallMessage;
  const MallTabView({required this.dataMall, required this.dataMallMessage , required this.stateRequest, super.key});

  @override
  Widget build(BuildContext context) {
   return GridView.builder(
    
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 1),
        itemCount: dataMall.length,
        itemBuilder: (context, index) {
          log("message");
          return MallCard(
            image: dataMall[index].image,
            id: dataMall[index].id.toString(),
            name: dataMall[index].name,
            price: dataMall[index].price.toString(),
            time: dataMall[index].expire.toString(),           

          );
        });
  }
}