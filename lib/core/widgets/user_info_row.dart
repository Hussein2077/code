import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/model/owner_data_model.dart';
import 'package:tik_chat_v2/core/resours_manger/asset_path.dart';
import 'package:tik_chat_v2/core/widgets/male_female_icon.dart';

import 'user_country_icon.dart';
import 'user_image.dart';

class UserInfoRow extends StatelessWidget {
  final OwnerDataModel userData ;
  final double? imageSize ; 
  final Widget? underName ; 
  final Widget? endIcon ; 
  const UserInfoRow({required this.userData, this.endIcon ,  this.underName ,  this.imageSize ,  super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
              const  Spacer(flex: 1,),

     UserImage(imageSize: imageSize ,image: userData.profile!.image!, ),
                      const  Spacer(flex: 1,),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        Text(userData.name!,style: Theme.of(context).textTheme.bodyLarge,),
                underName??

        Row(children:  [
          MaleFemaleIcon(maleOrFeamle:userData.profile!.gender!,),          UserCountryIcon(country: userData.profile!.country),
              
 
        ],)

        ],),
              const  Spacer(flex: 20,),
        endIcon??
        Image.asset(AssetsPath.chatWithUserIcon , scale: 2.5,),
                      const  Spacer(flex: 1,),
                      



      ],
    );
  }
}
