import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/mian_button.dart';
import 'package:tik_chat_v2/splash.dart';

class RefreshScreen extends StatelessWidget {
  const RefreshScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width:  MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(AssetsPath.splashBackGround)
          )
        ),
        child:  Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            
            Image.asset(AssetsPath.iconAppWithTitle,scale: 3),
            
            Text(StringManager.somethingsWrong.tr(),style: TextStyle(
              color: Colors.white,
              fontSize:ConfigSize.defaultSize!*2.5,
            ),),
            MainButton(onTap: (){
              Navigator.pushNamedAndRemoveUntil(context, Routes.splash, (route) => false);
            }, title: StringManager.refresh.tr())
          ],
        ),
      ),
    );
  }
}
