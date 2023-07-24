

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resours_manger/string_manger.dart';
import 'package:tik_chat_v2/core/utils/config_sizee.dart';

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
    return            InkWell(
                          child: Row(
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
                          onTap: () {
                            showCountryPicker(
                              showSearch: false,
                              showPhoneCode: false,
                              showWorldWide: false,
                              context: context,
                              countryListTheme: CountryListThemeData(
                                flagSize: ConfigSize.defaultSize!*3,
                                backgroundColor:Theme.of(context).colorScheme.background,
                                textStyle: Theme.of(context).textTheme.headlineLarge,
                                bottomSheetHeight:ConfigSize.defaultSize!*35,
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