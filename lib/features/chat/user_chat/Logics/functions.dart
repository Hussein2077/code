import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/utils/api_healper/constant_api.dart';
import 'package:tik_chat_v2/core/utils/api_healper/methods.dart';

class Functions {
  static void updateAvailability() async{
    final _firestore = FirebaseFirestore.instance;
    final _auth = FirebaseAuth.instance;
    final data = {
      'name': MyDataModel.getInstance().name,
      'date_time': DateTime.now(),
      'email': _auth.currentUser?.email,
      'image': MyDataModel.getInstance().profile?.image??"",
      'id': MyDataModel.getInstance().id.toString(),
      "deviceToken" : await FirebaseMessaging.instance.getToken(),
      "userType" : MyDataModel.getInstance().myType
    };
    try {
      _firestore.collection('Users').doc(_auth.currentUser!.uid).set(data);
    } catch (e) {
      print(e);
    }
  }
  static Future addFireBaseId()async{

    
  String token = await Methods().returnUserToken();
  String? tokenn = FirebaseAuth.instance.currentUser?.uid.toString();
  await Dio().post(
        ConstentApi.editeUrl,
        data: {"chat_id" : tokenn,
         "notification_id": await FirebaseMessaging.instance.getToken()
        },
        options: Options(
          headers: {
            // 'X-localization': lang,
            // 'Accept': 'application/json',
            'Authorization': 'Bearer $token'
          },
        ),
      );

 }
}
