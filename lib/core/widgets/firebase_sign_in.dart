


import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/widgets/loading_widget.dart';
import 'package:tik_chat_v2/features/chat/user_chat/Logics/functions.dart';

import '../utils/config_size.dart';

class FireBaseSignIn extends StatefulWidget {
  final String email ; 
  final String password;
   final  MyDataModel? data ;
  final String phone ; 

   FireBaseSignIn({required this.phone ,  this.data, required this.email , required this.password, super.key});

  @override
  State<FireBaseSignIn> createState() => _FireBaseSignInState();
}

class _FireBaseSignInState extends State<FireBaseSignIn> {
  int index = 0 ; 

  @override
  Widget build(BuildContext context) {
    loingFirebase(context);
    return index==0? const  LoadingWidget()  :
    Scaffold(body: Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children:  [
      Text(StringManager.unexcepectedError.tr(),
        style:  TextStyle(color: ColorManager.darkBlack , fontSize: ConfigSize.defaultSize!*2 , fontWeight: FontWeight.bold),),
      SizedBox(height: ConfigSize.defaultSize!*2,), 
      InkWell(onTap:(){
          Navigator.pushNamedAndRemoveUntil(
      context, Routes.login, (route) => false);
      } , child: Container(width: ConfigSize.defaultSize!*10, height: ConfigSize.defaultSize!*4, decoration: BoxDecoration(color: ColorManager.orangeRed, borderRadius: BorderRadius.circular(ConfigSize.defaultSize!)),child: const Center(child: Text("Back" , style: TextStyle(color: ColorManager.whiteColor , ),)),) ,)
    ],),),) ;
  }

 Future loingFirebase (BuildContext context)async{
  try {
   await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: widget.email,
    password: widget.password
  );
} on FirebaseAuthException catch (e) {
  index++;
  setState(() {
    
  });
  if (e.code == 'user-not-found') {
    // showToastWidget(
    //     ToastWidget().errorToast(StringManager.userNotFound.tr()),
    //     context: context,
    //     position: StyledToastPosition.top);
                  await createUserFireBase(widget.data!);



  } else if (e.code == 'wrong-password') {

    print('Wrong password provided for that user.');
  }
  log("chatErorrrrrrrrrrr");
  // Navigator.pushNamedAndRemoveUntil(
  //     context, Routes.login, (route) => false);

}
 }
}

 Future createUserFireBase(MyDataModel data) async {
    try {
      // ignore: unused_local_variable
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: "${data.id}@gmail.com",
        password: "${data.id}@gmail.com",
      );
      Functions.updateAvailability(
          data.id.toString(), data.name.toString(), data.profile!.image!);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        // ignore: avoid_print
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        // ignore: avoid_print
        print('The account already exists for that email.');
      }
    } catch (e) {
      // ignore: avoid_print
      print(e);
    }
  }