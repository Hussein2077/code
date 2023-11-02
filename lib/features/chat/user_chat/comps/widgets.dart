import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/utils/api_healper/constant_api.dart';
import 'package:tik_chat_v2/core/widgets/user_image.dart';
import 'package:tik_chat_v2/features/chat/user_chat/comps/animated-dialog.dart';

import '../../../../core/utils/config_size.dart';
import 'styles.dart';

class ChatWidgets {

  static Widget card(
      {title,
      time,
      subtitle,
      onTap,
      image,
      cheakRead,
      sentby,
      unReadMessages,
      context,
      }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          color: Theme.of(context).colorScheme.primary.withOpacity(0.3),
          elevation: 0,
          child: InkWell(
            onTap: onTap,
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    showImageViewer(
                        context,
                        CachedNetworkImageProvider(
                          ConstentApi().getImage(image),
                        ),
                        swipeDismissible: false);
                  },
                  child: UserImage(
                      image: image, imageSize: ConfigSize.defaultSize! * 6),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(

                          color:Colors.white ,
                        fontSize: ConfigSize.defaultSize!*1.8
                      ),
                    ),
                    SizedBox(
                      width: ConfigSize.screenWidth!*0.5,
                      child: Text(
                        subtitle,
                        style: TextStyle(

                            color:Colors.white ,
                            fontSize: ConfigSize.defaultSize!*1.4
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const Spacer(
                  flex: 5,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (unReadMessages != 0 &&
                        sentby != FirebaseAuth.instance.currentUser!.uid)
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.red),
                        child: Text(
                          '${unReadMessages}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    SizedBox(
                      height: ConfigSize.defaultSize!,
                    ),
                    Text(
                      time,
                      style: (unReadMessages != 0 &&
                              sentby != FirebaseAuth.instance.currentUser!.uid)
                          ? const TextStyle(color: Colors.red, fontSize: 12)
                          : const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                const Spacer(
                  flex: 1,
                ),
              ],
            ),
          )

          // ListTile(
          //     onTap: onTap,
          //     contentPadding: const EdgeInsets.all(5),
          //     leading:
          //     InkWell(
          //       onTap: (){
          //
          //         showImageViewer(
          //             context,
          //             CachedNetworkImageProvider(
          //               ConstentApi().getImage(image),
          //             ),
          //             swipeDismissible: false);
          //       },
          //       child: UserImage(
          //           image:image,
          //           imageSize: ConfigSize.defaultSize! * 7),
          //     ),
          //     title: Text( title,style: Theme.of(context).textTheme.bodyLarge!,),
          //     subtitle: subtitle != null ? Text(subtitle) : null,
          //     trailing:
          //     Column(
          //       mainAxisAlignment: MainAxisAlignment.end,
          //       children: [
          //         if (unReadMessages != 0 &&
          //             sentby != FirebaseAuth.instance.currentUser!.uid)
          //           Container(
          //             padding: const EdgeInsets.all(4),
          //             decoration: const BoxDecoration(
          //                 shape: BoxShape.circle, color: Colors.red),
          //             child: Text(
          //               '${unReadMessages}',
          //               style: const TextStyle(
          //                 color: Colors.white,
          //                 fontSize: 12,
          //               ),
          //               textAlign: TextAlign.center,
          //             ),
          //           ),
          //         SizedBox(
          //           height: ConfigSize.defaultSize!,
          //         ),
          //         Text(
          //           time,
          //           style: (unReadMessages != 0 &&
          //                   sentby != FirebaseAuth.instance.currentUser!.uid)
          //               ? const TextStyle(color: Colors.red, fontSize: 12)
          //               : const TextStyle(color: Colors.black),
          //         ),
          //       ],
          //     )),
          ),
    );
  }

  static Widget circleProfile({onTap, name}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: InkWell(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 25,
              backgroundColor: Colors.grey,
              child: Icon(
                Icons.person,
                size: 40,
                color: Colors.white,
              ),
            ),
            SizedBox(
                width: 50,
                child: Center(
                    child: Text(
                  name,
                  style: TextStyle(
                      height: 1.5,
                      fontSize: ConfigSize.defaultSize! + 3,
                      color: Colors.white),
                  overflow: TextOverflow.ellipsis,
                )))
          ],
        ),
      ),
    );
  }

  static Widget messagesCard(
      bool check, message, time, image, type, BuildContext context) {
    return type == 'image'
        ? Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (check) const Spacer(),
              if (!check)
                Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: NetworkImage(
                            ConstentApi().getImage(image),
                          ),
                          fit: BoxFit.fill)),
                  width: ConfigSize.defaultSize! * 5,
                  height: ConfigSize.defaultSize! * 5,
                ),
              GestureDetector(
                  onTap: ()  {
                    showImageViewer(
                        context,
                        CachedNetworkImageProvider(
                        message,
                    ),
                    );
                  },
                  child: Padding(
                    padding: EdgeInsets.only(top: ConfigSize.defaultSize!),
                    child: Stack(
                      children: [
                        Card(
                          shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular( ConfigSize.defaultSize! * 2)),
                          elevation: 10,
                          child: Container(
                            
                             width: ConfigSize.defaultSize! * 22,
                            height: ConfigSize.defaultSize! * 22,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    ConfigSize.defaultSize! * 2),
                                    color: check ? ColorManager.orang: Colors.grey.shade300
                                    ),
                          ),
                        ),
                     Container(
                          margin: EdgeInsets.only(left: ConfigSize.defaultSize!+4 , top: ConfigSize.defaultSize!),
                          width: ConfigSize.defaultSize! * 20,
                          height: ConfigSize.defaultSize! * 20,
                          padding: EdgeInsets.symmetric(
                              vertical: ConfigSize.defaultSize!,
                              horizontal: ConfigSize.defaultSize!),
                          child:    message==""? CircularProgressIndicator():Image.network(
                            message,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ],
                    ),
                  ))
            ],
          )
        : Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (check) const Spacer(),
                if (!check)
                  Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: NetworkImage(
                              ConstentApi().getImage(image),
                            ),
                            fit: BoxFit.fill)),
                    width: ConfigSize.defaultSize! * 5,
                    height: ConfigSize.defaultSize! * 5,
                  ),
                ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 250),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(ConfigSize.defaultSize! * 2)),
                    elevation: 5,
                    child: Container(
                      // margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.all(10),
                      decoration: Styles.messagesCardStyle(check),
                      child: SelectableText(
                        '$message',
                        style: TextStyle(
                            color: check ? Colors.black : Colors.black,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
                if (!check) const Spacer(),
              ],
            ),
          );
  }

  static messageField(
      {required onSubmitImage,
      required onSubmit,
      // required dynamic Function(TextEditingController) onSubmit ,
      required FocusNode focusNode,
      required BuildContext context}) {
    final con = TextEditingController();

    return Container(
      width: ConfigSize.screenWidth,
      height: ConfigSize.screenHeight! * 0.06,
      margin: const EdgeInsets.all(5),
      //decoration: Styles.messageFieldCardStyle(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: ConfigSize.screenWidth! * 0.82,
            height: ConfigSize.screenHeight! * 0.06,
            child: TextField(
              focusNode: focusNode,
              textInputAction: TextInputAction.done,
              onSubmitted: (value) {
                onSubmit(con);
              },
              controller: con,
              decoration: Styles.messageTextFieldStyle(
                  onSubmitImage: () {
                    onSubmitImage();
                  },
                  onSubmit: () {
                    onSubmit(con);
                  },
                  context: context),
            ),
          ),
          InkWell(
            onTap: () {
              onSubmit(con);
            },
            child: Container(
              width: ConfigSize.screenHeight! * 0.06,
              height: ConfigSize.screenHeight! * 0.06,
              decoration: BoxDecoration(
                color:  Theme.of(context).colorScheme.primary.withOpacity(0.8),
                borderRadius: BorderRadius.all(
                    Radius.circular(ConfigSize.defaultSize! * 5)),
                border:Border.all(color: Theme.of(context).colorScheme.primary),
              ),
              child: const Icon(
                Icons.send,
                color: ColorManager.orang,
              ),
            ),
          )
        ],
      ),
    );
  }

  static drawer(context) {
    return Drawer(
      backgroundColor: Colors.indigo.shade400,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 20),
          child: Theme(
            data: ThemeData.dark(),
            child: Column(
              children: [
                const CircleAvatar(
                  child: Icon(
                    Icons.person,
                    size: 60,
                    color: Colors.white,
                  ),
                  radius: 60,
                  backgroundColor: Colors.grey,
                ),
                const SizedBox(height: 10),
                const Divider(
                  color: Colors.white,
                ),
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text('Profile'),
                  onTap: () {
                    // Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileScreen()));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('Logout'),
                  onTap: () async => await FirebaseAuth.instance.signOut(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  static searchBar(
    bool open,
  ) {
    return AnimatedDialog(
      height: open ? 800 : 0,
      width: open ? 400 : 0,
    );
  }

  static searchField({Function(String)? onChange}) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: TextField(
        onChanged: onChange,
        decoration: Styles.searchTextFieldStyle(),
      ),
      decoration: Styles.messageFieldCardStyle(),
    );
  }
}
