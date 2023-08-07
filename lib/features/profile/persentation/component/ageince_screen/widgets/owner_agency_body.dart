import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/model/owner_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

class OwnerAgencyBody extends StatelessWidget {
  final OwnerDataModel myData;
  const OwnerAgencyBody({super.key,required this.myData});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        width: MediaQuery.of(context).size.width - 40,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(

          borderRadius: BorderRadius.circular(ConfigSize.defaultSize!*2.0),
        ),
        child: Column(
          children: [
            agencyCard(
                context: context,
                widget:Image.asset(AssetsPath.rank,scale: 2),
                title: StringManager.agencyMembersRank,
                onTap:() =>  Navigator.pushNamed(context, Routes.agencyMemberScreen)),

            agencyCard(
              context: context ,
              title: StringManager.reports ,
              widget: const Icon(Icons.report,color: Colors.amber),
              onTap: () => Navigator.pushNamed(context, Routes.agencyRepoertsScreen),),

            agencyCard(
              context: context ,
              title: StringManager.joinRequests ,
              widget: const Icon(Icons.person_add_alt_1_rounded,color: Colors.amber),
              onTap: () => Navigator.pushNamed(context, Routes.agencyRequestsScreen), ) ,

            agencyCard(context: context ,
              title: StringManager.shippingFromTheAgency ,
              widget:Image.asset(AssetsPath.moneyBag,scale:6) ,
              onTap: () => Navigator.pushNamed(context, Routes.charchingDolarsForUsers),),
            if(myData.type == 4)
            agencyCard(context: context ,
              title:StringManager.chargingFromTheSystem ,
              widget:Image.asset(AssetsPath.goldCoinIcon,scale: 6) ,
              onTap: () => Navigator.pushNamed(context, Routes.charchingCoinsForUsers), ),
          ],
        ),
      ),
    );
  }
}

Widget agencyCard({required BuildContext context ,required Widget widget ,required String title , void Function()? onTap}) {
  return InkWell(
    onTap:onTap ,
    child: Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: ConfigSize.defaultSize!),
          height: ConfigSize.defaultSize! * 6,
          color: Theme.of(context).cardColor,
          child: Row(
            children: [
             widget,
              SizedBox(
                width: ConfigSize.defaultSize!*1.8,
              ),
              Text(
                title,
                style: Theme.of(context).textTheme.bodyLarge,

              ),
              Spacer(),
              Icon(Icons.arrow_forward_ios , size: ConfigSize.defaultSize!*1.7, color: Theme.of(context).iconTheme.color)
            ],
          ),
        ),
        Divider(
          height: 0.9,
       color: ColorManager.blue.withOpacity(0.5),
        )
      ],
    ),
  );
}
