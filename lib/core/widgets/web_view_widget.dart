



import 'dart:convert';
import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/widgets/pop_up_dialog.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_my_data_manager/get_my_data_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_my_data_manager/get_my_data_event.dart';
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

            },
            onPageFinished: (String url) {
              if (url.contains('reference_id')) {
                controller!.
                runJavaScriptReturningResult("(function(){Flutter.postMessage(window.document.body.innerText)})();");
              }
              log("onPageFinished $url");
              // Do something when page finished loading.
            },
            onWebResourceError: (WebResourceError error) {},
            onUrlChange: (UrlChange){
              UrlChange.url;
            },
            onNavigationRequest: (NavigationRequest request) {
              //todo handle that
              if (request.url.startsWith('https://www.youtube.com/')) {
                return NavigationDecision.prevent;
              }
              return NavigationDecision.navigate;
            },
          ),
        )..addJavaScriptChannel('Flutter',
            onMessageReceived: (JavaScriptMessage message) {
              final pageBody = jsonDecode(message.message);
              if(pageBody['status'] == 'SUCCESS'){
                BlocProvider.of<GetMyDataBloc>(context).add(GetMyDataEvent());
                Navigator.pushNamedAndRemoveUntil(context, Routes.mainScreen,(route) => false);
              }else if (pageBody['status'] =='FAIL'){
                errorToast(context: context, title: StringManager.errorInPayment.tr());
                Navigator.pushNamedAndRemoveUntil(context, Routes.mainScreen,(route) => false);

              }else{
                errorToast(context: context, title: StringManager.errorInPayment.tr());
                Navigator.pushNamedAndRemoveUntil(context, Routes.mainScreen,(route) => false);

              }

              print('page body: $pageBody');
            })
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
