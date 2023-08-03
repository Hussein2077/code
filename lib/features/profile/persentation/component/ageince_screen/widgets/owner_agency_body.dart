import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

class OwnerAgencyBody extends StatelessWidget {
  const OwnerAgencyBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        agencyCard(context: context , title: StringManager.agencyMembersRank , onTap:() =>  Navigator.pushNamed(context, Routes.agencyMemberScreen)),
        agencyCard(context: context , title: StringManager.reports),
        agencyCard(context: context , title: StringManager.joinRequests ,onTap: () => Navigator.pushNamed(context, Routes.agencyRequestsScreen), ) ,  
        agencyCard(context: context ,title: StringManager.shippingFromTheAgency),
        agencyCard(context: context ,title:StringManager.chargingFromTheSystem ),
      ],
    );
  }
}

Widget agencyCard({required BuildContext context , required String title , void Function()? onTap}) {
  return InkWell(
    onTap:onTap ,
    child: Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ConfigSize.defaultSize! * 2)),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: ConfigSize.defaultSize!),
        width: MediaQuery.of(context).size.width - 50,
        height: ConfigSize.defaultSize! * 8,
        decoration: BoxDecoration(
          color: ColorManager.lightGray,
          borderRadius: BorderRadius.circular(ConfigSize.defaultSize! * 2),
          border: Border.all(
            color: ColorManager.blue.withOpacity(0.5),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.bodyLarge,
  
            ),
  
            Icon(Icons.arrow_forward_ios , size: ConfigSize.defaultSize!*1.7, color: Colors.black,)
          ],
        ),
      ),
    ),
  );
}
