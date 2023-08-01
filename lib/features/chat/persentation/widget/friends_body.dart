import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/model/owner_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/user_info_row.dart';

// ignore: must_be_immutable
class FriendsBody extends StatelessWidget {
  TextEditingController searchController = TextEditingController();
   FriendsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: ConfigSize.defaultSize!),
          width: MediaQuery.of(context).size.width - 50,
          height: ConfigSize.defaultSize! * 5,
          decoration: BoxDecoration(
              color: ColorManager.lightGray,
              borderRadius: BorderRadius.circular(ConfigSize.defaultSize! * 2)),
          child: Row(children: [
            Image.asset(
              AssetsPath.graySearchIcon,
              scale: 2.5,
            ), 
            SizedBox(width: ConfigSize.defaultSize,),
            SizedBox(
              width: ConfigSize.defaultSize!*27,
              child: TextField(
                controller: searchController,
                decoration: const InputDecoration(
                  hintText: StringManager.search,
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                ),

                
            
                     
            
              ),
            )
          ]),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context , index){

            return Padding(padding: EdgeInsets.symmetric(vertical: ConfigSize.defaultSize!*2), child:  UserInfoRow(userData: OwnerDataModel(),));
          }),
        )
      ],
    );
  }
}
