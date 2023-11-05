import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MessageCountNotifcation extends StatelessWidget {
  final Widget widget ;
  const MessageCountNotifcation({required this.widget , Key? key,})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    return StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(),  builder: (context, snapshot){
      if(snapshot.hasData) {
        return FutureBuilder(
          future:  Future.delayed(const Duration(seconds: 2)) ,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            return StreamBuilder(
                stream:  FirebaseFirestore.instance
                    .collection('Rooms')
                    .orderBy('last_message_time', descending: true)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  List data = !snapshot.hasData
                  ? []
                  : snapshot.data!.docs
                      .where((element) => element['users']
                      .toString()
                      .contains(FirebaseAuth.instance.currentUser?.uid??''))
                      .toList();

                  int totalMessages = 0;
                  int temp = 0;
                  for (int i = 0; i < data.length; i++) {
                  if (data[i]['sent_by'] !=
                      (FirebaseAuth.instance.currentUser?.uid??'')) {
                  totalMessages = data[i]['unRead'];
                  temp += totalMessages;
                  }
                  }
                  return Stack(

                  children: [

                  widget,
                  if(temp!=0)
                  Container(
                  padding:const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red),
                  child: Text(
                  '${temp}',
                  style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                  ),
                  )
                  ],
                  );
                }
            );
          }
        );
      }else {

        return    widget ;
      }
    });
  }
}