import 'package:camera/camera.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tik_chat_v2/core/notifcation/constent_notifcatrion.dart';
import 'package:tik_chat_v2/core/notifcation/firebase_messaging_background.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/themes/dark_theme.dart';
import 'package:tik_chat_v2/core/resource_manger/themes/light_theme.dart';
import 'package:tik_chat_v2/core/service/service_locator.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/add_info_bloc/add_info_bloc.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/log_out_manager/log_out_bloc.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/login_with_phone_manager/login_with_phone_bloc.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/register_with_phone_manager/register_with_phone_bloc.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/sign_in_with_paltform_manager/sign_in_with_platform_bloc.dart';
import 'package:tik_chat_v2/features/home/presentation/component/create_live/video/create_video_live_body.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_my_data_manager/get_my_data_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/mall_buy_manager/mall_buy_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/mall_manager/mall_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/mall_manager/mall_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_use_item/use_item_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manger_buy_send_vip/bloc/buy_or_send_vip_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manger_vip_center/vip_center_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manger_vip_center/vip_center_events.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/my_bag_manager/my_bag_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/my_bag_manager/my_bag_event.dart';
import 'package:tik_chat_v2/firebase_options.dart';

Future <void> main() async{
    WidgetsFlutterBinding.ensureInitialized();
    CreateLiveVideoBody.cameras = await availableCameras();
     await Permission.notification.isDenied.then((value) {
    if (value) {
      Permission.notification.request();
    }
  });
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  tokenDevices = await FirebaseMessaging.instance.getToken();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    await ServerLocator().init();

  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return  MultiBlocProvider(
      providers: [
             BlocProvider(
              create: (context) => getIt<SignInWithPlatformBloc>(),
            ),

        BlocProvider(
              create: (context) => getIt<AddInfoBloc>(),
            ),
            
               BlocProvider(
              create: (context) => getIt<RegisterWithPhoneBloc>(),
            ),
                    BlocProvider(
              create: (context) => getIt<LoginWithPhoneBloc>(),
            ),
                       BlocProvider(
              create: (context) => getIt<LogOutBloc>(),
            ),
                           BlocProvider(
              create: (context) => getIt<GetMyDataBloc>(),
            ),

                              BlocProvider(
              create: (context) => getIt<MallBloc>()..add(const GetCarMallEvent(type: 6))
        ..add(const GetFramesMallEvent(type: 4))
        ..add(const GetBubbleMallEvent(type: 5)),
            ),

                                BlocProvider(
              create: (context) => getIt<MallBuyBloc>(),
            ),
                                      BlocProvider(
              create: (context) => getIt<MyBagBloc>() ..add(const GetFramesMyBagEvent(type: "4"))
            ..add(const GetEntrieMyBagEvent(type: '6'))
            ..add(const GetBubbleBackPackMyBagEvent(type: "5")),
            ),
                      BlocProvider(
              create: (context) => getIt<UseItemBloc>(),
            ),
                      BlocProvider(
              create: (context) =>
                  getIt<VipCenterBloc>()..add(GetVipCenterEvent()),
            ),
                          BlocProvider(
              create: (context) =>
                  getIt<BuyOrSendVipBloc>(),
            ),
            
            
      ],
      child: MaterialApp(
       debugShowCheckedModeBanner: false,
       theme: lightTheme,
       darkTheme: darkTheme,

                  onGenerateRoute: RouteGenerator.getRoute,
                  initialRoute: Routes.splash,

      ),
    );
  }
}


