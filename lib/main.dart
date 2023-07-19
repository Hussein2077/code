import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resours_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resours_manger/themes/dark_theme.dart';
import 'package:tik_chat_v2/core/resours_manger/themes/light_theme.dart';
import 'package:tik_chat_v2/core/service/service_locator.dart';
import 'package:tik_chat_v2/features/home/presentation/component/create_live/video/create_video_live_body.dart';

Future <void> main() async{
    WidgetsFlutterBinding.ensureInitialized();
    CreateLiveVideoBody.cameras = await availableCameras();
    await ServerLocator().init();

  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return  MaterialApp(
      
     debugShowCheckedModeBanner: false,
     theme: lightTheme,
     darkTheme: darkTheme,

                onGenerateRoute: RouteGenerator.getRoute,
                initialRoute: Routes.splash,

    );
  }
}


