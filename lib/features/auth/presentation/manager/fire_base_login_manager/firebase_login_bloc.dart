import 'dart:async';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/utils/api_healper/methods.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/fire_base_login_manager/firebase_login_event.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/fire_base_login_manager/firebase_login_state.dart';
import 'package:tik_chat_v2/features/chat/user_chat/Logics/functions.dart';



class FirebaseLoginBloc extends Bloc<BaseFirebaseLoginEvent, FirebaseLoginState> {
  FirebaseLoginBloc() : super(FirebaseLoginInitial()) {
    on<FireBaseLoginEvent>((event, emit) async{
      log("1");
      await FirebaseAuth.instance.signOut();
      log("2");
    if (kDebugMode){

     await FirebaseAuth.instance.signInWithEmailAndPassword(
       email: "eelhamody@gmail.com",
       password:"eelhamody@gmail.com"
   );

 }else {

   try {
     log("3");
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: "${MyDataModel.getInstance().id}@gmail.com",
            password:"${MyDataModel.getInstance().id}@gmail.com"
        );
     log("4");
      } on FirebaseAuthException catch (e) {
        await createUserFireBase();
   }
   log("5");
      Methods().addFireBaseNotifcationId();
   log("6");
      Functions.updateAvailability();
   log("7");
    }});
  }
}

Future createUserFireBase() async {
  try {
    // ignore: unused_local_variable
    final credential =
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: "${MyDataModel.getInstance().id}@gmail.com",
      password: "${MyDataModel.getInstance().id}@gmail.com",
    );
    Functions.updateAvailability(
       );
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