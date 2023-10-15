import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/notifcation/constent_notifcatrion.dart';
import 'package:tik_chat_v2/core/notifcation/firebase_messaging_background.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/themes/dark_theme.dart';
import 'package:tik_chat_v2/core/resource_manger/themes/light_theme.dart';
import 'package:tik_chat_v2/core/service/service_locator.dart';
import 'package:tik_chat_v2/core/translations/codegen_loader.g.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/core/utils/api_healper/methods.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/add_info_bloc/add_info_bloc.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/log_out_manager/log_out_bloc.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/login_with_phone_manager/login_with_phone_bloc.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/manager_privacy_policy/privacy_policy_bloc.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/manager_privacy_policy/privacy_policy_event.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/register_with_phone_manager/register_with_phone_bloc.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/sendcode_manger/bloc/send_code_bloc.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/sign_in_with_paltform_manager/sign_in_with_platform_bloc.dart';
import 'package:tik_chat_v2/features/following/persentation/manager/followers_room_manager/get_follwers_room_bloc.dart';
import 'package:tik_chat_v2/features/following/persentation/manager/followers_room_manager/get_follwers_room_event.dart';
import 'package:tik_chat_v2/features/home/presentation/manager/country_manager/counrty_bloc.dart';
import 'package:tik_chat_v2/features/home/presentation/manager/country_manager/counrty_event.dart';
import 'package:tik_chat_v2/features/home/presentation/manager/create_room_manager/create_room_bloc.dart';
import 'package:tik_chat_v2/features/home/presentation/manager/create_room_manager/create_room_events.dart';
import 'package:tik_chat_v2/features/home/presentation/manager/cursel_bloc/cursel_bloc.dart';
import 'package:tik_chat_v2/features/home/presentation/manager/cursel_bloc/cursel_events.dart';
import 'package:tik_chat_v2/features/home/presentation/manager/get_room_manager/get_room_bloc.dart';
import 'package:tik_chat_v2/features/home/presentation/manager/get_room_manager/get_room_events.dart';
import 'package:tik_chat_v2/features/home/presentation/manager/manager_top_rank/top_bloc.dart';
import 'package:tik_chat_v2/features/home/presentation/manager/manger_search/search_bloc.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_add_moment/add_moment_bloc.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_add_moment_comment/add_moment_comment_bloc.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_delete_comment/delete_moment_comment_bloc.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_delete_moment/delete_moment_bloc.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_get_following_moment/get_following_user_moment_bloc.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_get_following_moment/get_following_user_moment_event.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_get_moment_comment/get_moment_comment_bloc.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_get_user_moment/get_moment_bloc.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_get_user_moment/get_moment_event.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_make_moment_like/make_moment_like_bloc.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_moment_get_gifts/get_moment_gifts_bloc.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_moment_i_like_it/get_moment_i_like_it_bloc.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_moment_i_like_it/get_moment_i_like_it_event.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_moment_send_gift/moment_send_gift_bloc.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manger_get_moment_likes/get_moment_likes_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/buy_coins_manger/buy_coins_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/exchange_dimonds_manger/bloc/exchange_dimond_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/family_manager/family_ranking_manager/family_ranking_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/family_manager/family_ranking_manager/family_ranking_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/family_manager/manager_delete_family/bloc/delete_family_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/family_manager/manager_family_member/bloc/family_member_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/family_manager/manager_family_requests/bloc/family_request_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/family_manager/manager_family_take_action/bloc/take_action_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/family_manager/manager_join_family/bloc/join_family_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/family_manager/manager_remove_user/bloc/family_remove_user_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/family_manager/manger_change_user_type/bloc/change_user_type_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/family_manager/manger_create_family/bloc/create_family_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/family_manager/manger_exite_family/bloc/exit_family_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/family_manager/manger_show_family/bloc/show_family_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/follow_manger/bloc/follow_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_follwers_or_following_manger/bloc/get_follower_or_following_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_my_data_manager/get_my_data_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_my_data_manager/get_my_data_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/gift_history_manger/gift_history_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/mall_buy_manager/mall_buy_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/mall_manager/mall_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/mall_manager/mall_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_acount/acount_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_add_intersted/add_intersted_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_agency_history/agency_time_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_agency_member/agnecy_member_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_agency_requests/agency_requests_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_agency_requests_action/agency_requests_action_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_agency_time_history/agency_history_time_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_charge_coin_for_user/charge_coin_for_user_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_charge_coin_system_history/charge_coin_system_history_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_charge_dolars_for_user/charge_dolars_for_user_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_charge_owner_agency_history/charge_owner_agency_history_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_charge_to/charge_to_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_delete_reel/delete_reel_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_family_room/bloc/family_room_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_get_all_intersted/get_all_intersted_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_get_all_intersted/get_all_intersted_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_get_config_key/get_config_keys_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_get_user_intersed/get_user_intersted_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_get_user_reels/get_user_reels_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_get_user_reels/get_user_reels_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_my_store/my_store_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_my_store/my_store_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_show_agency/show_agency_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_theme/theme_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_theme/theme_state.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_use_item/use_item_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_user_repoert/user_report_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_wallet_history/charge_history_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manger_buy_send_vip/bloc/buy_or_send_vip_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manger_feed_back/bloc/feed_back_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manger_getVipPrev/manger_get_vip_prev_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manger_getuser/get_user_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manger_gold_coin/bloc/gold_coin_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manger_gold_coin/bloc/gold_coin_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manger_join_to_agencie/bloc/join_to_agencie_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manger_time_data_report/time_data_report_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manger_vip_center/vip_center_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manger_vip_center/vip_center_events.dart';


import 'package:tik_chat_v2/features/profile/persentation/manager/my_bag_manager/my_bag_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/my_bag_manager/my_bag_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/privacy_manger/privacy_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/replace_with_gold_manger/bloc/replace_with_gold_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/replace_with_gold_manger/bloc/replace_with_gold_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/vistors_manager/vistors_bloc.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_get_reel_comments/get_reel_comments_bloc.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_get_reels/get_reels_bloc.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_make_reel_comment/make_reel_comment_bloc.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_make_reel_like/make_reel_like_bloc.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_report_reals/report_reals_bloc.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_upload_reel/upload_reels_bloc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/Gift_manger/gift_bloc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/Gift_manger/gift_events.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manager_add_room_backGround/add_room_background_bloc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manager_admin_room/admin_room_bloc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manager_lucky_boxes/luck_boxes_bloc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manager_pk/pk_bloc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manager_room_vistor/room_vistor_bloc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manager_top_inroom/topin_room_bloc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manager_user_in_room/users_in_room_bloc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manger_get_my_background/get_my_background_bloc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manger_onRoom/OnRoom_bloc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manger_onRoom/OnRoom_events.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/room_handler_manager/room_handler_bloc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/send_gift_manger/send_gift_bloc.dart';
import 'package:tik_chat_v2/firebase_options.dart';

import 'features/profile/persentation/manager/manger_getVipPrev/manger_get_vip_prev_event.dart';

final globalNavigatorKey = GlobalKey<NavigatorState>();


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  // CreateLiveVideoBody.cameras = await availableCameras();
  await Permission.notification.isDenied.then((value) {
    if (value) {
      Permission.notification.request();
    }
  });
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  tokenDevices = await FirebaseMessaging.instance.getToken();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await ServerLocator().init();
String theme = await Methods().returnThemeStatus();
  runApp(EasyLocalization(
    fallbackLocale: const Locale('en'),
    supportedLocales: const [
      Locale('en'),
      Locale('ar'),
      Locale('tr'),
      Locale('ur'),
      Locale('汉语'),
      Locale('漢語'),
    ],
    assetLoader: const CodegenLoader(),
    path: 'lib/core/translations/',
    saveLocale: true,
    child:  MyApp(theme: theme),
  ));
}

class MyApp extends StatelessWidget {
final  String theme ;
  const MyApp({required this.theme ,   super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
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
          create: (context) => getIt<GetMyDataBloc>()..add(GetMyDataEvent()),
        ),
        BlocProvider(
          create: (context) => getIt<MallBloc>()
            ..add(const GetCarMallEvent(type: 6))
            ..add(const GetFramesMallEvent(type: 4))
            ..add(const GetBubbleMallEvent(type: 5)),
        ),
        BlocProvider(
          create: (context) => getIt<MallBuyBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<MyBagBloc>()
            ..add(const GetFramesMyBagEvent(type: "4"))
            ..add(const GetEntrieMyBagEvent(type: '6'))
            ..add(const GetBubbleBackPackMyBagEvent(type: "5")),
        ),
        BlocProvider(
          create: (context) => getIt<UseItemBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<VipCenterBloc>()..add(GetVipCenterEvent()),
        ),
        BlocProvider(
          create: (context) => getIt<BuyOrSendVipBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<FamilyRankingBloc>()
            ..add(const GetFamilyRankingDailyEvent(time: "today"))
            ..add(const GetFamilyRankingWeekEvent(time: "week"))
            ..add(const GetFamilyRankingMonthEvent(time: "month")),
        ),
        BlocProvider(
          create: (context) => getIt<CreateFamilyBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<GetConfigKeysBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<ShowFamilyBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<FamilyMemberBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<FamilyRequestBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<DeleteFamilyBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<TakeActionBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<ChangeUserTypeBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<FamilyRemoveUserBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<JoinFamilyBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<ExitFamilyBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<FeedBackBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<GetFollowerOrFollowingBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<VistorsBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<GetUserBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<GiftHistoryBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<FollowBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<AcountBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<GetFollwersRoomBloc>()
            ..add(const GetFollwersRoomEvent(type: "5")),
        ),
        BlocProvider(
          create: (context) => getIt<CarouselBloc>()..add(GetCarouselEvent()),
        ),
        BlocProvider(
          create: (context) => getIt<CounrtyBloc>()..add(GetAllCountryEvent()),
        ),
        BlocProvider(
          create: (context) => getIt<GetRoomsBloc>()
            ..add(GetRoomsEvent(typeGetRooms: TypeGetRooms.popular)),
        ),
        BlocProvider(
          create: (context) => getIt<SearchBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<TobBloc>(),
        ),
        BlocProvider(
          create: (context) =>
              getIt<ReplaceWithGoldBloc>()..add(ReplaceWithGoldEvent()),
        ),
        BlocProvider(
          create: (context) => getIt<ExchangeDimondBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<JoinToAgencieBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<TimeDataReportBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<ChargeHistoryBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<ChargeToBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<MyStoreBloc>()..add(GetMyStoreEvent()),
        ),
        BlocProvider(
          create: (context) => getIt<ShowAgencyBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<AgnecyMemberBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<AgencyRequestsBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<AgencyRequestsActionBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<AgencyHistoryTimeBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<AgencyTimeBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<ChargeCoinForUserBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<ChargeDolarsForUserBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<CreateRoomBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<ChargeOwnerAgencyHistoryBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<ChargeCoinSystemHistoryBloc>(),
        ),
        BlocProvider(
          create: (context) =>
              getIt<GetAllInterstedBloc>()..add(GetAllInterstedEvent()),
        ),
        BlocProvider(
          create: (context) => getIt<AddInterstedBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<GetUserInterstedBloc>(),
        ),
        BlocProvider(
          create: (context) =>
              getIt<CreateRoomBloc>()..add(GetTypesRoomEvent()),
        ),
        BlocProvider(
          create: (context) => getIt<RoomHandlerBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<SendGiftBloc>(),
        ),
        BlocProvider(
            create: (_) =>
                getIt<MangerGetVipPrevBloc>()..add(getVipPrevEvent())),
        BlocProvider(create: (_) => getIt<GetMyBackgroundBloc>()),
        BlocProvider(create: (_) => getIt<AddRoomBackgroundBloc>()),
        BlocProvider(
            create: (_) => getIt<GiftBloc>()
              ..add(GiftesNormalEvent(type: 1))
              ..add(GiftesHotEvent(type: 2))
              ..add(GiftesCountryEvent(type: 3))
              ..add(GiftesFamousEvent(type: 5))
              ..add(GiftesLuckyEvent(type: 6))
              ..add(GiftesMomentEvent(type: 4)),


        ),
        BlocProvider(create: (_) => getIt<OnRoomBloc>()..add(EmojieEvent())),
        BlocProvider(create: (_) => getIt<LuckyBoxesBloc>()),
        BlocProvider(create: (_) => getIt<PKBloc>()),
        BlocProvider(create: (_) => getIt<AdminRoomBloc>()),
        BlocProvider(
          create: (context) => getIt<FamilyRoomBloc>(),
        ),
        BlocProvider(create: (_) => getIt<PrivacyBloc>()),
        BlocProvider(create: (_) => getIt<UploadReelsBloc>()),
        BlocProvider(create: (_) => getIt<GetReelsBloc>()),
        BlocProvider(create: (_) => getIt<UsersInRoomBloc>()),
        BlocProvider(create: (_) => getIt<UserReportBloc>()),
        BlocProvider(
          create: (context) =>
              getIt<GoldCoinBloc>()..add(GetGoldCoinDataEvent()),
        ),
        BlocProvider(create: (_) => getIt<BuyCoinsBloc>()),
        BlocProvider(create: (_) => getIt<GetReelCommentsBloc>()),
        BlocProvider(create: (_) => getIt<MakeReelCommentBloc>()),
        BlocProvider(create: (_) => getIt<MakeReelLikeBloc>()),
        BlocProvider(
            create: (_) =>
                getIt<GetUserReelsBloc>()..add(const GetUserReelEvent())),
        BlocProvider(create: (_) => getIt<TobinRoomBloc>()),
        BlocProvider(create: (_) => getIt<DeleteReelBloc>()),
        BlocProvider(create: (_) => getIt<AddMomentBloc>()),
        BlocProvider(create: (_) => getIt<DeleteMomentBloc>()),
        BlocProvider(create: (_) => getIt<AddMomentCommentBloc>()),

        BlocProvider(create: (_) => getIt<GetMomentBloc>()..add(GetUserMomentEvent(
          userId: MyDataModel.getInstance().id.toString(),
        ))),
        BlocProvider(create: (_) => getIt<GetFollowingUserMomentBloc>()..add(const GetFollowingMomentEvent())),
        BlocProvider(create: (_) => getIt<GetMomentILikeItBloc>()..add(const GetMomentIliKEitEvent())),
        BlocProvider(create: (_) => getIt<GetMomentLikesBloc>()),

        BlocProvider(create: (_) => getIt<DeleteMomentCommentBloc>()),
        BlocProvider(create: (_) => getIt<GetMomentCommentBloc>()),
        BlocProvider(create: (_) => getIt<MakeMomentLikeBloc>()),
        BlocProvider(create: (_) => getIt<MomentSendGiftBloc>()),
        BlocProvider(create: (_) => getIt<GetMomentGiftsBloc>()),

        BlocProvider(create: (context) => ThemeBloc()),
                BlocProvider(create: (_) => getIt<RoomVistorBloc>()),



        BlocProvider(create: (_) => getIt<ReportRealsBloc>()),
        BlocProvider(create: (_) => getIt<SendCodeBloc>()),
        BlocProvider(
            create: (_) =>
            getIt<PrivacyPolicyBloc>()..add(privacyPolicyEvent())),
      ],
      child:  BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          if (state is LightThemeState )  {
   return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme ,

            navigatorKey: globalNavigatorKey ,
            supportedLocales: context.supportedLocales,
            localizationsDelegates: context.localizationDelegates,
            onGenerateRoute: RouteGenerator.getRoute,
            locale: context.locale,
            initialRoute: Routes.splash,
          );
          }else if (state is DarkThemeState){
            return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: darkTheme ,
            navigatorKey: globalNavigatorKey ,
            supportedLocales: context.supportedLocales,
            localizationsDelegates: context.localizationDelegates,
            onGenerateRoute: RouteGenerator.getRoute,
            locale: context.locale,
            initialRoute: Routes.splash,
          );
          }
       else {
        return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: theme=="dark"?darkTheme: lightTheme ,
            navigatorKey: globalNavigatorKey ,
            supportedLocales: context.supportedLocales,
            localizationsDelegates: context.localizationDelegates,
            onGenerateRoute: RouteGenerator.getRoute,
            locale: context.locale,
            initialRoute: Routes.splash,
          );

       }
        }
      ),
    );
  }
}
