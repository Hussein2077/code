import 'dart:developer';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:keyboard_height_plugin/keyboard_height_plugin.dart';
import 'package:tik_chat_v2/core/notifcation/fun_send_notifcation.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/api_healper/constant_api.dart';
import 'package:tik_chat_v2/core/utils/api_healper/methods.dart';
import 'package:tik_chat_v2/core/widgets/loading_widget.dart';
import 'package:tik_chat_v2/core/widgets/user_image.dart';
import 'package:tik_chat_v2/features/chat/user_chat/comps/styles.dart';
import 'package:tik_chat_v2/features/chat/user_chat/comps/widgets.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manger_getuser/get_user_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manger_getuser/get_user_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manger_getuser/get_user_state.dart';
import 'package:uuid/uuid.dart';

import '../../../core/utils/config_size.dart';


class ChatPageBody extends StatefulWidget {
  final String id;
  final String name;
  final String yayaId;
  final String image;
  final String deviceTocke;
  final String myName;
  final int unReadMessages;

  const ChatPageBody(
      {Key? key,
      required this.image,
      required this.yayaId,
      required this.unReadMessages,
      required this.id,
      required this.name,
      required this.deviceTocke,
      required this.myName})
      : super(key: key);

  @override
  State<ChatPageBody> createState() => _ChatPageBodyState();
}

class _ChatPageBodyState extends State<ChatPageBody> {
  static ValueNotifier<bool> showTextField = ValueNotifier<bool>(false);

  var roomId;
  late int unReadMessages;
  FocusNode focusNode = FocusNode();

  double _keyboardHeight = 0;
  final KeyboardHeightPlugin _keyboardHeightPlugin = KeyboardHeightPlugin();

  @override
  void initState() {
    unReadMessages = widget.unReadMessages;
    focusNode.addListener(() {
      // setState(() {

      // });
      log("111111");
    });
    _keyboardHeightPlugin.onKeyboardHeightChanged((double height) {
      _keyboardHeight = height;
      showTextField.value = !showTextField.value;
    });
    super.initState();
  }

  final firestore = FirebaseFirestore.instance;

  File? imageFile;
  Future uploadImage() async {
    String fileName = const Uuid().v1();
    int status = 1;
    await firestore
        .collection('Rooms')
        .doc(roomId)
        .collection('messages')
        .doc(fileName)
        .set({
      'message': "",
      "type": "image",
      'sent_by': FirebaseAuth.instance.currentUser!.uid,
      'datetime': DateTime.now(),
    });
    try {
      var ref =
          FirebaseStorage.instance.ref().child('images').child("$fileName.jpg");

      var uploadTask = await ref.putFile(imageFile!).catchError((error) async {
        firestore
            .collection('Rooms')
            .doc(roomId)
            .collection('messages')
            .doc(fileName)
            .delete();
        status = 0;
      });
      if (status == 1) {
        String imageUrl = await uploadTask.ref.getDownloadURL();
        firestore
            .collection('Rooms')
            .doc(roomId)
            .collection('messages')
            .doc(fileName)
            .update({"message": imageUrl});
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future getImage() async {
    ImagePicker _picker = ImagePicker();
    await _picker.pickImage(source: ImageSource.gallery).then((xFile) {
      if (xFile != null) {
        imageFile = File(xFile.path);
        uploadImage();
      }
    });
  }

  onSubmitImage() {
    getImage();
  }

  onSubmit(controller) {
    if (controller.text.toString() != '') {
      if (roomId != null) {
        Map<String, dynamic> data = {
          'message': controller.text.trim(),
          'type': 'text',
          'sent_by': FirebaseAuth.instance.currentUser!.uid,
          'datetime': DateTime.now(),
        };
        //  firestore.collection('Rooms').doc(roomId).get('unRead');
        firestore.collection('Rooms').doc(roomId).update({
          'last_message_time': DateTime.now(),
          'last_message': controller.text,
          'sent_by': FirebaseAuth.instance.currentUser!.uid,
          'Read': false,
          'unRead': ++unReadMessages
        });
        firestore
            .collection('Rooms')
            .doc(roomId)
            .collection('messages')
            .add(data);
        SendNotifcation.sendNotification(
            title: widget.myName,
            body: controller.text.trim(),
            token: widget.deviceTocke);
      } else {
        Map<String, dynamic> data = {
          'message': controller.text.trim(),
          'sent_by': FirebaseAuth.instance.currentUser!.uid,
          'type': 'text',
          'datetime': DateTime.now(),
        };
        firestore.collection('Rooms').add({
          'users': [
            widget.id,
            FirebaseAuth.instance.currentUser!.uid,
          ],
          'last_message': controller.text,
          'last_message_time': DateTime.now(),
          'Read': false,
          'sent_by': FirebaseAuth.instance.currentUser!.uid,
          'unRead': ++unReadMessages
        }).then((value) async {
          value.collection('messages').add(data);
        });
        SendNotifcation.sendNotification(
            title: widget.myName,
            body: controller.text.trim(),
            token: widget.deviceTocke);
      }
    }
    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    final firestore = FirebaseFirestore.instance;

    BlocProvider.of<GetUserBloc>(context)
        .add(GetuserEvent(userId: widget.yayaId));
    return BlocBuilder<GetUserBloc, GetUserState>(
      builder: (context, state) {
        if (state is GetUserLoddingState) {
          return const Scaffold(
            body: Center(child: LoadingWidget()),
          );
        }
        if (state is GetUserSucssesState) {
          return Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: Theme.of(context).colorScheme.background,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

            Container(
                  width: MediaQuery.of(context).size.width,
                  height: ConfigSize.defaultSize! * 6,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(colors: ColorManager.mainColorList)),
                  child: Center(
                      child: Row(
                    children: [
                      const Spacer(
                        flex: 5,
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.arrow_back_ios,
                            color: ColorManager.whiteColor,
                          )),

                      InkWell(
                          onTap: () {
                            showImageViewer(
                                context,
                                CachedNetworkImageProvider(
                                  ConstentApi().getImage(widget.image),
                                ),
                                swipeDismissible: false);
                          },
                          child: UserImage(
                              image: widget.image,
                              imageSize: ConfigSize.defaultSize! * 5,)),

                      InkWell(
                        onTap: () {
                          Methods().userProfileNvgator(context: context , userId: widget.yayaId );

                        },
                        child: Text(
                          widget.name,
                          style: TextStyle(
                              color: ColorManager.whiteColor,
                              fontSize: ConfigSize.defaultSize! * 1.5),
                        ),
                      ),
                      const Spacer(
                        flex: 40,
                      )
                    ],
                  )),
                ),
        Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Spacer(),
                      StreamBuilder(
                          stream: firestore
                              .collection('Users')
                              .doc(widget.id)
                              .snapshots(),
                          builder: (context,
                              AsyncSnapshot<
                                      DocumentSnapshot<Map<String, dynamic>>>
                                  snapshot) {
                            return !snapshot.hasData
                                ? Container()
                                : Text(
                                    '${StringManager.lastSeen.tr()}: ${DateFormat('hh:mm a').format(snapshot
                                            .data!['date_time']
                                            .toDate())}',
                                    style: Styles.h1().copyWith(
                                        fontSize: ConfigSize.defaultSize! + 3,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black),
                                  );
                          }),
                      const Spacer(),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: Styles.friendsBox(),
                    child: StreamBuilder(
                        stream: firestore.collection('Rooms').snapshots(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data!.docs.isNotEmpty) {
                              List<QueryDocumentSnapshot?> allData = snapshot
                                  .data!.docs
                                  .where((element) =>
                                      element['users'].contains(widget.id) &&
                                      element['users'].contains(FirebaseAuth
                                          .instance.currentUser!.uid))
                                  .toList();
                              QueryDocumentSnapshot? data =
                                  allData.isNotEmpty ? allData.first : null;
                              if (data != null) {
                                roomId = data.id;

                                if (FirebaseAuth.instance.currentUser!.uid !=
                                    data['sent_by']) {
                                  unReadMessages = 0;

                                  firestore
                                      .collection('Rooms')
                                      .doc(roomId)
                                      .update({'Read': true, 'unRead': 0});
                                }
                              }
                              return data == null
                                  ? Container()
                                  : StreamBuilder(
                                      stream: data.reference
                                          .collection('messages')
                                          .orderBy('datetime', descending: true)
                                          .snapshots(),
                                      builder: (context,
                                          AsyncSnapshot<QuerySnapshot> snap) {
                                        return !snap.hasData
                                            ? Container()
                                            : ListView.builder(
                                                itemCount:
                                                    snap.data!.docs.length,
                                                reverse: true,
                                                itemBuilder: (context, i) {
                                                  return ChatWidgets.messagesCard(
                                                      snap.data!.docs[i]
                                                              ['sent_by'] ==
                                                          FirebaseAuth.instance
                                                              .currentUser!.uid,
                                                      snap.data!.docs[i]
                                                          ['message'],
                                                      DateFormat('hh:mm a')
                                                          .format(snap
                                                              .data!
                                                              .docs[i]
                                                                  ['datetime']
                                                              .toDate()),
                                                      widget.image,
                                                      snap.data!.docs[i]
                                                          ['type'],
                                                      context);
                                                },
                                              );
                                      });
                            } else {
                              return Center(
                                child: Text(
                                  'No conversion found',
                                  style: Styles.h1()
                                      .copyWith(color: Colors.indigo.shade400),
                                ),
                              );
                            }
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: Colors.indigo,
                              ),
                            );
                          }
                        }),
                  ),
                ),
                ChatWidgets.messageField(
                    onSubmit: onSubmit, onSubmitImage: onSubmitImage , focusNode: focusNode, context: context),
                ValueListenableBuilder<bool>(
                    valueListenable: showTextField,
                    builder: (context, isShow, _) {
                      if (isShow) {
                        return SizedBox(height: _keyboardHeight);
                      } else {
                        return const SizedBox(
                          height: 0,
                        );
                      }
                    })
              ],
            ),
          );

          //blocked
        } else {
          return Scaffold(
            resizeToAvoidBottomInset: true,
            backgroundColor: ColorManager.whiteColor,
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: ConfigSize.defaultSize! * 8,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(colors: [
                    Color(0xFF0AB2A5),
                    Color(0xFF29CC98),
                    Color(0xFF3ADA94),
                  ])),
                  child: Center(
                      child: Row(
                    children: [
                      const Spacer(
                        flex: 1,
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.arrow_back_ios,
                            color: ColorManager.whiteColor,
                          )),
                      const Spacer(
                        flex: 3,
                      ),
                      InkWell(
                          onTap: () {},
                          child: UserImage(
                              image: widget.image,
                              imageSize: ConfigSize.defaultSize! * 4)),
                      const Spacer(
                        flex: 1,
                      ),
                      InkWell(
                        onTap: () {},
                        child: Text(
                          widget.name,
                          style: TextStyle(
                              color: ColorManager.whiteColor,
                              fontSize: ConfigSize.defaultSize! * 2),
                        ),
                      ),
                      const Spacer(
                        flex: 8,
                      )
                    ],
                  )),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Spacer(),
                      StreamBuilder(
                          stream: firestore
                              .collection('Users')
                              .doc(widget.id)
                              .snapshots(),
                          builder: (context,
                              AsyncSnapshot<
                                      DocumentSnapshot<Map<String, dynamic>>>
                                  snapshot) {
                            return !snapshot.hasData
                                ? Container()
                                : Text(
                                    'Last seen ' +
                                        DateFormat('hh:mm a').format(snapshot
                                            .data!['date_time']
                                            .toDate()),
                                    style: Styles.h1().copyWith(
                                        fontSize: ConfigSize.defaultSize! + 3,
                                        fontWeight: FontWeight.normal,
                                        color: Colors.black),
                                  );
                          }),
                      const Spacer(),
                      const SizedBox(
                        width: 50,
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: Styles.friendsBox(),
                    child: StreamBuilder(
                        stream: firestore.collection('Rooms').snapshots(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data!.docs.isNotEmpty) {
                              List<QueryDocumentSnapshot?> allData = snapshot
                                  .data!.docs
                                  .where((element) =>
                                      element['users'].contains(widget.id) &&
                                      element['users'].contains(FirebaseAuth
                                          .instance.currentUser!.uid))
                                  .toList();
                              QueryDocumentSnapshot? data =
                                  allData.isNotEmpty ? allData.first : null;
                              if (data != null) {
                                roomId = data.id;
                                if (FirebaseAuth.instance.currentUser!.uid !=
                                    data['sent_by']) {
                                  firestore
                                      .collection('Rooms')
                                      .doc(roomId)
                                      .update({'Read': true});
                                }
                              }
                              return data == null
                                  ? Container()
                                  : StreamBuilder(
                                      stream: data.reference
                                          .collection('messages')
                                          .orderBy('datetime', descending: true)
                                          .snapshots(),
                                      builder: (context,
                                          AsyncSnapshot<QuerySnapshot> snap) {
                                        return !snap.hasData
                                            ? Container()
                                            : ListView.builder(
                                                itemCount:
                                                    snap.data!.docs.length,
                                                reverse: true,
                                                itemBuilder: (context, i) {
                                                  return ChatWidgets.messagesCard(
                                                      snap.data!.docs[i]
                                                              ['sent_by'] ==
                                                          FirebaseAuth.instance
                                                              .currentUser!.uid,
                                                      snap.data!.docs[i]
                                                          ['message'],
                                                      DateFormat('hh:mm a')
                                                          .format(snap
                                                              .data!
                                                              .docs[i]
                                                                  ['datetime']
                                                              .toDate()),
                                                      widget.image,
                                                      snap.data!.docs[i]
                                                          ['type'],
                                                      context);
                                                },
                                              );
                                      });
                            } else {
                              return Center(
                                child: Text(
                                  'No conversion found',
                                  style: Styles.h1()
                                      .copyWith(color: Colors.indigo.shade400),
                                ),
                              );
                            }
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(
                                color: Colors.indigo,
                              ),
                            );
                          }
                        }),
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: ChatWidgets.messageField(
                      onSubmitImage: onSubmitImage,
                      onSubmit: (controller) {
                        if (controller.text.toString() != '') {
                          showDialog<String>(
                            context: context,
                            builder: (BuildContext context) => AlertDialog(
                              title: Text(StringManager.blocked.tr()),
                              content: Text(StringManager.youCanNotChat.tr()),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'Ok'),
                                  child: Text(StringManager.confirm.tr()),
                                ),
                              ],
                            ),
                          );
                        }
                        controller.clear();
                      },
                      focusNode: focusNode,
                      context: context),
                )
              ],
            ),
          );
          // Scaffold(body: Column(children: [Spacer(flex: 9,), Image(image: AssetImage(AssetsPath.blockPic)),Spacer(flex: 1,),  Center(child: Text(StringManger.blocked.tr() , style: TextStyle(fontSize: ConfigSize.defaultSize!*2 , fontWeight: FontWeight.bold   ),)),Spacer(flex: 1,), Center(child: Text(StringManger.youCanNotChat.tr()))  ,Spacer(flex: 10,)],),);
        }
      },
    );
  }
}


//
// class ChatPageBody extends StatefulWidget {
//   final String id;
//   final String name;
//   final String yayaId;
//   final String image;
//   final String deviceTocke;
//   final String myName;
//   final int unReadMessages;
//
//   const ChatPageBody(
//       {Key? key,
//       required this.image,
//       required this.yayaId,
//       required this.unReadMessages,
//       required this.id,
//       required this.name,
//       required this.deviceTocke,
//       required this.myName})
//       : super(key: key);
//
//   @override
//   State<ChatPageBody> createState() => _ChatPageBodyState();
// }
//
// class _ChatPageBodyState extends State<ChatPageBody> {
//     static ValueNotifier<bool> showTextField = ValueNotifier<bool>(false);
//
//   var roomId;
//   late int unReadMessages;
//   FocusNode focusNode = FocusNode();
//
//     double _keyboardHeight = 0;
//     final KeyboardHeightPlugin _keyboardHeightPlugin = KeyboardHeightPlugin();
//
//
//   @override
//   void initState() {
//     unReadMessages = widget.unReadMessages;
//     focusNode.addListener(() {
//
//     });
//     _keyboardHeightPlugin.onKeyboardHeightChanged((double height) {
//         _keyboardHeight = height;
//         showTextField.value = !showTextField.value;
//     });
//     super.initState();
//   }
//
//   final firestore = FirebaseFirestore.instance;
//
//   File? imageFile;
//   Future uploadImage() async {
//     String fileName = const Uuid().v1();
//     int status = 1;
//     await firestore
//         .collection('Rooms')
//         .doc(roomId)
//         .collection('messages')
//         .doc(fileName)
//         .set({
//       'message': "",
//       "type": "image",
//       'sent_by': FirebaseAuth.instance.currentUser!.uid,
//       'datetime': DateTime.now(),
//     });
//     try {
//       var ref =
//           FirebaseStorage.instance.ref().child('images').child("$fileName.jpg");
//
//       var uploadTask = await ref.putFile(imageFile!).catchError((error) async {
//         firestore
//             .collection('Rooms')
//             .doc(roomId)
//             .collection('messages')
//             .doc(fileName)
//             .delete();
//         status = 0;
//       });
//       if (status == 1) {
//         String imageUrl = await uploadTask.ref.getDownloadURL();
//         firestore
//             .collection('Rooms')
//             .doc(roomId)
//             .collection('messages')
//             .doc(fileName)
//             .update({"message": imageUrl});
//       }
//     } catch (e) {
//       log(e.toString());
//     }
//   }
//
//   Future getImage() async {
//     ImagePicker _picker = ImagePicker();
//     await _picker.pickImage(source: ImageSource.gallery).then((xFile) {
//       if (xFile != null) {
//         imageFile = File(xFile.path);
//         uploadImage();
//       }
//     });
//   }
//
//   onSubmitImage() {
//     getImage();
//   }
//
//   onSubmit(controller) {
//     if (controller.text.toString() != '') {
//       if (roomId != null) {
//         Map<String, dynamic> data = {
//           'message': controller.text.trim(),
//           'type': 'text',
//           'sent_by': FirebaseAuth.instance.currentUser!.uid,
//           'datetime': DateTime.now(),
//         };
//         //  firestore.collection('Rooms').doc(roomId).get('unRead');
//         firestore.collection('Rooms').doc(roomId).update({
//           'last_message_time': DateTime.now(),
//           'last_message': controller.text,
//           'sent_by': FirebaseAuth.instance.currentUser!.uid,
//           'Read': false,
//           'unRead': ++unReadMessages
//         });
//         firestore
//             .collection('Rooms')
//             .doc(roomId)
//             .collection('messages')
//             .add(data);
//         SendNotifcation.sendNotification(
//             title: widget.myName,
//             body: controller.text.trim(),
//             token: widget.deviceTocke);
//       } else {
//         Map<String, dynamic> data = {
//           'message': controller.text.trim(),
//           'sent_by': FirebaseAuth.instance.currentUser!.uid,
//           'type': 'text',
//           'datetime': DateTime.now(),
//         };
//         firestore.collection('Rooms').add({
//           'users': [
//             widget.id,
//             FirebaseAuth.instance.currentUser!.uid,
//           ],
//           'last_message': controller.text,
//           'last_message_time': DateTime.now(),
//           'Read': false,
//           'sent_by': FirebaseAuth.instance.currentUser!.uid,
//           'unRead': ++unReadMessages
//         }).then((value) async {
//           value.collection('messages').add(data);
//         });
//         SendNotifcation.sendNotification(
//             title: widget.myName,
//             body: controller.text.trim(),
//             token: widget.deviceTocke);
//       }
//     }
//     controller.clear();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final firestore = FirebaseFirestore.instance;
//
//     BlocProvider.of<GetUserBloc>(context)
//         .add(GetuserEvent(userId: widget.yayaId));
//     return BlocBuilder<GetUserBloc, GetUserState>(
//       builder: (context, state) {
//         if (state is GetUserLoddingState) {
//           return const Scaffold(
//             body: Center(child: LoadingWidget()),
//           );
//         }
//         if (state is GetUserSucssesState) {
//           return Scaffold(
//             resizeToAvoidBottomInset: true,
//             backgroundColor: ColorManager.whiteColor,
//             body: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   width: MediaQuery.of(context).size.width,
//                   height: ConfigSize.defaultSize! * 6,
//                   decoration: const BoxDecoration(
//                       gradient: LinearGradient(colors: ColorManager.mainColorList)),
//                   child: Center(
//                       child: Row(
//                     children: [
//                       const Spacer(
//                         flex: 5,
//                       ),
//                       InkWell(
//                           onTap: () {
//                             Navigator.pop(context);
//                           },
//                           child: const Icon(
//                             Icons.arrow_back_ios,
//                             color: ColorManager.whiteColor,
//                           )),
//
//                       InkWell(
//                           onTap: () {
//                             showImageViewer(
//                                 context,
//                                 CachedNetworkImageProvider(
//                                   ConstentApi().getImage(widget.image),
//                                 ),
//                                 swipeDismissible: false);
//                           },
//                           child: UserImage(
//                               image: widget.image,
//                               imageSize: ConfigSize.defaultSize! * 5,)),
//
//                       InkWell(
//                         onTap: () {
//                           Methods().userProfileNvgator(context: context , userId: widget.yayaId );
//
//                         },
//                         child: Text(
//                           widget.name,
//                           style: TextStyle(
//                               color: ColorManager.whiteColor,
//                               fontSize: ConfigSize.defaultSize! * 1.5),
//                         ),
//                       ),
//                       const Spacer(
//                         flex: 40,
//                       )
//                     ],
//                   )),
//                 ),
//
//                 Expanded(
//                   child: Container(
//                     decoration: Styles.friendsBox(),
//                     child: StreamBuilder(
//                         stream: firestore.collection('Rooms').snapshots(),
//                         builder:
//                             (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//
//                           if (snapshot.hasData) {
//                             if (snapshot.data!.docs.isNotEmpty) {
//                               List<QueryDocumentSnapshot?> allData = snapshot
//                                   .data!.docs
//                                   .where((element) =>
//                                       element['users'].contains(widget.id) &&
//                                       element['users'].contains(FirebaseAuth
//                                           .instance.currentUser!.uid))
//                                   .toList();
//                               QueryDocumentSnapshot? data =
//                                   allData.isNotEmpty ? allData.first : null;
//                               if (data != null) {
//                                 roomId = data.id;
//
//                                 if (FirebaseAuth.instance.currentUser!.uid !=
//                                     data['sent_by']) {
//                                   unReadMessages = 0;
//
//
//                                   firestore
//                                       .collection('Rooms')
//                                       .doc(roomId)
//                                       .update({'Read': true, 'unRead': 0});
//                                 }
//                               }
//                               return data == null
//                                   ? const SizedBox()
//                                   : StreamBuilder(
//                                       stream: data.reference
//                                           .collection('messages')
//                                           .orderBy('datetime', descending: true)
//                                           .snapshots(),
//                                       builder: (context,
//                                           AsyncSnapshot<QuerySnapshot> snap) {
//                                         return !snap.hasData
//                                             ? Container()
//                                             : ListView.builder(
//                                                 itemCount:
//                                                     snap.data!.docs.length,
//                                                 reverse: true,
//                                                 itemBuilder: (context, i) {
//                                                   return ChatWidgets
//                                                       .messagesCard(
//                                                           snap.data!.docs[i]
//                                                                   ['sent_by'] ==
//                                                               FirebaseAuth
//                                                                   .instance
//                                                                   .currentUser!
//                                                                   .uid,
//                                                           snap.data!.docs[i]
//                                                               ['message'],
//                                                           DateFormat('hh:mm a')
//                                                               .format(snap
//                                                                   .data!
//                                                                   .docs[i][
//                                                                       'datetime']
//                                                                   .toDate()),
//                                                           widget.image , snap.data!.docs[i]
//                                                                   ['type'] , context);
//                                                 },
//                                               );
//                                       });
//                             } else {
//                               return Center(
//                                 child: Text(
//                                   'No conversion found',
//                                   style: Styles.h1()
//                                       .copyWith(color: Colors.indigo.shade400),
//                                 ),
//                               );
//                             }
//                           } else {
//                             return const Center(
//                               child: CircularProgressIndicator(
//                                 color: Colors.indigo,
//                               ),
//                             );
//                           }
//                         }),
//                   ),
//                 ),
//                 InkWell(
//                   child: Container(
//                     color: Colors.transparent,
//                     child:
//                     ChatWidgets.messageField(
//                         context: context,
//                         onSubmit: onSubmit, onSubmitImage: onSubmitImage , focusNode: focusNode)
//
//                   ),
//                 ),
//                  ValueListenableBuilder<bool>(
//                          valueListenable: showTextField,
//             builder: (context, isShow, _) {
//               if (isShow) {
//                 return   SizedBox(height: _keyboardHeight);
//               } else {
//                 return const SizedBox(height: 0,);
//               }
//             }
//                  )
//
//
//               ],
//             ),
//           );
//
//           //blocked
//         } else {
//           return Scaffold(
//             resizeToAvoidBottomInset: true,
//             backgroundColor: ColorManager.whiteColor,
//             body: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Container(
//                   width: MediaQuery.of(context).size.width,
//                   height: ConfigSize.defaultSize! * 8,
//                   decoration: const BoxDecoration(
//                       gradient: LinearGradient(colors: [
//                     Color(0xFF0AB2A5),
//                     Color(0xFF29CC98),
//                     Color(0xFF3ADA94),
//                   ])),
//                   child: Center(
//                       child: Row(
//                     children: [
//                       const Spacer(
//                         flex: 1,
//                       ),
//                       InkWell(
//                           onTap: () {
//                             Navigator.pop(context);
//                           },
//                           child: const Icon(
//                             Icons.arrow_back_ios,
//                             color: ColorManager.whiteColor,
//                           )),
//                       const Spacer(
//                         flex: 3,
//                       ),
//                       InkWell(
//                           onTap: () {
//
//                           },
//                           child: UserImage(
//                               image: widget.image,
//                               imageSize: ConfigSize.defaultSize! * 4)),
//                       const Spacer(
//                         flex: 1,
//                       ),
//                       InkWell(
//                         onTap: () {
//
//                         },
//                         child: Text(
//                           widget.name,
//                           style: TextStyle(
//                               color: ColorManager.whiteColor,
//                               fontSize: ConfigSize.defaultSize! * 2),
//                         ),
//                       ),
//                       const Spacer(
//                         flex: 8,
//                       )
//                     ],
//                   )),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(18.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       const Spacer(),
//                       StreamBuilder(
//                           stream: firestore
//                               .collection('Users')
//                               .doc(widget.id)
//                               .snapshots(),
//                           builder: (context,
//                               AsyncSnapshot<
//                                       DocumentSnapshot<Map<String, dynamic>>>
//                                   snapshot) {
//                             return !snapshot.hasData
//                                 ? Container()
//                                 : Text(
//                                     'Last seen ' +
//                                         DateFormat('hh:mm a').format(snapshot
//                                             .data!['date_time']
//                                             .toDate()),
//                                     style: Styles.h1().copyWith(
//                                         fontSize: ConfigSize.defaultSize! + 3,
//                                         fontWeight: FontWeight.normal,
//                                         color: Colors.black),
//                                   );
//                           }),
//                       const Spacer(),
//                       const SizedBox(
//                         width: 50,
//                       )
//                     ],
//                   ),
//                 ),
//                 Expanded(
//                   child: Container(
//                     decoration: Styles.friendsBox(),
//                     child: StreamBuilder(
//                         stream: firestore.collection('Rooms').snapshots(),
//                         builder:
//                             (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//                           if (snapshot.hasData) {
//                             if (snapshot.data!.docs.isNotEmpty) {
//                               List<QueryDocumentSnapshot?> allData = snapshot
//                                   .data!.docs
//                                   .where((element) =>
//                                       element['users'].contains(widget.id) &&
//                                       element['users'].contains(FirebaseAuth
//                                           .instance.currentUser!.uid))
//                                   .toList();
//                               QueryDocumentSnapshot? data =
//                                   allData.isNotEmpty ? allData.first : null;
//                               if (data != null) {
//                                 roomId = data.id;
//                                 if (FirebaseAuth.instance.currentUser!.uid !=
//                                     data['sent_by']) {
//                                   firestore
//                                       .collection('Rooms')
//                                       .doc(roomId)
//                                       .update({'Read': true});
//                                 }
//                               }
//                               return data == null
//                                   ? Container()
//                                   : StreamBuilder(
//                                       stream: data.reference
//                                           .collection('messages')
//                                           .orderBy('datetime', descending: true)
//                                           .snapshots(),
//                                       builder: (context,
//                                           AsyncSnapshot<QuerySnapshot> snap) {
//                                         return !snap.hasData
//                                             ? Container()
//                                             : ListView.builder(
//                                                 itemCount:
//                                                     snap.data!.docs.length,
//                                                 reverse: true,
//                                                 itemBuilder: (context, i) {
//                                                   return ChatWidgets
//                                                       .messagesCard(
//                                                           snap.data!.docs[i]
//                                                                   ['sent_by'] ==
//                                                               FirebaseAuth
//                                                                   .instance
//                                                                   .currentUser!
//                                                                   .uid,
//                                                           snap.data!.docs[i]
//                                                               ['message'],
//                                                           DateFormat('hh:mm a')
//                                                               .format(snap
//                                                                   .data!
//                                                                   .docs[i][
//                                                                       'datetime']
//                                                                   .toDate()),
//                                                           widget.image , snap.data!.docs[i]
//                                                                   ['type'] , context);
//                                                 },
//                                               );
//                                       });
//                             } else {
//                               return Center(
//                                 child: Text(
//                                   'No conversion found',
//                                   style: Styles.h1()
//                                       .copyWith(color: Colors.indigo.shade400),
//                                 ),
//                               );
//                             }
//                           } else {
//                             return const Center(
//                               child: CircularProgressIndicator(
//                                 color: Colors.indigo,
//                               ),
//                             );
//                           }
//                         }),
//                   ),
//                 ),
//                 Container(
//                   color: Colors.white,
//                   child: ChatWidgets.messageField(
//                     context: context,
//                       onSubmitImage: onSubmitImage,
//                       onSubmit: (controller) {
//                         if (controller.text.toString() != '') {
//                           showDialog<String>(
//                             context: context,
//                             builder: (BuildContext context) => AlertDialog(
//                               title: Text(StringManager.blocked.tr()),
//                               content: Text(StringManager.youCanNotChat.tr()),
//                               actions: <Widget>[
//                                 TextButton(
//                                   onPressed: () => Navigator.pop(context, 'Ok'),
//                                   child: Text(StringManager.confirm.tr()),
//                                 ),
//                               ],
//                             ),
//                           );
//                         }
//                         controller.clear();
//                       },
//                       focusNode: focusNode
//                       ),
//                 )
//               ],
//             ),
//           );
//           // Scaffold(body: Column(children: [Spacer(flex: 9,), Image(image: AssetImage(AssetsPath.blockPic)),Spacer(flex: 1,),  Center(child: Text(StringManger.blocked.tr() , style: TextStyle(fontSize: ConfigSize.defaultSize!*2 , fontWeight: FontWeight.bold   ),)),Spacer(flex: 1,), Center(child: Text(StringManger.youCanNotChat.tr()))  ,Spacer(flex: 10,)],),);
//         }
//       },
//     );
//   }
// }
