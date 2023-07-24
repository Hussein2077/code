import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tik_chat_v2/features/auth/presentation/component/add_info/add_info_screen.dart';
import 'package:tik_chat_v2/features/auth/presentation/component/otp/otp_screen.dart';
import 'package:tik_chat_v2/features/auth/presentation/component/sign_up/sign_up_screen.dart';
import 'package:tik_chat_v2/features/auth/presentation/login_screen.dart';
import 'package:tik_chat_v2/features/home/presentation/component/create_live/create_live_screen.dart';
import 'package:tik_chat_v2/features/home/presentation/component/create_live/reels/component/upload_reels/upload_reels_screen.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/coins/coins_scrren.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/custom_service/custoum_service_screen.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/f_f_f_v_screens/f_f_f_v_screen.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/family/component/family_profile/component/family_member/family_member_screen.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/family/component/family_profile/component/family_requests/family_requests_screen.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/family/component/family_profile/family_profile_screen.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/family/family_ranking_screen.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/level/level_screen.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/mall/mall_screen.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/my_bag/my_bag_screen.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/settings/component/language_screen/language_screen.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/settings/component/mode_screen/mode_screen.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/settings/settings_screen.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/user_profile/component/edit_info/edit_info_screen.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/user_profile/component/gift_gallery/gift_gallery_screen.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/user_profile/user_profile.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/vip/vip_screen.dart';
import 'package:tik_chat_v2/main_screen/main_screen.dart';
import 'package:tik_chat_v2/splash.dart';

import '../../features/home/presentation/component/top_users/top_user_screen.dart';

class Routes {
  static const String splash = "/Splash";
  static const String login = "/login";
  static const String otp = "/Otp";
  static const String addInfo = "/AddInfo";
  static const String mainScreen = "/MainScreen";

  static const String topUsersScreen = "/TopUsersScreen";
  static const String userProfile = "/UserProfile";
  static const String giftGallery = "/GiftGallery";
  static const String editInfo = "/EditInfo";

  static const String fffv = "/fffv";

  static const String coins = "/Coins";

  static const String myBag = "/MyBag";

  static const String mall = "/Mall";
  static const String level = "/level";
  static const String vip = "/Vip";

  static const String familyRanking = "/FamilyRanking";
  static const String familyProfile = "/familyProfile";

  static const String custoumService = "/CustoumService";
  static const String settings = "/Settings";
  static const String language = "/Language";

  static const String mode = "/Mode";

  static const String familyRequests = "/FamilyRequests";
  static const String familyMembers = "/FamilyMembers";
  static const String createLive = "/CreateLive";
    static const String uploadReels = "/UploadReels";
        static const String signUp = "/SignUp";


}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case Routes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case Routes.otp:
              OtpScreenParameter otpScreenParameter =
            settings.arguments as OtpScreenParameter;
        return MaterialPageRoute(builder: (_) =>  OtpScreen(
          codeCountry: otpScreenParameter.codeCountry,
                  phone: otpScreenParameter.phone,
                  password: otpScreenParameter.password,
        ));

      case Routes.addInfo:
              GoogleSignInAccount googleData = settings.arguments as GoogleSignInAccount;

        return MaterialPageRoute(builder: (_) =>  AddInfoScreen( googleData:googleData ,));

      case Routes.mainScreen:
        return MaterialPageRoute(builder: (_) => const MainScreen());
      case Routes.topUsersScreen:
        return MaterialPageRoute(builder: (_) => const TopUsersScreen());
      case Routes.userProfile:
        return MaterialPageRoute(builder: (_) => const UserProfile());
      case Routes.giftGallery:
        return MaterialPageRoute(builder: (_) => const GiftGallery());
      case Routes.editInfo:
        return MaterialPageRoute(builder: (_) => const EditInfoScreen());
      case Routes.fffv:
        String title = settings.arguments as String;

        return MaterialPageRoute(
            builder: (_) => FFFVScreen(
                  title: title,
                ));
      case Routes.coins:
        String type = settings.arguments as String;

        return MaterialPageRoute(
            builder: (_) => CoinsScreen(
                  type: type,
                ));
      case Routes.myBag:
        return MaterialPageRoute(builder: (_) => const MyBagScreen());
      case Routes.mall:
        return MaterialPageRoute(builder: (_) => const MallScreen());
      case Routes.level:
        return MaterialPageRoute(builder: (_) => const LevelScreen());
      case Routes.vip:
        return MaterialPageRoute(builder: (_) => const VipScreen());
      case Routes.familyRanking:
        return MaterialPageRoute(builder: (_) => const FamilyRankingScreen());
      case Routes.familyProfile:
        return MaterialPageRoute(builder: (_) => const FamilyProfileScreen());
      case Routes.custoumService:
        return MaterialPageRoute(builder: (_) => const CustoumServiceScreen());

      case Routes.settings:
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
      case Routes.language:
        return MaterialPageRoute(builder: (_) => const LanguageScreen());
      case Routes.mode:
        return MaterialPageRoute(builder: (_) => const ModeScreen());
      case Routes.familyRequests:
        return MaterialPageRoute(builder: (_) => const FamilyRequestsScreen());

      case Routes.familyMembers:
        return MaterialPageRoute(builder: (_) => const FamilyMemberScreen());
      case Routes.createLive:
        return MaterialPageRoute(builder: (_) => const CreateLiveScreen());
        case Routes.uploadReels:
        return MaterialPageRoute(builder: (_) => const UploadReelsScreen());
           case Routes.signUp:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
    }

    return unDefinedRoute();
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        // ignore: prefer_const_constructors
        builder: (context) => Container());
  }
}


class OtpScreenParameter {
  final String phone;
  final String password;
  final String codeCountry;

  const OtpScreenParameter(
      {required this.codeCountry, required this.password, required this.phone});
}