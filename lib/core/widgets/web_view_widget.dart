



import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/widgets/pop_up_dialog.dart';
import 'package:webview_flutter/webview_flutter.dart';


class WebView extends StatefulWidget {
 final String url ;
 final String title ;
 final Color titleColor ;
  const WebView({required this.url,required this.title,required this.titleColor, Key? key}) : super(key: key);

  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebView>  with AutomaticKeepAliveClientMixin{
    WebViewController?  controller;


    @override
    bool get wantKeepAlive => false;
  @override
  void initState() {
    super.initState();
      controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setBackgroundColor(const Color(0x00000000))
        ..setNavigationDelegate(
          NavigationDelegate(
            onProgress: (int progress) {
              // Update loading bar.
            },
            onPageStarted: (String url) {

              log("url showing${url}");
            },
            onPageFinished: (String url) {
              log("onPageFinished $url");
              // Do something when page finished loading.
            },
            onWebResourceError: (WebResourceError error) {},
            onNavigationRequest: (NavigationRequest request) {
              log("NavigationRequest${request.url}");
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
     controller!.clearCache(); // Clear the WebView cache.
     controller = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
        onWillPop: () async {
          showDialog(context: context,
              builder: (context)
          {
            return PopUpDialog(
              headerText: StringManager.note.tr(),
              accpetText: () async {
                controller!.clearCache(); // Clear the WebView cache.
                controller!.clearLocalStorage();
                controller = null;
                Navigator.pop(context);
                Navigator.pop(context);
              },

            );
          });
          return false ;

    },
   child: Scaffold(
      appBar: AppBar(
        title:Text(widget.title ),
        backgroundColor:widget.titleColor ,
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: WebViewWidget(controller: controller!),
    ) );
  }
}
