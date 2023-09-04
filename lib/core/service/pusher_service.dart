import 'dart:convert';
import 'dart:developer';

// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';
import 'package:tik_chat_v2/core/utils/api_healper/methods.dart';

class PusherService {

  PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();

  /// Init Pusher Listener
 initPusher(String appKey, String host, int port, String cluster) async {
   try {
     await pusher.init(
         cluster: cluster,
         apiKey: 'd0344cbe6b1489f567f0',
         onConnectionStateChange:onConnectionStateChange,
         onError: onError,
         onSubscriptionSucceeded: onSubscriptionSucceeded,
         onEvent: onEvent,
         onSubscriptionError: onSubscriptionError,
         onDecryptionFailure: onDecryptionFailure,
         onMemberAdded: onMemberAdded,
         onMemberRemoved: onMemberRemoved,
         onSubscriptionCount: onSubscriptionCount,
         authEndpoint:'https://tik-chat.com/api/broadcasting/auth',
         onAuthorizer: onAuthorizer
     );
   } catch (e) {
     log("ERROR: $e");
   }
 }

 void onConnectionStateChange(dynamic currentState, dynamic previousState) {
   log("Connection: $currentState");
 }

 void onError(String message, int? code, dynamic e) {
   log("onError: $message code: $code exception: $e");
 }

 void onEvent(PusherEvent event) {
   log("onEvent: $event");
 }

 void onSubscriptionSucceeded(String channelName, dynamic data) {
   log("onSubscriptionSucceeded: $channelName data: $data");
   final me = pusher.getChannel(channelName)?.me;
   log("Me: $me");
 }

 void onSubscriptionError(String message, dynamic e) {
   log("onSubscriptionError: $message Exception: $e");
 }

 void onDecryptionFailure(String event, String reason) {
   log("onDecryptionFailure: $event reason: $reason");
 }

 void onMemberAdded(String channelName, PusherMember member) {
   log("onMemberAdded: $channelName user: $member");
 }

 void onMemberRemoved(String channelName, PusherMember member) {
   log("onMemberRemoved: $channelName user: $member");
 }

 void onSubscriptionCount(String channelName, int subscriptionCount) {
   log("onSubscriptionCount: $channelName subscriptionCount: $subscriptionCount");
 }

 dynamic onAuthorizer(
     String channelName, String socketId, dynamic options) async {
   String token = await Methods().returnUserToken();
   var authUrl = 'https://tik-chat.com/api/broadcasting/auth';
   var result = await http.post(
     Uri.parse(authUrl),
     headers: {
       'Content-Type': 'application/x-www-form-urlencoded',
       'Authorization': 'Bearer $token',
     },
     body: 'socket_id=$socketId&channel_name=$channelName',
   );
   var json = jsonDecode(result.body);
   return json;
 }


}



