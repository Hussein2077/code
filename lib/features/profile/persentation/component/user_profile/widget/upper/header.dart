import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/model/owner_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

class HeaderProfile extends StatelessWidget {
  final OwnerDataModel userData ;
  final bool myProfile ; 
  const HeaderProfile({required this.userData , required this.myProfile , super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        headerIcon(icon: Icons.arrow_back_ios ,onTap: () => Navigator.pop(context), ),
        myProfile?
        headerIcon(icon: Icons.more_horiz ,onTap: () => Navigator.pushNamed(context, Routes.editInfo , arguments: userData), ):const SizedBox(width: 10,)],
    );
  }
}

Widget headerIcon({required IconData icon ,void Function()? onTap}) {
  return InkWell(onTap: onTap,
    child: Container(
      margin: EdgeInsets.symmetric(horizontal: ConfigSize.defaultSize!*2),
      padding: EdgeInsets.all(ConfigSize.defaultSize!-3),
      decoration: BoxDecoration(color: Colors.white.withOpacity(0.5) , shape: BoxShape.circle),
      child: Icon(icon , color: Colors.white,size: ConfigSize.defaultSize!*1.7, ),
    ),
  );
}
