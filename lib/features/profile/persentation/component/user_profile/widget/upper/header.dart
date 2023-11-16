import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/profile/profile_room_body_controler.dart';

class HeaderProfile extends StatelessWidget {
  final MyDataModel myDataModel ;
  final bool myProfile ;
  const HeaderProfile({required this.myDataModel , required this.myProfile , super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.only(top: ConfigSize.defaultSize!*3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          headerIcon(icon: Icons.arrow_back_ios ,onTap: () => Navigator.pop(context), ),
          myProfile?
          headerIcon(icon: Icons.edit ,onTap: () => Navigator.pushNamed(context, Routes.editInfo , arguments: myDataModel), ):
           IconButton(onPressed: (){
            return repoertsAction(
              context: context,
              userData: myDataModel.convertToUserObject()
            );
          }, icon:const Icon(Icons.report_problem_outlined) )],
      ),
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
