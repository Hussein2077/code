

import 'dart:developer';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

class CountryWidget extends StatefulWidget {
  const CountryWidget({super.key});
  static String? countryFlag;
  static String? codeContry;


  @override
  State<CountryWidget> createState() => _CountryWidgetState();
}

class _CountryWidgetState extends State<CountryWidget> {
String? countryName ;


  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: ConfigSize.defaultSize!),
        width: MediaQuery.of(context).size.width - 50,
        height: ConfigSize.defaultSize! * 6,
        decoration: BoxDecoration(
            color: ColorManager.lightGray,
            borderRadius: BorderRadius.circular(ConfigSize.defaultSize! * 3)),
        child: Row(
          children: [
            const Icon(Icons.flag , color: Colors.grey,),
            SizedBox(width: ConfigSize.defaultSize,),

            Row(
              children: [
                                    CountryWidget.countryFlag == null
                                        ? Text(StringManager.selectyourCountry,
                                            style: TextStyle(
                                              color: Colors.grey,
                                                fontSize: ConfigSize.defaultSize!*1.8))
                                        : Text(CountryWidget.countryFlag!,
                                           ),
                                    SizedBox(
                                      width: ConfigSize.defaultSize,
                                    ),
                                    Visibility(
                                        visible: countryName == null ? false : true,
                                        child: Text(
                                          countryName.toString(),
                                          style:TextStyle(
                                              color: Colors.grey,
                                                fontSize: ConfigSize.defaultSize!*1.8),
                                        ))
                                  ],
            ),

            const Spacer(),
            const Icon(Icons.keyboard_arrow_down , color: Colors.grey,),
          ],
        ),
      ),
      onTap: () {
                            showCountryPicker(
                              
                              showSearch: true,
                              showPhoneCode: false,
                              showWorldWide: false,
                              context: context,
                              countryListTheme: CountryListThemeData(
                                
                                flagSize: ConfigSize.defaultSize!*3,
                                backgroundColor:Theme.of(context).colorScheme.background,
                                textStyle: Theme.of(context).textTheme.headlineLarge,
                                bottomSheetHeight:MediaQuery.of(context).size.height-200,
                                // Optional. Country list modal height
                                //Optional. Sets the border radius for the bottomsheet.
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(ConfigSize.defaultSize!),
                                  topRight: Radius.circular(ConfigSize.defaultSize!),
                                ),
                              ),
                              onSelect: (Country country) {
                                setState(() {
                                  CountryWidget.countryFlag = country.flagEmoji;
                                  CountryWidget.codeContry = country.phoneCode;
                                  countryName= country.name;
                                });
                              },
                            );

                          },
    );
  }
}