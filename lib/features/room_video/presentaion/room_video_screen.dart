


import 'package:flutter/material.dart';


class RoomVideoScreen extends StatefulWidget {
  const RoomVideoScreen({Key? key}) : super(key: key);

  @override
  _RoomVideoScreenState createState() => _RoomVideoScreenState();
}

class _RoomVideoScreenState extends State<RoomVideoScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:SizedBox()
      // ZegoUIKitPrebuiltLiveStreaming(
      //   appID: appID, // Fill in the appID that you get from ZEGOCLOUD Admin Console.
      //   appSign: appSign, // Fill in the appSign that you get from ZEGOCLOUD Admin Console.
      //   userID: 'user_id',
      //   userName: 'user_name',
      //   liveID: liveID,
      //   config: isHost
      //       ? ZegoUIKitPrebuiltLiveStreamingConfig.host(
      //     plugins: [ZegoUIKitSignalingPlugin()],
      //   )
      //       : ZegoUIKitPrebuiltLiveStreamingConfig.audience(
      //     plugins: [ZegoUIKitSignalingPlugin()],
      //   ),
      // ),
    );
  }
}
