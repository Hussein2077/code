



import 'package:flutter/material.dart';
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
            onPageStarted: (String url) {},
            onPageFinished: (String url) {
              // Do something when page finished loading.
            },
            onWebResourceError: (WebResourceError error) {},
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
     controller!.clearCache(); // Clear the WebView cache.
     controller = null;
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return WillPopScope(
        onWillPop: () async {
//todo update that by jako
//           showDialog<void>(
//             context: context,
//             barrierDismissible: true, // user must tap button!
//             builder: (BuildContext context) {
//               return AlertDialog(
//                 title: Text(StringManager.note.tr()),
//                 content: Text(StringManager.areYouSureExitGame.tr()),
//                 actions: <Widget>[
//                   TextButton(
//                     child: Text(StringManager.cancle.tr(),
//                         style: const TextStyle(
//                           color: ColorManager.blackColor,
//                         )),
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                     },
//                   ),
//                   TextButton(
//                     child: Text(
//                       StringManager.ok.tr(),
//                       style: const TextStyle(
//                         color: ColorManager.blackColor,
//                       ),
//                     ),
//                     onPressed: () async {
//                       controller!.clearCache(); // Clear the WebView cache.
//                       controller!.clearLocalStorage();
//
//                       controller = null;
//                      // controller!.goBack();
//                    //   String token = await Methods().returnUserToken() ;
//                       Navigator.pop(context);
//                       Navigator.pop(context);
//                    //   Navigator.pushReplacementNamed(context, Routes.games,arguments: token) ;
//
//                     },
//                   ),
//                 ],
//               );
//             },
//           );
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
