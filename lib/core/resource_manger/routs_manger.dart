import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tik_chat_v2/core/model/owner_data_model.dart';
import 'package:tik_chat_v2/features/auth/presentation/component/add_info/add_info_screen.dart';
import 'package:tik_chat_v2/features/auth/presentation/component/otp/otp_screen.dart';
import 'package:tik_chat_v2/features/auth/presentation/component/sign_up/sign_up_screen.dart';
import 'package:tik_chat_v2/features/auth/presentation/login_screen.dart';
import 'package:tik_chat_v2/features/home/presentation/component/create_live/create_live_screen.dart';
import 'package:tik_chat_v2/features/home/presentation/component/create_live/reels/component/upload_reels/upload_reels_screen.dart';
import 'package:tik_chat_v2/features/home/presentation/component/search/search_screen.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/ageince_screen/agency_screen.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/ageince_screen/component/agency_members_screen/agency_members_screen.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/ageince_screen/component/charging_from_sysytem_screen/charging_from_sysytem_screen.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/ageince_screen/component/join_requests_screen/join_requests_screen.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/ageince_screen/component/reportes_screen/reportes_screen.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/ageince_screen/component/shipping_from_agency_screen/shipping_from_agency.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/coins/coins_scrren.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/custom_service/custoum_service_screen.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/f_f_f_v_screens/f_f_f_screen.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/f_f_f_v_screens/vistor_screen.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/family/component/family_profile/component/family_delete/delete_screen.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/family/component/family_profile/component/family_member/family_member_screen.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/family/component/family_profile/component/family_requests/family_requests_screen.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/family/component/family_profile/family_profile_screen.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/family/family_ranking_screen.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/income_screen/income_screen.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/income_screen/component/Instructions_agency_screen/component/request_agency_screen/request_to_join_agency_screen.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/income_screen/component/Instructions_agency_screen/instruction.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/income_screen/component/exchange_for_gold_screen/exchange_for_gold.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/income_screen/component/live_report_screen/live_report_screen.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/income_screen/component/withdrawal_screen/component/details_screen.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/income_screen/component/withdrawal_screen/withdrawal_screen.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/level/level_screen.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/mall/mall_screen.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/my_bag/my_bag_screen.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/settings/component/language_screen/language_screen.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/settings/component/linking_screen/component/phone/otp_bind_screen.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/settings/component/linking_screen/component/phone/phone_number_bind_screen.dart';
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

  static const String fff = "/fff";

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

  static const String deleteFamily = "/DeleteFamily";

  static const String instructionsScreen = "/instructionsScreen";
  static const String incomeScreen = "/IncomeScreen";
  static const String joinToAgencyScreen = "/joinToAgencyScreen";
  static const String liveReportScreen = "/liveReportScreen";
  static const String exchangeForGoldScreen = "/exchangeForGoldScreen";
  static const String vistorScreen = "/VistorScreen";
  static const String phoneBindScreen = "/phoneBind";
  static const String otpBindScreen = "/otpBindScreen";
  static const String searchScreen = "/SearchScreen";
  static const String cashWithdrawal = "/cashWithdrawal";
  static const String detailsWithdrawal = "/detailsWithdrawal";
  static const String agencyScreen = "/agenceScreen";

  static const String agencyMemberScreen = "/AgencyMembersScreen";
    static const String agencyRequestsScreen = "/AgencyRequestsScreen";

    static const String agencyRepoertsScreen = "/AgencyRepoertsScreen";

      static const String charchingCoinsForUsers = "/CharchingCoinsForUsers";

        static const String charchingDolarsForUsers = "/CharchingDolarsForUsers";


}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case Routes.login:
        LoginPramiter? loginPramiter = settings.arguments as LoginPramiter?;
        return MaterialPageRoute(builder: (_) =>  LoginScreen(
          isForceUpdate: loginPramiter?.isForceUpdate,
          isUpdate:loginPramiter?.isUpdate ,
        ));

      case Routes.otp:
        OtpScreenParameter otpScreenParameter =
            settings.arguments as OtpScreenParameter;
        return MaterialPageRoute(
            builder: (_) => OtpScreen(
                  codeCountry: otpScreenParameter.codeCountry,
                  phone: otpScreenParameter.phone,
                  password: otpScreenParameter.password,
                ));

      case Routes.addInfo:
        GoogleSignInAccount googleData =
            settings.arguments as GoogleSignInAccount;

        return MaterialPageRoute(
            builder: (_) => AddInfoScreen(
                  googleData: googleData,
                ));

      case Routes.mainScreen:
        MainPramiter? mainPramiter = settings.arguments as MainPramiter?;
        return MaterialPageRoute(
            builder: (_) => MainScreen(
              isChachGift: mainPramiter?.isChachGift,
              isCachFrame: mainPramiter?.isCachFrame,
              isCachExtra: mainPramiter?.isCachExtra,
              isCachEntro: mainPramiter?.isCachEntro,
              isCachEmojie: mainPramiter?.isCachEmojie,
              isUpdate: mainPramiter?.isUpdate,
            ));
      case Routes.topUsersScreen:
        return MaterialPageRoute(builder: (_) => const TopUsersScreen());
      case Routes.userProfile:
        String? userId = settings.arguments as String?;

        return MaterialPageRoute(
            builder: (_) => UserProfile(
                  userId: userId,
                ));
      case Routes.giftGallery:
        return MaterialPageRoute(builder: (_) => const GiftGallery());
      case Routes.editInfo:
        OwnerDataModel userData = settings.arguments as OwnerDataModel;

        return MaterialPageRoute(
            builder: (_) => EditInfoScreen(
                  tempData: userData,
                ));
      case Routes.fff:
        String title = settings.arguments as String;

        return MaterialPageRoute(
            builder: (_) => FFFScreen(
                  title: title,
                ));
      case Routes.coins:
        String type = settings.arguments as String;

        return MaterialPageRoute(
            builder: (_) => CoinsScreen(
                  type: type,
                ));
      case Routes.myBag:
        OwnerDataModel userData = settings.arguments as OwnerDataModel;

        return MaterialPageRoute(
            builder: (_) => MyBagScreen(
                  myData: userData,
                ));
      case Routes.mall:
        return MaterialPageRoute(builder: (_) => const MallScreen());
      case Routes.level:
        return MaterialPageRoute(builder: (_) => const LevelScreen());
      case Routes.vip:
        return MaterialPageRoute(builder: (_) => const VipScreen());
      case Routes.familyRanking:
        return MaterialPageRoute(builder: (_) => const FamilyRankingScreen());
      case Routes.familyProfile:
        String familyId = settings.arguments as String;
        return MaterialPageRoute(
            builder: (_) => FamilyProfileScreen(
                  familyId: familyId,
                ));
      case Routes.custoumService:
        int myId = settings.arguments as int;

        return MaterialPageRoute(
            builder: (_) => CustoumServiceScreen(
                  myId: myId,
                ));

      case Routes.settings:
        return MaterialPageRoute(builder: (_) => const SettingsScreen());
      case Routes.language:
        return MaterialPageRoute(builder: (_) => const LanguageScreen());
      case Routes.mode:
        return MaterialPageRoute(builder: (_) => const ModeScreen());
      case Routes.familyRequests:
        String familyId = settings.arguments as String;

        return MaterialPageRoute(
            builder: (_) => FamilyRequestsScreen(
                  familyId: familyId,
                ));

      case Routes.familyMembers:
        OwnerDataModel ownerData = settings.arguments as OwnerDataModel;
        return MaterialPageRoute(
            builder: (_) => FamilyMemberScreen(
                  owner: ownerData,
                ));
      case Routes.createLive:
        return MaterialPageRoute(builder: (_) => const CreateLiveScreen());
      case Routes.uploadReels:
        return MaterialPageRoute(builder: (_) => const UploadReelsScreen());
      case Routes.signUp:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case Routes.deleteFamily:
        return MaterialPageRoute(builder: (_) => const DeleteScreen());

      case Routes.instructionsScreen:
        return MaterialPageRoute(builder: (_) => const InstructionsScreen());

      case Routes.incomeScreen:
        return MaterialPageRoute(builder: (_) => const IncomeScreen());

      case Routes.joinToAgencyScreen:
        return MaterialPageRoute(builder: (_) => const JoinToAgencyScreen());

      case Routes.liveReportScreen:
        OwnerDataModel userData = settings.arguments as OwnerDataModel;

        return MaterialPageRoute(
            builder: (_) => LiveReportScreen(
                  myData: userData,
                ));

      case Routes.exchangeForGoldScreen:
        return MaterialPageRoute(builder: (_) => const ExchangeForGoldScreen());
      case Routes.vistorScreen:
        return MaterialPageRoute(builder: (_) => VistorScreen());
      case Routes.phoneBindScreen:
        return MaterialPageRoute(builder: (_) => const PhoneNumberBindScreen());
      case Routes.otpBindScreen:
        OtpScreenParameter otpScreenParameter =
            settings.arguments as OtpScreenParameter;
        return MaterialPageRoute(
            builder: (_) => OtpBindScreen(
                  codeCountry: otpScreenParameter.codeCountry,
                  phone: otpScreenParameter.phone,
                  password: otpScreenParameter.password,
                ));
      case Routes.searchScreen:
        return MaterialPageRoute(builder: (_) => const SearchScreen());
      case Routes.cashWithdrawal:
        return MaterialPageRoute(builder: (_) => CashWithdrawal());

      case Routes.detailsWithdrawal:
        return MaterialPageRoute(builder: (_) => const DetailsScreen());

      case Routes.agencyScreen:
        return MaterialPageRoute(builder: (_) => const AgenceScreen());
      case Routes.agencyMemberScreen:
        return MaterialPageRoute(builder: (_) => const AgencyMembersScreen());
                       case Routes.agencyRequestsScreen:
        return MaterialPageRoute(builder: (_) =>  const AgencyRequestsScreen());
                    case Routes.agencyRepoertsScreen:
        return MaterialPageRoute(builder: (_) =>  const ReportsScreen());
                           case Routes.charchingCoinsForUsers:
        return MaterialPageRoute(builder: (_) =>   CharchingCoinsForUsers());

                            case Routes.charchingDolarsForUsers
:
        return MaterialPageRoute(builder: (_) =>   CharchingDolarsForUsers
());


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

class LoginPramiter {
  final bool? isUpdate;
  final bool? isForceUpdate ;
  const LoginPramiter({required this.isForceUpdate,required this.isUpdate, Key? key}) ;
}

class MainPramiter  {
  final OwnerDataModel? userData;
  final bool? isChachGift;
  final bool? isCachFrame;
  final bool? isCachExtra;
  final bool? isCachEntro;
  final bool? isCachEmojie;
  final bool? isUpdate;

  MainPramiter(
      {this.isCachEmojie,
        this.isCachEntro,
        this.isUpdate,
        this.userData,
        this.isCachExtra,
        this.isCachFrame,
        this.isChachGift});

}
