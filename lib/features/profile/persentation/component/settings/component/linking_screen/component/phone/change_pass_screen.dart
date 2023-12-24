
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/sendcode_manger/bloc/send_code_bloc.dart';

import '../../../../../../../../../core/utils/config_size.dart';

class ChangePassScreen extends StatefulWidget {
  const ChangePassScreen({super.key});

  @override
  State<ChangePassScreen> createState() => _ChangePassScreenState();
}

class _ChangePassScreenState extends State<ChangePassScreen> {

  TextEditingController passwordController = TextEditingController();
  bool visablePassword = true;
  final key = GlobalKey<FormState>();

  @override
  void initState() {
    passwordController.clear();
    super.initState();
  }


  @override
  void dispose() {
    passwordController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SendCodeBloc, SendCodeState>(
      listener: (context, state) async {
        if (state is SendCodeSuccesMessageState) {
          Navigator.pushNamed(
              context, Routes.otp,
              arguments: OtbScreenParm(
                  password: passwordController.text.toString(),
                  otpFrom: OtpFrom.changePassword,
                  phone: MyDataModel.getInstance().phone
              ));
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
                  padding: EdgeInsets.symmetric(
                    horizontal: ConfigSize.defaultSize! * 2.0,
                  ),
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

                        const Spacer(
                          flex: 2,
                        ),
                        Card(
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
                            height: ConfigSize.defaultSize! * 5.7,
                            decoration: BoxDecoration(
                                color: ColorManager.whiteColor,
                                borderRadius: BorderRadius.circular(
                                    ConfigSize.defaultSize! * 2.0)),
                            child: Row(children: [
                              SizedBox(
                                width: ConfigSize.defaultSize! * 25.0,
                                // alignment: Alignment.bottomCenter,
                                child: TextFormField(
                                  obscuringCharacter: '*',
                                  style: TextStyle(
                                      fontSize: ConfigSize.defaultSize! * 1.4,
                                      color: Colors.black),
                                  onChanged: (value) => setState(() {}),
                                  controller: passwordController,
                                  obscureText: visablePassword,
                                  cursorColor:
                                      ColorManager.mainColor.withOpacity(0.5),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return StringManager
                                          .pleaseEnterYourPassword
                                          .tr();
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    hintText:
                                        StringManager.enterNewPassword.tr(),
                                    hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: ConfigSize.defaultSize! * 1.2,
                                    ),
                                    disabledBorder: InputBorder.none,
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              InkWell(
                                  onTap: () {
                                    setState(() {
                                      visablePassword = !visablePassword;
                                    });
                                  },
                                  child: SizedBox(
                                    width: ConfigSize.defaultSize! * 4.0,
                                    height: ConfigSize.defaultSize! * 4.0,
                                    child: const Icon(Icons.remove_red_eye_outlined),
                                  ))
                            ]),
                          ),
                        ),
                        const Spacer(
                          flex: 1,
                        ),
                        const Spacer(
                          flex: 5,
                        ),
                        Center(
                          child: InkWell(
                            onTap: () {
                              if (passwordController.text.isNotEmpty) {
                                BlocProvider.of<SendCodeBloc>(context).add(
                                    SendPhoneEvent(
                                        phone: MyDataModel.getInstance().phone!,
                                    ),
                                );
                              }
                            },
                            child: Container(
                              width: ConfigSize.defaultSize! * 26,
                              height: ConfigSize.defaultSize! * 6.5,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                    color: const Color(0xffDDF1D8), width: 4),
                                gradient: (passwordController.text.isEmpty)
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
                              child: Center(
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
                  )),
            ))));
      },
    );
  }
}
