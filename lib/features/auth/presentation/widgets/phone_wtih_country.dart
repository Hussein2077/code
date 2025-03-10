import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

class PhoneWithCountry extends StatefulWidget {
  const PhoneWithCountry({super.key});

  static PhoneNumber number = PhoneNumber(isoCode: 'EG');
  static bool phoneIsValid = false;

  @override
  State<PhoneWithCountry> createState() => _PhoneWithCountryState();
}

class _PhoneWithCountryState extends State<PhoneWithCountry> {

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
    return Container(
      padding: EdgeInsets.symmetric(horizontal: ConfigSize.defaultSize!),
      decoration: BoxDecoration(
          color: ColorManager.whiteColor,
          borderRadius: BorderRadius.circular(ConfigSize.defaultSize! * 6)),
      width: MediaQuery.of(context).size.width - 50,
      height: ConfigSize.defaultSize! * 7.5,
      child: InternationalPhoneNumberInput(
        inputBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(
            width: 1,
            color: ColorManager.whiteColor,
          ),
        ),
        onInputChanged: (PhoneNumber number) {
          PhoneWithCountry.number = number;
        },
        onInputValidated: (bool value) {
          PhoneWithCountry.phoneIsValid = value;
        },
        cursorColor: Colors.black,
        textStyle: const TextStyle(color: Colors.purple),
        inputDecoration: InputDecoration(
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
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: const BorderSide(
              width: 1,
              color: ColorManager.whiteColor,
            ),
          ),
          filled: true,
          fillColor: ColorManager.whiteColor,
          hintText: StringManager.enterPhoneNum.tr(),
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
            selectorType: PhoneInputSelectorType.BOTTOM_SHEET),
        ignoreBlank: false,
        autoValidateMode: AutovalidateMode.onUserInteraction,
        selectorTextStyle: const TextStyle(color: Colors.black),
        initialValue: PhoneWithCountry.number,
        textFieldController: phonecontroller,
        formatInput: true,
        keyboardType:
            const TextInputType.numberWithOptions(signed: true, decimal: true),
        onSubmit: () {
          getPhoneNumber(PhoneWithCountry.number);
        },
      ),
    );
  }

  void getPhoneNumber(PhoneNumber phoneNumber) async {
    PhoneNumber number = await PhoneNumber.getRegionInfoFromPhoneNumber(
        phoneNumber.phoneNumber!, phoneNumber.dialCode!);
    if (mounted) {
      setState(() {
        PhoneWithCountry.number = number;
      });
    }
  }
}
