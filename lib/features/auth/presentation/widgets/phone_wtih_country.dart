

import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:tik_chat_v2/core/resours_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resours_manger/string_manger.dart';
import 'package:tik_chat_v2/core/utils/config_sizee.dart';

class PhoneWithCountry extends StatefulWidget {
  const PhoneWithCountry({super.key});

  @override
  State<PhoneWithCountry> createState() => _PhoneWithCountryState();
}
TextEditingController phonecontroller = TextEditingController();

class _PhoneWithCountryState extends State<PhoneWithCountry> {

    PhoneNumber number = PhoneNumber(isoCode: 'EG');

  @override
  Widget build(BuildContext context) {
    return      Container(
      padding: EdgeInsets.symmetric(horizontal: ConfigSize.defaultSize!),
      decoration:  BoxDecoration(color:ColorManager.whiteColor , borderRadius: BorderRadius.circular(ConfigSize.defaultSize!*6 )),
      width: MediaQuery.of(context).size.width-50,
      height: ConfigSize.defaultSize!*6,
      child: InternationalPhoneNumberInput(

         
        inputBorder:OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(25),
                                              borderSide: const BorderSide(
                                                width: 1,
                                                color: ColorManager.whiteColor,
                                              ),
                                            ) ,
                                          onInputChanged: (PhoneNumber number) {
                                            this.number = number;
    
                                          },
                                          onInputValidated: (bool value) {
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
                                          initialValue: number,
                                          textFieldController: phonecontroller,
                                          formatInput: true,
                                          keyboardType: const TextInputType.numberWithOptions(signed: true, decimal: true),
                                          onSubmit: (){
                                            // getPhoneNumber(this.number);
                                          },
                                        ),
    );
  }
}