

import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/header_with_only_title.dart';
import 'package:tik_chat_v2/core/widgets/mian_button.dart';

class LanguageScreen extends StatefulWidget {
  static int? selectedLanguage;
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  List <String> language = [StringManager.english, StringManager.arabic];
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

        return languageRow(context: context , index: index  , language: language[index] , onTap: () {
          setState(() {
            LanguageScreen.selectedLanguage = index;
          });
        },);

       })),

       MainButton(onTap: () {
         
       }, title: StringManager.save,)
      
    ],) ,);
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