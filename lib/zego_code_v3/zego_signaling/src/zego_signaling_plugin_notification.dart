part of '../zego_uikit_signaling_plugin.dart';

/// @nodoc
class ZegoSignalingPluginNotificationAPIImpl
    implements ZegoSignalingPluginNotificationAPI {

  @override
  Future<ZegoSignalingPluginEnableNotifyResult>
  enableNotifyWhenAppRunningInBackgroundOrQuit({bool? isIOSSandboxEnvironment,
    bool enableIOSVoIP = true,
    ZegoSignalingPluginMultiCertificate certificateIndex = ZegoSignalingPluginMultiCertificate.firstCertificate,
    String appName = '', String androidChannelID = '',
    String androidChannelName = '', String androidSound = ''})async {

      ZegoSignalingLoggerService.logInfo(
        'enable Notify When App Running In Background Or Quit, '
        'is iOS Sandbox Environment:$isIOSSandboxEnvironment, '
        'enable iOS VoIP:$enableIOSVoIP, '
        'certificate index:$certificateIndex, '
        'appName: $appName, '
        'androidChannelID: $androidChannelID, '
        'androidChannelName: $androidChannelName, '
        'androidSound: $androidSound',
        tag: 'signaling',
        subTag: 'notification',
      );

      if ((Platform.isAndroid) && (Platform.isIOS)) {
        ZegoSignalingLoggerService.logInfo(
          'Only Support Android And iOS Platform.',
          tag: 'signaling',
          subTag: 'notification',
        );

        return await ZegoSignalingPluginEnableNotifyResult(
          error: PlatformException(
            code: '-1',
            message: 'Only Support Android And iOS Platform.',
          ),
        );
      }

      try {
        var zpnsConfig = ZPNsConfig();
        if (!kIsWeb && Platform.isAndroid) {
          final notificationChannel = ZPNsNotificationChannel();
          notificationChannel.channelID = androidChannelID;
          notificationChannel.channelName = androidChannelName;
          notificationChannel.androidSound = androidSound;
          await ZPNs.getInstance().createNotificationChannel(notificationChannel);

          zpnsConfig.enableFCMPush = true;
        } else if (!kIsWeb && Platform.isIOS) {
          await ZPNs.getInstance().applyNotificationPermission();
        }
        zpnsConfig.appType = certificateIndex.index;
        await ZPNs.setPushConfig(zpnsConfig);

        await ZPNs.getInstance().registerPush(
          iOSEnvironment: (isIOSSandboxEnvironment??false)
              ? ZPNsIOSEnvironment.Development
              : ZPNsIOSEnvironment.Production,
          enableIOSVoIP: enableIOSVoIP,
        );
        ZegoSignalingLoggerService.logInfo(
          'register push done',
          tag: 'signaling',
          subTag: 'notification',
        );
        return const ZegoSignalingPluginEnableNotifyResult();
      } catch (e) {
        ZegoSignalingLoggerService.logInfo(
          'register push, error:${e.toString()}',
          tag: 'signaling',
          subTag: 'notification',
        );

        if (e is PlatformException) {
          return ZegoSignalingPluginEnableNotifyResult(
            error: PlatformException(
              code: e.code,
              message: e.message,
            ),
          );
        } else {
          return ZegoSignalingPluginEnableNotifyResult(
            error: PlatformException(
              code: '-2',
              message: e.toString(),
            ),
          );
        }
      }
  }

  @override
  Future<void> activeAppToForeground() {
    // TODO: implement activeAppToForeground
    throw UnimplementedError();
  }

  @override
  Future<void> addLocalNotification(ZegoSignalingPluginOutgoingNotificationConfig config) {
    // TODO: implement addLocalNotification
    throw UnimplementedError();
  }

  @override
  Future<void> createNotificationChannel(ZegoSignalingPluginOutgoingNotificationChannelConfig config) {
    // TODO: implement createNotificationChannel
    throw UnimplementedError();
  }

  @override
  Future<void> dismissAllNotifications() {
    // TODO: implement dismissAllNotifications
    throw UnimplementedError();
  }

  @override
  Future<void> requestDismissKeyguard() {
    // TODO: implement requestDismissKeyguard
    throw UnimplementedError();
  }
}

  @override
  Future<void> activeAppToForeground() {
    // TODO: implement activeAppToForeground
    throw UnimplementedError();
  }

  @override
  Future<void> addLocalNotification(ZegoSignalingPluginOutgoingNotificationConfig config) {
    // TODO: implement addLocalNotification
    throw UnimplementedError();
  }

  @override
  Future<void> createNotificationChannel(ZegoSignalingPluginOutgoingNotificationChannelConfig config) {
    // TODO: implement createNotificationChannel
    throw UnimplementedError();
  }

  @override
  Future<void> dismissAllNotifications() {
    // TODO: implement dismissAllNotifications
    throw UnimplementedError();
  }

  @override
  Future<void> requestDismissKeyguard() {
    // TODO: implement requestDismissKeyguard
    throw UnimplementedError();
  }



/// @nodoc
class ZegoSignalingPluginNotificationEventImpl
    implements ZegoSignalingPluginNotificationEvent {
  @override
  Stream<ZegoSignalingPluginNotificationArrivedEvent>
      getNotificationArrivedEventStream() {
    return ZegoSignalingPluginCore()
        .eventCenter
        .notificationArrivedEvent
        .stream;
  }

  @override
  Stream<ZegoSignalingPluginNotificationClickedEvent>
      getNotificationClickedEventStream() {
    return ZegoSignalingPluginCore()
        .eventCenter
        .notificationClickedEvent
        .stream;
  }

  @override
  Stream<ZegoSignalingPluginNotificationRegisteredEvent>
      getNotificationRegisteredEventStream() {
    return ZegoSignalingPluginCore()
        .eventCenter
        .notificationRegisteredEvent
        .stream;
  }
}
