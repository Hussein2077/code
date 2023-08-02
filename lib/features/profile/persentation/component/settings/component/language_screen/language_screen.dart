

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/service/service_locator.dart';
import 'package:tik_chat_v2/core/utils/api_healper/methods.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/header_with_only_title.dart';
import 'package:tik_chat_v2/core/widgets/mian_button.dart';

class LanguageScreen extends StatefulWidget {
  static int? selectedLanguage;
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

enum SingingCharacter { english, arabic, no }

class _LanguageScreenState extends State<LanguageScreen> {
  List <String> language = [StringManager.english.tr(), StringManager.arabic.tr()];
  List <String> languageCode = ['en','ar'];
  SingingCharacter languages = SingingCharacter.no;

  @override
  void initState() {
    super.initState();

    intilanguage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body:Column(children: [
      SizedBox(height: ConfigSize.defaultSize!*3.5,),
      const HeaderWithOnlyTitle(title: StringManager.language),
      //  SizedBox(height: ConfigSize.defaultSize!*3.5,),
       Expanded(child: ListView.builder(
        itemCount: language.length,
        itemExtent: 50,
        itemBuilder: (context, index){

        return languageRow(context: context , index: index  , language: language[index] ,
          onTap: ()async {
          setState(() {

          });
            await context.setLocale(const Locale('ar'));
            await Methods().saveLocalazitaon(language: "ar");
          setState(() {

            LanguageScreen.selectedLanguage = index;
          });
        },);

       })),

       MainButton(
         onTap: ()async {

           SharedPreferences sharedPreferences = getIt();
           final bool isLogin =
               await sharedPreferences.getBool(StringManager.keepLogin) ??
                   false;
           if (isLogin) {
             Navigator.pop(context);
             // ignore: use_build_context_synchronously
             // Navigator.pushAndRemoveUntil(
             //     context,
             //     MaterialPageRoute(
             //         builder: (context) => const MainView(keepInRoom: null,)),
             //     ModalRoute.withName(Routes.main));
           } else {
             Navigator.pushNamedAndRemoveUntil(
                 context, Routes.login, (route) => false);
           }

       },
         title: StringManager.save,)
      
    ],) ,);
  }
  Future<void> intilanguage() async {
    String key = await Methods().getlocalization();
    if (key == "en") {
      languages = SingingCharacter.english;
    } else if (key == "ar") {
      languages = SingingCharacter.arabic;
    } else {
      languages = SingingCharacter.english;
    }
  }
}

Widget languageRow({ 
  required BuildContext context,
  required String language,
  required int index,
  void Function()? onTap}){
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: ConfigSize.defaultSize!),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
      Text(language, style: Theme.of(context).textTheme.bodyLarge,),
  
      InkWell(
        onTap:onTap ,
        child: Container(
          width: ConfigSize.defaultSize!*3,
          height: ConfigSize.defaultSize!*3,
          decoration: BoxDecoration(
            color:LanguageScreen.selectedLanguage==index? ColorManager.orang :Colors.transparent ,
            shape: BoxShape.circle , border: Border.all(color: Colors.grey)),),
      )
    ],),
  );
} 