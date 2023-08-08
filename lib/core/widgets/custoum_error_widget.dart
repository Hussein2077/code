import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

class CustoumErrorWidget extends StatefulWidget {
  final String message;
  const CustoumErrorWidget({required this.message, super.key});

  @override
  State<CustoumErrorWidget> createState() => _CustoumErrorWidgetState();
}

class _CustoumErrorWidgetState extends State<CustoumErrorWidget> {
  bool conect = false;
  @override
  void initState() {
    checkInternetConnectivity();
    super.initState();
  }

  Future<bool> checkInternetConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());

    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      setState(() {});
      conect = true;
      return true;
    } else {
      setState(() {});
      conect = false;
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: conect
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(AssetsPath.serverError ,),
                      
                      Text(
                        widget.message,
                        style: TextStyle(color: Colors.black , fontSize: ConfigSize.defaultSize!*2),
                      )
                    ],
                  ),
                )
              : Center(
                  child: Image.asset(AssetsPath.netError ,),
                )),
    );
  }
}
