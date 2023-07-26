import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resours_manger/string_manger.dart';
import 'package:tik_chat_v2/core/utils/config_sizee.dart';
import 'package:tik_chat_v2/features/auth/presentation/widgets/custom_horizental_dvider.dart';
import 'package:tik_chat_v2/features/profile/data/model/fanily_rank_model.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/family/widgets/family_info_row.dart';

class OtherTopWidget extends StatelessWidget {
    final List<FamilyRanking> otherRanking;

  const OtherTopWidget({required this.otherRanking ,  super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(
                ConfigSize.defaultSize! * 3,
              ),
              topRight: Radius.circular(ConfigSize.defaultSize! * 3))),
      child: Column(
        children: [
          Text(
            StringManager.familys,
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          CustomHorizntalDvider(
            width: ConfigSize.defaultSize! * 5,
            color: Colors.orange,
          ),
          Expanded(child: ListView.builder(
            itemExtent: 100,
            itemCount: otherRanking.length,
            itemBuilder: (context , index){
            return  FamilyInfoRow(image: otherRanking[index].img!, 
            intro: otherRanking[index].introduce!,
            name: otherRanking[index].name!,);
          }))
        ],
      ),
    );
  }
}
