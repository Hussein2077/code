import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/widgets/Dailog_Method.dart';
import 'package:tik_chat_v2/core/widgets/dilog_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';




class WebViewInRoom extends StatefulWidget {
  final String url ;
  const WebViewInRoom({required this.url,Key? key}) : super(key: key);

  @override
  _WebViewInRoomState createState() => _WebViewInRoomState();
}

class _WebViewInRoomState extends State<WebViewInRoom> {
  WebViewController?  controller;


  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.transparent)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
           log("progress"+progress.toString());
          },
          onPageStarted: (String url) {
            dailogRoom(
                context: context,
                widget: const DilogLoadingWidget());
          },
          onPageFinished: (String url) {
            Navigator.pop(context);
          },
          onWebResourceError: (WebResourceError error) {
            log(error.description);
            // dailogRoom(
            //     context: context,
            //     widget:  CustomErrorWidget(text: StringManager.somethingWrong.tr()));
          },
          onNavigationRequest: (NavigationRequest request) {
            //todo handle that
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },

        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  void dispose() {

    controller!.goBack();

    controller = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return WillPopScope(
        onWillPop: () async {
          if ( await controller!.canGoBack()) {
            controller!.goBack();
            return false;
          }
          controller!.goBack();

          Navigator.pop(context);
          return false;
        },
        child: Stack(
          children: [
            WebViewWidget(
                 controller: controller!
            ),
            IconButton(onPressed: ()async{
              if ( await controller!.canGoBack()) {
              controller!.goBack();
              }
              controller!.goBack();
              Navigator.pop(context);
            }, icon: const Icon(Icons.arrow_back_ios, color: Colors.white,)),
          ],
        ),
         );
  }
}
