

import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/service/service_locator.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/mian_button.dart';
import 'package:tik_chat_v2/core/widgets/text_field.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/features/auth/data/data_soruce/fire_base_datasource.dart';
import 'package:tik_chat_v2/features/auth/presentation/component/add_info/widgets/continer_with_icons.dart';
import 'package:tik_chat_v2/features/auth/presentation/widgets/phone_wtih_country.dart';

class PhoneNumberBindScreen extends StatefulWidget {

  const PhoneNumberBindScreen({super.key});

  @override
  State<PhoneNumberBindScreen> createState() => _PhoneNumberBindScreenState();
}

class _PhoneNumberBindScreenState extends State<PhoneNumberBindScreen> {
   late TextEditingController passWordController;

  @override
  void initState() {
    passWordController = TextEditingController();

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body:Padding(
        padding: EdgeInsets.only(left: ConfigSize.defaultSize!*2),
        child: Column(
          children: [
            const Spacer(flex: 1,),
         
         Text(StringManager.pleaseEnterNewPhoneNum , style: Theme.of(context).textTheme.bodyLarge,),
                  const Spacer(flex: 1,),

      const PhoneWithCountry(),
                  const Spacer(flex: 1,),

           ContinerWithIcons(
                        color: Colors.white,
                        icon1: Icons.lock,
                        widget: SizedBox(
                            width: MediaQuery.of(context).size.width - 140,
                            child: TextFieldWidget(
                                hintColor: Colors.black.withOpacity(0.6),
                                hintText: StringManager.password,
                                controller: passWordController))),
                                            const Spacer(flex: 3,),

      
                                MainButton(onTap: (){  

   if (PhoneWithCountry.number.dialCode == null) {
                               warningToast(context: context, title: StringManager.pleaseSelectYourCountry);

                                  } else {
                                   
                                    if(PhoneWithCountry.phoneIsValid &&passWordController.text.isNotEmpty){
                                      getIt<FireBaseDataSource>().phoneAuthentication(PhoneWithCountry.number.phoneNumber!, context);
                                      Navigator.pushNamed(context, Routes.otpBindScreen,
                                          arguments: OtpScreenParameter(
                                              codeCountry: PhoneWithCountry.number.dialCode!,
                                              password: passWordController.text,
                                              phone:PhoneWithCountry.number.phoneNumber! ));

                                    }else {
                                warningToast(context: context, title: StringManager.pleaseEnterPassword);
                                    }


                                  }

                                
                                }, title: StringManager.done),
                                            const Spacer(flex: 5,),

           
      
          ],),
      ) ,);
  }

   void getPhoneNumber( PhoneNumber phoneNumber ) async {
    PhoneNumber number =
    await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber.phoneNumber!, phoneNumber.dialCode!);

    setState(() {
     PhoneWithCountry.number = number;
    });
  }
}



