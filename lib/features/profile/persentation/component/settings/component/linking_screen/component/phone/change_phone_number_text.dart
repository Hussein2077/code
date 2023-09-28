import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';


class ChangePhoneWithCountry extends StatefulWidget {
  static PhoneNumber number = PhoneNumber(isoCode: 'EG');
  static bool phoneIsValid = false;

  const ChangePhoneWithCountry({super.key});

  @override
  State<ChangePhoneWithCountry> createState() => _ChangePhoneWithCountryState();
}

class _ChangePhoneWithCountryState extends State<ChangePhoneWithCountry> {
  late TextEditingController phonecontroller;

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
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            ConfigSize.defaultSize! * 2.0,
          )),
      child: Container(
        padding: EdgeInsets.only(
          left: ConfigSize.defaultSize! * 1.5,
        ),
        // alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        // height: 48.h,
        decoration: BoxDecoration(
            color: ColorManager.whiteColor,
            borderRadius: BorderRadius.circular(20)),

        child: InternationalPhoneNumberInput(
          onInputChanged: (PhoneNumber number) {
            ChangePhoneWithCountry.number = number;
          },
          onInputValidated: (bool value) {
            ChangePhoneWithCountry.phoneIsValid = value;
          },
          cursorColor: ColorManager.gray,
          textStyle: const TextStyle(color: Colors.black),
          inputDecoration: InputDecoration(
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: const BorderSide(
                width: 1,
                color: Color(0XFFF5F5F5),
              ),
            ),
            filled: true,
            fillColor: Colors.white,
            hintText: StringManager.inputPhonenum.tr(),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: const BorderSide(
                width: 1,
                color: Color(0XFFF5F5F5),
              ),
            ),
          ),
          selectorConfig: const SelectorConfig(
              useEmoji: true,
              leadingPadding: 0,
              trailingSpace: false,
              selectorType: PhoneInputSelectorType.BOTTOM_SHEET),
          ignoreBlank: false,
          autoValidateMode: AutovalidateMode.onUserInteraction,
          selectorTextStyle: const TextStyle(color: Colors.black),
          initialValue: ChangePhoneWithCountry.number,
          textFieldController: phonecontroller,
          formatInput: true,
          keyboardType: const TextInputType.numberWithOptions(
              signed: true, decimal: true),
          onSubmit: () {
            getPhoneNumber(ChangePhoneWithCountry.number);
          },
        ),
      ),
    );
  }

  void getPhoneNumber(PhoneNumber phoneNumber) async {
    PhoneNumber number = await PhoneNumber.getRegionInfoFromPhoneNumber(
        phoneNumber.phoneNumber!, phoneNumber.dialCode!);

    setState(() {
      ChangePhoneWithCountry.number = number;
    });
  }
}
