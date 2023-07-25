

import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:tik_chat_v2/core/resours_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resours_manger/string_manger.dart';
import 'package:tik_chat_v2/core/utils/config_sizee.dart';

class PhoneWithCountry extends StatefulWidget {
  const PhoneWithCountry({super.key});
  static     PhoneNumber number = PhoneNumber(isoCode: 'EG');
  static   bool phoneIsValid = false ;



  @override
  State<PhoneWithCountry> createState() => _PhoneWithCountryState();
}
late TextEditingController phonecontroller ;

class _PhoneWithCountryState extends State<PhoneWithCountry> {
 @override
  void initState() {
phonecontroller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
phonecontroller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return      Container(
      padding: EdgeInsets.symmetric(horizontal: ConfigSize.defaultSize!),
      decoration:  BoxDecoration(color:ColorManager.whiteColor , borderRadius: BorderRadius.circular(ConfigSize.defaultSize!*6 )),
      width: MediaQuery.of(context).size.width-50,
      height: ConfigSize.defaultSize!*7.3,
      child: InternationalPhoneNumberInput(

         
        inputBorder:OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(25),
                                              borderSide: const BorderSide(
                                                width: 1,
                                                color: ColorManager.whiteColor,
                                              ),
                                            ) ,
                                          onInputChanged: (PhoneNumber number) {
                                            PhoneWithCountry.number = number;
    
                                          },
                                          onInputValidated: (bool value) {
                                            PhoneWithCountry.phoneIsValid = value ;
                                          },
                                          cursorColor: Colors.black,
                                          textStyle:const TextStyle(color: Colors.purple),
                                          inputDecoration:InputDecoration(
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(25),
                                              borderSide: const BorderSide(
                                                width: 1,
                                                color: ColorManager.whiteColor,
                                              ),
                                            ),
                                            focusedErrorBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(25),
                                              borderSide: const BorderSide(
                                                width: 1,
                                                color: ColorManager.whiteColor,
                                              ),
                                            ), 
                                            
                                            filled: true,
                                            fillColor: ColorManager.whiteColor,
                                            hintText: StringManager.enterPhoneNum,
                                      
                                            enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(25),
                                              borderSide: const BorderSide(
                                                width: 1,
                                                color: ColorManager.whiteColor,
                                              ),
                                            ),
                                          ),
                                          selectorConfig: const SelectorConfig(

                                              useEmoji: true,
                                              leadingPadding: 0,
                                              trailingSpace: false,
                                              selectorType: PhoneInputSelectorType.BOTTOM_SHEET
                                          ),
                                          ignoreBlank: false,
                                          autoValidateMode: AutovalidateMode.onUserInteraction,
                                          selectorTextStyle: const TextStyle(color: Colors.black),
                                          initialValue: PhoneWithCountry.number,
                                          textFieldController: phonecontroller,
                                          formatInput: true,
                                          keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: true),
                                          onSubmit: (){

                                          getPhoneNumber(PhoneWithCountry.number);

                                          },
                                        ),
    );
  }
   void getPhoneNumber( PhoneNumber phoneNumber ) async {
    PhoneNumber number =
    await PhoneNumber.getRegionInfoFromPhoneNumber(phoneNumber.phoneNumber!, phoneNumber.dialCode!);

    setState(() {
     PhoneWithCountry.number = number;
    });
  }
}