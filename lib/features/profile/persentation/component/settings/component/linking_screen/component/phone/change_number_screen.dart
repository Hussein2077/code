import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/service/service_locator.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/features/auth/data/data_soruce/fire_base_datasource.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/sendcode_manger/bloc/send_code_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/settings/component/linking_screen/component/phone/change_phone_number_text.dart';


class ChangeNumberScreen extends StatefulWidget {
  const ChangeNumberScreen({super.key});

  @override
  State<ChangeNumberScreen> createState() => ChangeNumberScreenState();
}


TextEditingController phoneController = TextEditingController();

final key = GlobalKey<FormState>();

class ChangeNumberScreenState extends State<ChangeNumberScreen> {
  static PhoneNumber number = PhoneNumber(isoCode: 'SA');

  @override
  void initState() {
    phoneController.clear();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SendCodeBloc, SendCodeState>(
      listener: (context, state) {
        if (state is SendCodeSuccesMessageState) {
          Navigator.pushNamed(context, Routes.otpBindScreen,
              arguments: OtbScreenParm(phone:number.phoneNumber ,codeCountry:number.dialCode
                  ,type:'changeNumber' ),

          );
          // Navigator.pushNamed(context, Routes.oTPForgetPassword,
          //     arguments: OtbScreenParm(
          //       slectedCountry:slectedCountry ,
          //       slectedflag:slectedflag ,
          //         password: passwordController.text,
          //         phone: phoneController.text));
        }
        if (state is SendCodeErrorMessageState) {
          errorToast(context: context, title: state.errorMessage.tr());
        }
      },
      builder: (context, state) {
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            body: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        colors: ColorManager.mainColorList,
                        end: Alignment.bottomLeft,
                        begin: Alignment.topRight)),
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal:  ConfigSize.defaultSize! *2.0,),
                    child: Form(
                      key: key,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Spacer(
                            flex: 8,
                          ),
                          Text("${StringManager.appTitle.tr()} " ,
                              style: TextStyle(color: ColorManager.whiteColor ,
                                  fontSize: ConfigSize.defaultSize!*3)),
                          Image.asset(
                            AssetsPath.iconApp,
                            scale: 2.3,
                          ),
                          const Spacer(
                            flex: 2,
                          ),
                          const ChangePhoneWithCountry(),
                          const Spacer(
                            flex: 2,
                          ),

                          Center(
                            child: InkWell(
                              onTap: () {


                                if (key.currentState!.validate()) {
                                  if (ChangePhoneWithCountry.number.dialCode == null) {
                                    errorToast(context: context, title: StringManager
                                        .pleaseAddYourCountry
                                        .tr());
                                  } else if (ChangePhoneWithCountry.phoneIsValid) {
                                    getIt<FireBaseDataSource>().phoneAuthentication(ChangePhoneWithCountry.number.phoneNumber!, context);
                                    Navigator.pushNamed(context, Routes.otpBindScreen,
                                        arguments: OtbScreenParm(
                                            type: 'changeNumber',
                                            codeCountry: ChangePhoneWithCountry.number.dialCode!,
                                            phone:ChangePhoneWithCountry.number.phoneNumber! ));

                                  } else {
                                    errorToast(context: context, title:  StringManager.pleaseEnterYourPhone.tr());
                                  }
                                }
                              },
                              child:   Container(
                                width:  ConfigSize.defaultSize! *26,
                                height:ConfigSize.defaultSize! *6.5,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      color: const Color(0xffDDF1D8), width: 4),
                                  gradient: (
                                      phoneController.text.isEmpty)
                                      ? const LinearGradient(
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomRight,
                                      colors: [
                                        Color.fromARGB(255, 240, 237, 237),
                                        ColorManager.gray,
                                      ])
                                      : const LinearGradient(
                                      colors: ColorManager.mainColorList),
                                ),
                                child:  Center(
                                  child: Text(StringManager.send.tr()),
                                ),
                              ),
                            ),
                          ),
                          const Spacer(
                            flex: 10,
                          ),
                        ],
                      ),
                    )
                ),
              ),
            ),
          ),
        );
      },
    );
  }






  void getPhoneNumber(PhoneNumber phoneNumber) async {
    PhoneNumber number = await PhoneNumber.getRegionInfoFromPhoneNumber(
        phoneNumber.phoneNumber!, phoneNumber.dialCode!);

    setState(() {
     number = number;
    });
  }
}
