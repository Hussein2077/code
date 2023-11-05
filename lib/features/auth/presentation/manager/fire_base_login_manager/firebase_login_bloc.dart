import 'dart:async';
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

      await FirebaseAuth.instance.signOut();
 if (!kDebugMode){
   await FirebaseAuth.instance.signInWithEmailAndPassword(
       email: "eelhamody@gmail.com",
       password:"eelhamody@gmail.com"
   );
 }else {

   try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: "${MyDataModel.getInstance().id}@gmail.com",
            password:"${MyDataModel.getInstance().id}@gmail.com"
        );
      } on FirebaseAuthException catch (e) {

     await createUserFireBase();

   }
      Methods().addFireBaseNotifcationId();
      Functions.updateAvailability(MyDataModel.getInstance().id.toString(),
          MyDataModel.getInstance().name.toString(), MyDataModel.getInstance().profile!.image!);



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
        MyDataModel.getInstance().id.toString(), MyDataModel.getInstance().name.toString(), MyDataModel.getInstance().profile!.image!);
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