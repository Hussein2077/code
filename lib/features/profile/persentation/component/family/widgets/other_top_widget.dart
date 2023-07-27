import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/auth/presentation/widgets/custom_horizental_dvider.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/family/widgets/family_info_row.dart';

class OtherTopWidget extends StatelessWidget {
  const OtherTopWidget({super.key});

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
            itemCount: 10,
            itemBuilder: (context , index){
            return const FamilyInfoRow();
          }))
        ],
      ),
    );
  }
}
