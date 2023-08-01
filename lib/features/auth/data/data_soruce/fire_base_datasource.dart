

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';

class FireBaseDataSource {
  FirebaseAuth auth = FirebaseAuth.instance;
 var verificationId = '' ;

  Future<void> phoneAuthentication(String phoneNumber ,BuildContext context)async{
    log("phoneNumber$phoneNumber");
    await   auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 60),
      codeSent: (String verificationId, int? resendToken) async {
        // Update the UI - wait for the user to enter the SMS code
      this.verificationId = verificationId ;
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number')
        {
                errorToast(context: context, title: "invalid-phone-number");


        }else {
                          errorToast(context: context, title: e.message.toString());

 
        }
      },
      verificationCompleted: (PhoneAuthCredential credential) async {
        // ANDROID ONLY!
        log("verificationCompleted") ;
        // Sign the user in (or link) with the auto-generated credential
        // ignore: unused_local_variable
        var cradintial =    await auth.signInWithCredential(credential);


      },
      codeAutoRetrievalTimeout: (String verificationId)async {

     this.verificationId=verificationId ;
        } );


}

// ignore: body_might_complete_normally_nullable
Future<UserCredential?> verifyOTP(String otp,BuildContext context )async{

  try{
    var credential =await auth.signInWithCredential(PhoneAuthProvider.credential(verificationId: verificationId, smsCode: otp)) ;

    return credential ;
  }catch(e) {
                              errorToast(context: context, title: StringManager.wrongCode);

  
  }
}


}