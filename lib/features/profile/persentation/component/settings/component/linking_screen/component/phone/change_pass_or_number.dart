
import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/sendcode_manger/bloc/send_code_bloc.dart';



class ChangePassOrNumberScreen extends StatefulWidget {
  const ChangePassOrNumberScreen({super.key});

  @override
  State<ChangePassOrNumberScreen> createState() => _ChangePassOrNumberScreenState();
}

bool visablePassword = true;
TextEditingController passwordController = TextEditingController();

final key = GlobalKey<FormState>();

class _ChangePassOrNumberScreenState extends State<ChangePassOrNumberScreen> {
  @override
  void initState() {
    passwordController.clear();
    super.initState();
  }

  bool phoneIsValid = false;

  @override
  Widget build(BuildContext context) {
    log('changePassOrNumberScreen');
    return BlocConsumer<SendCodeBloc, SendCodeState>(
      listener: (context, state)async {

        if (state is SendCodeSuccesMessageState) {
          Navigator.pushNamed(context, Routes.otpBindScreen,
            arguments: OtbScreenParm(password: passwordController.text ,type:'changePassword' ),

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


      // {
      //   if (state is SendCodeSuccesMessageState) {
      //     // Navigator.pushNamed(context, Routes.oTPForgetPassword,
      //     //     arguments: OtbScreenParm(
      //     //       slectedCountry:slectedCountry ,
      //     //       slectedflag:slectedflag ,
      //     //         password: passwordController.text,
      //     //         phone: phoneController.text));
      //   }
      //   if (state is SendCodeErrorMessageState) {
      //     errorToast(context: context, title: state.errorMessage.tr());
      //   }
      // },
      builder: (context, state) {
        return GestureDetector(
          onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
          child: Scaffold(
            body: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                decoration:  const BoxDecoration(
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
                          ChangeItemRow(
                            title: StringManager.changePhone,
                            firstIcon: (Icons.phone_android_outlined),
                            onTap: (){
                              Navigator.pushNamed(context, Routes.changeNumberOldScreen);
                            },

                          ),
                          const Spacer(
                            flex: 2,
                          ),
                          ChangeItemRow(

                            title: StringManager.changePassword,
                            firstIcon: (Icons.lock),
                            onTap: (){
                              Navigator.pushNamed(context, Routes.changePassScreen);


                            },
                          ),

                          const Spacer(
                            flex: 17,
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

}



class ChangeItemRow extends StatelessWidget{
  final IconData firstIcon;
  final String title;
  final void Function()? onTap;

  const ChangeItemRow({required this.title,required this.onTap,required this.firstIcon,});
  @override
  Widget build(BuildContext context) {
 return InkWell(
  onTap: onTap,
   child: Row(
     children: [
       const Spacer(flex: 2,),
       Icon(firstIcon),
       const Spacer(flex: 1,),

       Text(title),
       const Spacer(flex: 10,),

       const Icon(Icons.arrow_forward_ios),
       const Spacer(flex: 2,),

     ],
   ),
 );
  }


}
