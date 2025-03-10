import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
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
            StringManager.familys.tr(),
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
            return  InkWell(
              onTap: (){
                Navigator.pushNamed(context, Routes.familyProfile,arguments:otherRanking[index].id );
              },
              child: FamilyInfoRow(image: otherRanking[index].img!,
              intro: otherRanking[index].rank!,
              name: otherRanking[index].name!,),
            );
          }))
        ],
      ),
    );
  }
}
