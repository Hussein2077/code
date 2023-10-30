import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/service/cach_manager.dart';
import 'package:tik_chat_v2/core/utils/api_healper/methods.dart';
import 'package:tik_chat_v2/features/auth/data/data_soruce/fire_base_datasource.dart';
import 'package:tik_chat_v2/features/auth/data/data_soruce/remotly_datasource.dart';
import 'package:tik_chat_v2/features/auth/data/repo_imp/repo_imp.dart';
import 'package:tik_chat_v2/features/auth/domin/repo/base_repo.dart';
import 'package:tik_chat_v2/features/auth/domin/use_case/add_info_use_case.dart';
import 'package:tik_chat_v2/features/auth/domin/use_case/google_sign_in_usecase.dart';
import 'package:tik_chat_v2/features/auth/domin/use_case/log_out_usecase.dart';
import 'package:tik_chat_v2/features/auth/domin/use_case/login_with_phone_usecase.dart';
import 'package:tik_chat_v2/features/auth/domin/use_case/privacy_policy_use_case.dart';
import 'package:tik_chat_v2/features/auth/domin/use_case/register_with_phone_usecase.dart';
import 'package:tik_chat_v2/features/auth/domin/use_case/sign_with_apple_us.dart';
import 'package:tik_chat_v2/features/auth/domin/use_case/send_code_usecase.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/add_info_bloc/add_info_bloc.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/log_out_manager/log_out_bloc.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/login_with_phone_manager/login_with_phone_bloc.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/manager_privacy_policy/privacy_policy_bloc.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/register_with_phone_manager/register_with_phone_bloc.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/sendcode_manger/bloc/send_code_bloc.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/sign_in_with_paltform_manager/sign_in_with_platform_bloc.dart';
import 'package:tik_chat_v2/features/following/data/data_sorce/follwoing_remote_data_sours.dart';
import 'package:tik_chat_v2/features/following/data/repository_imp/repository_imp.dart';
import 'package:tik_chat_v2/features/following/domin/repository/follwoing_repository.dart';
import 'package:tik_chat_v2/features/following/domin/use_case/get_follwers_rooms_uc.dart';
import 'package:tik_chat_v2/features/following/persentation/manager/followers_room_manager/get_follwers_room_bloc.dart';
import 'package:tik_chat_v2/features/home/data/data_source/home_remote_data_source.dart';
import 'package:tik_chat_v2/features/home/data/repository_imp/repository_imp.dart';
import 'package:tik_chat_v2/features/home/domin/repository/rebostory_ab.dart';
import 'package:tik_chat_v2/features/home/domin/use_case/creat_room_usecase.dart';
import 'package:tik_chat_v2/features/home/domin/use_case/get_all_room_types_uc.dart';
import 'package:tik_chat_v2/features/home/domin/use_case/get_all_rooms_uc.dart';
import 'package:tik_chat_v2/features/home/domin/use_case/get_country_usecase.dart';
import 'package:tik_chat_v2/features/home/domin/use_case/get_top_usecase.dart';
import 'package:tik_chat_v2/features/home/domin/use_case/getcarousels_usecase.dart';
import 'package:tik_chat_v2/features/home/presentation/manager/country_manager/counrty_bloc.dart';
import 'package:tik_chat_v2/features/home/presentation/manager/create_room_manager/create_room_bloc.dart';
import 'package:tik_chat_v2/features/home/presentation/manager/cursel_bloc/cursel_bloc.dart';
import 'package:tik_chat_v2/features/home/presentation/manager/get_room_manager/get_room_bloc.dart';
import 'package:tik_chat_v2/features/home/presentation/manager/manager_top_rank/top_bloc.dart';
import 'package:tik_chat_v2/features/home/presentation/manager/manger_search/search_bloc.dart';
import 'package:tik_chat_v2/features/moment/data/data_source/remotly_data_source_moment.dart';
import 'package:tik_chat_v2/features/moment/data/repostory_imp/repository_imp_moment.dart';
import 'package:tik_chat_v2/features/moment/domain/moment_usecse/add_moment_comment_use_case.dart';
import 'package:tik_chat_v2/features/moment/domain/moment_usecse/add_moment_use_case.dart';
import 'package:tik_chat_v2/features/moment/domain/moment_usecse/delete_moment_comment_use_case.dart';
import 'package:tik_chat_v2/features/moment/domain/moment_usecse/delete_moment_use_case.dart';
import 'package:tik_chat_v2/features/moment/domain/moment_usecse/get_moment_comment_usecase.dart';
import 'package:tik_chat_v2/features/moment/domain/moment_usecse/get_moment_gifts_uc.dart';
import 'package:tik_chat_v2/features/moment/domain/moment_usecse/get_moment_likes_uc.dart';
import 'package:tik_chat_v2/features/moment/domain/moment_usecse/get_moment_use_case.dart';
import 'package:tik_chat_v2/features/moment/domain/moment_usecse/make_moment_like.dart';
import 'package:tik_chat_v2/features/moment/domain/moment_usecse/moment_send_gift.dart';
import 'package:tik_chat_v2/features/moment/domain/repository/base_repository_moment.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_add_moment/add_moment_bloc.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_add_moment_comment/add_moment_comment_bloc.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_delete_comment/delete_moment_comment_bloc.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_delete_moment/delete_moment_bloc.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_get_following_moment/get_following_user_moment_bloc.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_get_moment_comment/get_moment_comment_bloc.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_get_user_moment/get_moment_bloc.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_make_moment_like/make_moment_like_bloc.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_moment_get_gifts/get_moment_gifts_bloc.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_moment_i_like_it/get_moment_i_like_it_bloc.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_moment_send_gift/moment_send_gift_bloc.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manager_moment_trending/get_moment_all_bloc.dart';
import 'package:tik_chat_v2/features/moment/presentation/manager/manger_get_moment_likes/get_moment_likes_bloc.dart';
import 'package:tik_chat_v2/features/profile/data/Repository_Imp/repository_imp.dart';
import 'package:tik_chat_v2/features/profile/data/data_sorce/remotly_data_source_profile.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/active_notification_usecase.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/add_intrested_uc.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/agency_history_time_uc.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/agency_history_uc.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/agency_member_uc.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/agency_requests_action_uc.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/agency_requests_uc.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/back_pack_usecase.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/bound_platform_uc.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/buy_coins_uc.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/buy_or_send_vip.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/buy_usecase.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/change_user_type.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/charge_coin_for_users_history_uc.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/charge_coin_for_users_uc.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/charge_dolars_agency_owner_history.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/charge_dolars_for_users_uc.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/charge_to_uc.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/charge_history_uc.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/create_family_uc.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/delet_family_usecase.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/delete_account_uc.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/delete_reel_use_case.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/exchange_dimonds.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/exit_family_usecase.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/family_ranking_usecase.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/family_room_usecase.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/family_take_action_usecase.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/feed_back_usecase.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/follow_unfollow_usecase.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/get_all_intersted_uc.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/get_config_key.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/get_data_use_case.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/get_family_member_usecase.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/get_family_request_usecase.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/get_friends_or_followers.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/get_gold_coin_usecase.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/get_mydata_usecase.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/get_replace_with_dimond_data.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/get_user_data_usecase.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/get_user_intersted_uc.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/get_user_reels_use_case.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/get_vip_center_usecase.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/get_vistors_usecase.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/gift_history_usecase.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/in_app_purchase_uc.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/join_family_usecase.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/join_to_agencie_usecase.dart';





import 'package:tik_chat_v2/features/profile/domin/use_case/my_store_uc.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/remove_user_family_usecase.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/search_use_case.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/show_agnecy_uc.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/show_family_usecase.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/time_data_report_uc.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/unused_item_usecase.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/use_item_usecase.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/user_reporet_uc.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/vipPervilage_usecase/get_vip_prev_usecase.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/vipPervilage_usecase/prev_active_usecase.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/vipPervilage_usecase/prev_dispose_use_case.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/active_notification_manager/active_notification_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/buy_coins_manger/buy_coins_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/in_app_purchase_manager/in_app_purchase_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_add_intersted/add_intersted_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/exchange_dimonds_manger/bloc/exchange_dimond_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/family_manager/family_ranking_manager/family_ranking_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/family_manager/manager_delete_family/bloc/delete_family_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/family_manager/manager_family_member/bloc/family_member_bloc.dart';
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
import 'package:tik_chat_v2/features/profile/persentation/manager/gift_history_manger/gift_history_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/mall_buy_manager/mall_buy_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/mall_manager/mall_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/family_manager/manager_family_requests/bloc/family_request_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_acount/acount_bloc.dart';
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
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_get_config_key/get_config_keys_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_get_user_intersed/get_user_intersted_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_get_user_reels/get_user_reels_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_my_store/my_store_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_show_agency/show_agency_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_use_item/use_item_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_user_repoert/user_report_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_wallet_history/charge_history_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manger_buy_send_vip/bloc/buy_or_send_vip_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manger_feed_back/bloc/feed_back_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manger_getVipPrev/manger_get_vip_prev_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manger_getuser/get_user_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manger_gold_coin/bloc/gold_coin_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manger_join_to_agencie/bloc/join_to_agencie_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manger_time_data_report/time_data_report_bloc.dart';


import 'package:tik_chat_v2/features/profile/persentation/manager/manger_vip_center/vip_center_bloc.dart';


import 'package:tik_chat_v2/features/profile/persentation/manager/my_bag_manager/my_bag_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/privacy_manger/privacy_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/replace_with_gold_manger/bloc/replace_with_gold_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/vistors_manager/vistors_bloc.dart';
import 'package:tik_chat_v2/features/reels/data/data_source/remotly_data_source_reel.dart';
import 'package:tik_chat_v2/features/reels/data/repository_imp/repository_imp.dart';
import 'package:tik_chat_v2/features/reels/domin/repository/base_repository_reels.dart';
import 'package:tik_chat_v2/features/reels/domin/use_case/get_following_reels_uc.dart';
import 'package:tik_chat_v2/features/reels/domin/use_case/get_reel_comments_uc.dart';
import 'package:tik_chat_v2/features/reels/domin/use_case/get_reels_use_case.dart';
import 'package:tik_chat_v2/features/reels/domin/use_case/make_reel_comment.dart';
import 'package:tik_chat_v2/features/reels/domin/use_case/make_reel_like_use_case.dart';
import 'package:tik_chat_v2/features/reels/domin/use_case/report_reals_use_case.dart';
import 'package:tik_chat_v2/features/reels/domin/use_case/upload_reel_use_case.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_get_following_reels/get_following_reels_bloc.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_get_reel_comments/get_reel_comments_bloc.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_get_reels/get_reels_bloc.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_make_reel_comment/make_reel_comment_bloc.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_make_reel_like/make_reel_like_bloc.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_report_reals/report_reals_bloc.dart';
import 'package:tik_chat_v2/features/reels/persentation/manager/manager_upload_reel/upload_reels_bloc.dart';
import 'package:tik_chat_v2/features/room_audio/data/Repository_Imp/repository_Imp.dart';
import 'package:tik_chat_v2/features/room_audio/data/data_sorce/remotly_data_source_room.dart';
import 'package:tik_chat_v2/features/room_audio/domine/Repository/Base_Repository_Profile.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/add_admin_uc.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/add_room_back_ground_uc.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/background_usecase.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/ban_user_from_writing_uc.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/change_room_mode.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/close_pk_uc.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/dispose_hide_room_uc.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/emojie_usecase.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/enter_room.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/exist_room_uc.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/getGiftes_useCase.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/get_all_room_user_usecase.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/get_boxex_uc.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/get_mybackground_uc.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/get_top_room.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/get_user_in_room_uc.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/hide_pk_uc.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/hide_room_use_case.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/invite_user_uc.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/kickout_pramiter_uc.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/leave_mic_uc.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/lock_unLock_mic_uc.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/mute_unmute_mic_uc.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/mute_unmute_use_uc.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/pickup_box_uc.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/remove_admin_uc.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/remove_pass_room_UC.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/room_admins_uc.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/send_box_uc.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/send_gift_use_case.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/send_lucky_gift_uc.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/send_pob_up_uc.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/send_yallow_banner_uc.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/show_pk_uc.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/start_pk_uc.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/up_mic_usecase.dart';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/update_room_usecase.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/lucky_box/widgets/dialog_lucky_box.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/components/pk/Conter_Time_pk_Widget.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/Gift_manger/gift_bloc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manager_add_room_backGround/add_room_background_bloc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manager_admin_room/admin_room_bloc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manager_get_users_in_room/manager_get_users_in_room_bloc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manager_lucky_boxes/luck_boxes_bloc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manager_pk/pk_bloc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manager_room_vistor/room_vistor_bloc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manager_top_inroom/topin_room_bloc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manager_user_in_room/users_in_room_bloc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manger_get_my_background/get_my_background_bloc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manger_lucky_gift_banner/lucky_gift_banner_bloc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/manger_onRoom/OnRoom_bloc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/room_handler_manager/room_handler_bloc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/send_gift_manger/send_gift_bloc.dart';

final getIt = GetIt.instance;

class ServerLocator {
  Future<void> init() async {
    //bloc

    
    getIt.registerFactory(() => GoldCoinBloc(getGoldCoinDataUseCase: getIt()));
    getIt.registerFactory(
            () => AdminRoomBloc(removeAdminUC: getIt(),roomAdminsUC: getIt(),addAdminUC:getIt()));
    getIt.registerFactory(
            () => PKBloc(showPKUC: getIt(), hidePKUC:getIt(),startPKUC: getIt(), closePKUC: getIt()));
    getIt.registerFactory(
            () => LuckyBoxesBloc(getBoxexUC: getIt(), sendBoxUC: getIt(), pickupBoxUC: getIt(),));
    getIt.registerFactory(
            () => GiftBloc(giftsUseCase: getIt()));
    getIt.registerFactory(
            () => AddRoomBackgroundBloc(addRoomBackGroundUseCase: getIt()));
    getIt.registerFactory(
            () => GetMyBackgroundBloc(getMyBackGroundUseCase: getIt()));
    getIt.registerFactory(
            () => MangerGetVipPrevBloc(getVipPrevUseCase:getIt() ));
    getIt.registerFactory(
            () => OnRoomBloc(
              banUserFromWritingUC:getIt() ,
                backGroundUseCase:getIt() ,
                sendPobUpUC:getIt() ,
                changeRoomModeUC: getIt(),
                lockUnLockMicUC:getIt() ,
                muteUnMuteMicUC: getIt(),
                leaveMicUC: getIt(),
                upMicUsecase: getIt(),
                emojieUseCase:getIt() ,
                existroomUC: getIt() ,

                removePassRoomUC: getIt() ,
                updateRoomUsecase: getIt() ,
                disposeHideRoomUseCase: getIt(),
                hideRoomUseCase: getIt() , 
                sendYallowBannerUC: getIt()));
    getIt.registerFactory(
            () => SendGiftBloc(giftUseCase: getIt()));
    getIt.registerFactory(
            () => RoomHandlerBloc(enterRoomUC: getIt() ));
    getIt.registerFactory(
            () => CreateRoomBloc(createRoomUsecase:getIt(),
                getAllRoomTypesUC: getIt() ));
    getIt.registerFactory(
        () => SignInWithPlatformBloc(signInWithGoogleUC: getIt(), signInWithAppleUC: getIt(),));
    getIt.registerFactory(() => AddInfoBloc(addInFormationUC: getIt()));
    getIt.registerFactory(
        () => RegisterWithPhoneBloc(registerWithPhoneUsecase: getIt()));

    getIt.registerFactory(
        () => LoginWithPhoneBloc(loginWithPhoneUseCase: getIt()));
    getIt.registerFactory(() => LogOutBloc(logOutUseCase: getIt()));

    getIt.registerFactory(() => GetMyDataBloc(getmyDataUsecase: getIt()));
    getIt.registerFactory(() => MallBloc(gatDataUseCase: getIt()));
    getIt.registerFactory(() => MallBuyBloc(buyUseCase: getIt()));

    getIt.registerFactory(() => MyBagBloc(getBackPackUseCase: getIt()));
    getIt.registerFactory(
        () => UseItemBloc(useItemUseCase: getIt(), unusedItemUsecase: getIt()));
    getIt.registerFactory(() => VipCenterBloc(
          getVipCenterUsecase: getIt(),
        ));

    getIt.registerFactory(() => BuyOrSendVipBloc(
          buyOrSendVipUseCase: getIt(),
        ));
    getIt.registerFactory(() => FamilyRankingBloc(
          familyRankingUsecase: getIt(),
        ));
    getIt.registerFactory(() => CreateFamilyBloc(
          createFamilyUC: getIt(),
        ));

    getIt.registerFactory(() => GetConfigKeysBloc(
          getConfigKeyUc: getIt(),
        ));
    getIt.registerFactory(() => ShowFamilyBloc(
          showFamilymUsecase: getIt(),
        ));
    getIt.registerFactory(() => FamilyMemberBloc(
          getfamilymember: getIt(),
        ));
    getIt.registerFactory(() => FamilyRequestBloc(
          getFamilyRequestUsecase: getIt(),
        ));
    getIt.registerFactory(() => DeleteFamilyBloc(
          deleteFamilyUseCse: getIt(),
        ));

    getIt.registerFactory(() => TakeActionBloc(
          familyTakeActionUsecase: getIt(),
        ));
    getIt.registerFactory(() => ChangeUserTypeBloc(
          changeUserTypeUsecase: getIt(),
        ));
    getIt.registerFactory(() => FamilyRemoveUserBloc(
          removeUserFromFamilyUsecase: getIt(),
        ));
    getIt.registerFactory(() => JoinFamilyBloc(
          joinFamilymUsecase: getIt(),
        ));
    getIt.registerFactory(() => ExitFamilyBloc(
          exitFamilyUsecase: getIt(),
        ));
    getIt.registerFactory(() => FeedBackBloc(
          feedBackUseCase: getIt(),
        ));
    getIt.registerFactory(() => GetFollowerOrFollowingBloc(
          getFriendsOrFollowersUsecase: getIt(),
        ));
    getIt.registerFactory(() => VistorsBloc(
          getVistorUseCase: getIt(),
        ));
    getIt.registerFactory(() => GetUserBloc(
          getUserDataUseCase: getIt(),
        ));
    getIt.registerFactory(() => GiftHistoryBloc(
          giftHistorykUseCase: getIt(),
        ));
    getIt.registerFactory(() => FollowBloc(
          followOrUnFollowUsecase: getIt(),
        ));



    getIt.registerFactory(
        () => AcountBloc(boundPlatformUC: getIt(), deleteAccountUC: getIt()));

    getIt.registerFactory(
        () => GetFollwersRoomBloc(getFollwingRoomsUC: getIt()));

    getIt.registerFactory(() => CarouselBloc(getCarouselsUsecase: getIt()));

    getIt.registerFactory(() => CounrtyBloc(getCountryUseCase: getIt()));
    getIt.registerFactory(() => GetRoomsBloc(allRoomsUsecase: getIt()));
    getIt.registerFactory(() => SearchBloc(searchUseCase: getIt()));

    getIt.registerFactory(() => TobBloc(getTopUseCase: getIt()));

    getIt.registerFactory(
        () => ReplaceWithGoldBloc(getReplaceWithGoldUseCase: getIt()));
    getIt.registerFactory(
        () => ExchangeDimondBloc(exchangeDimondsUseCase: getIt()));
    getIt.registerFactory(
        () => JoinToAgencieBloc(joinToAgencieUsecase: getIt()));

    getIt.registerFactory(
        () => TimeDataReportBloc(timeDataReportUseCases: getIt()));

    getIt.registerFactory(() => ChargeToBloc(chargeToUseCases: getIt()));

    getIt.registerFactory(() => MyStoreBloc(getMyStoreUseCase: getIt()));

    getIt.registerFactory(() => ShowAgencyBloc(showAgencymUsecase: getIt()));

    getIt
        .registerFactory(() => AgnecyMemberBloc(agencyMembermUsecase: getIt()));

    getIt.registerFactory(
        () => AgencyRequestsBloc(agencyRequestsUsecase: getIt()));

    getIt.registerFactory(
        () => AgencyRequestsActionBloc(agencyRequestsActionUsecase: getIt()));

    getIt.registerFactory(
        () => AgencyHistoryTimeBloc(agencyHistoryTimemUsecase: getIt()));

    getIt.registerFactory(
        () => ChargeHistoryBloc(chargeHistoryUseCases: getIt()));

            getIt.registerFactory(
        () => AgencyTimeBloc(agencyHistoryUsecase: getIt()));

                  getIt.registerFactory(
        () => ChargeCoinForUserBloc(chargeCoinForUserUsecase: getIt()));
           getIt.registerFactory(
        () => ChargeDolarsForUserBloc(chargeDolarsForUserUsecase: getIt()));


           getIt.registerFactory(
        () => ChargeOwnerAgencyHistoryBloc(chargeHistoryUseCases: getIt()));
          getIt.registerFactory(
        () => ChargeCoinSystemHistoryBloc(chargeHistoryUseCases: getIt()));
                 getIt.registerFactory(
        () => GetAllInterstedBloc(getAllIntrestedUseCase: getIt()));
        
                         getIt.registerFactory(
        () => AddInterstedBloc(addInterstedUsecase: getIt()));
                            getIt.registerFactory(
        () => GetUserInterstedBloc(getUserIntrestedUseCase: getIt()));
                              getIt.registerFactory(
        () => PrivacyBloc(prevActiveUseCases: getIt() , prevDisposeUseCases: getIt()));

    getIt.registerFactory(() => FamilyRoomBloc(getFamilyRoomUsecase: getIt()));

                                 getIt.registerFactory(
        () => UploadReelsBloc(uploadReelUseCase: getIt()));
                                 getIt.registerFactory(
        () => GetReelsBloc(getReelUseCase: getIt()));

    


        getIt.registerFactory(
        () => UserReportBloc(userReporetUseCase: getIt()));

        getIt.registerFactory(
        () => ReportRealsBloc(reportRealsUseCases: getIt()));

             getIt.registerFactory(
        () => UsersInRoomBloc(

            inviteUserUC: getIt() ,
            muteUnMuteUserInRoomUC: getIt(), kickoutUC: getIt()));
                getIt.registerFactory(
        () => GetReelCommentsBloc(getReelCommentUseCase: getIt()));
                getIt.registerFactory(
        () => MakeReelCommentBloc(makeReelCommentUseCase: getIt()));
               getIt.registerFactory(
        () => MakeReelLikeBloc(makeReelLikeUseCase: getIt()));


    getIt.registerFactory(() => BuyCoinsBloc(buyCoinsUseCase: getIt()));

        getIt.registerFactory(() => TobinRoomBloc(getTopRoomUC: getIt()));
        getIt.registerFactory(() => GetUserReelsBloc(getUserReelUseCase: getIt()));
                getIt.registerFactory(() => DeleteReelBloc(deleteReelUseCse: getIt()));
    getIt.registerFactory(() => SendCodeBloc(sendCodeUseCase:  getIt()));
    getIt.registerFactory(() => PrivacyPolicyBloc(privacyPolicyUseCase:  getIt()));
    getIt.registerFactory(() => RoomVistorBloc(getAllRoomUserUseCase:  getIt()));
    getIt.registerFactory(() => AddMomentBloc(addMomentUseCase: getIt()));
    getIt.registerFactory(() => DeleteMomentBloc(deleteMomentUseCase: getIt()));
    getIt.registerFactory(() => GetMomentBloc(getMomentUseCase: getIt()));
    getIt.registerFactory(() => GetFollowingUserMomentBloc(getMomenttUseCase: getIt()));
    getIt.registerFactory(() => GetMomentILikeItBloc(getMomenttUseCase: getIt()));
    getIt.registerFactory(() => DeleteMomentCommentBloc(deleteMomentCommentUseCase: getIt()));
    getIt.registerFactory(() => GetMomentCommentBloc(getMomentCommentUseCase: getIt()));
    getIt.registerFactory(() => MomentSendGiftBloc(momentSendGiftUseCase:  getIt()));
    getIt.registerFactory(() => MakeMomentLikeBloc(makeMomentLikeUseCase:  getIt()));
    getIt.registerFactory(() => AddMomentCommentBloc(addMomentCommentUseCase:  getIt()));
    getIt.registerFactory(() => GetMomentLikesBloc(getMomentLikeUseCase:  getIt()));
    getIt.registerFactory(() => GetMomentGiftsBloc(getMomentGiftsUseCase:  getIt()));
    getIt.registerFactory(() => GetFollowingReelsBloc(getFollowingReelUseCase:  getIt()));

    getIt.registerFactory(() => LuckyGiftBannerBloc(sendLuckyGiftUc: getIt()));
    getIt.registerFactory(() => ActiveNotificationBloc(activeNotificationUseCase: getIt()));
    getIt.registerFactory(() => GetUsersInRoomBloc(getRoomUserUseCase: getIt(),));
    getIt.registerFactory(() => InAppPurchaseBloc(inAppPurchaseUsecase: getIt(),));
    getIt.registerFactory(() => GetMomentallBloc(getMomenttUseCase:  getIt() ));


//usecase
    getIt.registerLazySingleton(() => GetRoomUserUseCase(roomRepo: getIt()));
    getIt.registerLazySingleton(() => InAppPurchaseUsecase(baseRepositoryProfile: getIt()));
    getIt.registerLazySingleton(() => ActiveNotificationUseCase(baseRepositoryProfile: getIt()));
    getIt.registerLazySingleton(() => SendLuckyGiftUc(roomRepo: getIt()));
    getIt.registerLazySingleton(() => MomentSendGiftUseCase(baseRepositoryMoment: getIt()));
    getIt.registerLazySingleton(() => GetMomentGiftsUseCase(baseRepositoryMoment: getIt()));
    getIt.registerLazySingleton(() => GetMomentLikeUseCase(baseRepositoryMoment: getIt()));
    getIt.registerLazySingleton(() => AddMomentCommentUseCase(baseRepositoryMoment: getIt()));
    getIt.registerLazySingleton(() => MakeMomentLikeUseCase(baseRepositoryMoment: getIt()));
    getIt.registerLazySingleton(() => GetMomentCommentUseCase(baseRepositoryMoment: getIt()));
   getIt.registerLazySingleton(() => DeleteMomentCommentUseCase(baseRepositoryMoment: getIt()));
   getIt.registerLazySingleton(() => GetMomentUseCase(baseRepositoryMoment: getIt()));
   getIt.registerLazySingleton(() => DeleteMomentUseCase(baseRepositoryMoment: getIt()));

   getIt.registerLazySingleton(() => AddMomentUseCase(baseRepositoryMoment: getIt()));
    getIt.registerLazySingleton(() => PrivacyPolicyUseCase(baseRepository: getIt()));
    getIt.registerLazySingleton(() => SendCodeUseCase(baseRepository: getIt()));
   getIt.registerLazySingleton(() => DeleteReelUseCse(baseRepositoryProfile: getIt()));

   getIt.registerLazySingleton(() => GetUserReelsUsecase(baseRepositoryProfile: getIt()));
    getIt.registerLazySingleton(() => GetTopRoomUC(roomRepo: getIt()));

    getIt.registerLazySingleton(() => SendYallowBannerUC(roomRepo: getIt()));

    getIt.registerLazySingleton(() => BuyCoinsUseCase(baseRepositoryProfile: getIt()));
    getIt.registerLazySingleton(
            () => GetGoldCoinDataUseCase(baseRepositoryProfile: getIt()));

 getIt.registerLazySingleton(
            () => MakeReelLikeUseCase(baseRepositoryReel: getIt()));

 getIt.registerLazySingleton(
            () => MakeReelCommentUseCase(baseRepositoryReel: getIt()));



 getIt.registerLazySingleton(
            () => GetReelCommentUseCase(baseRepositoryReel: getIt()));

getIt.registerLazySingleton(
            () => InviteUserUC(roomRepo: getIt()));getIt.registerLazySingleton(
            () => MuteUnMuteUserInRoomUC(roomRepo: getIt()));

    getIt.registerLazySingleton(
            () => KickoutUC(roomRepo: getIt()));

    getIt.registerLazySingleton(
            () => RemoveAdminUC(roomRepo: getIt()));
    getIt.registerLazySingleton(
            () => AddAdminUC(roomRepo: getIt()));
    getIt.registerLazySingleton(
            () => RoomAdminsUC(roomRepo: getIt()));
    getIt.registerLazySingleton(
            () => ShowPKUC(roomRepo: getIt()));

    getIt.registerLazySingleton(
            () => StartPKUC(roomRepo: getIt()));

    getIt.registerLazySingleton(
            () => ClosePKUC(roomRepo: getIt()));


    getIt.registerLazySingleton(
            () => HidePKUC(roomRepo: getIt()));
       

    getIt.registerLazySingleton(
            () => SignInWithAppleUC(baseRepository: getIt()));
    getIt.registerLazySingleton(
            () => PickupBoxUC(roomRepo: getIt()));
    getIt.registerLazySingleton(
            () => SendBoxUC(roomRepo: getIt()));
    getIt.registerLazySingleton(
            () => GetBoxexUC(roomRepo: getIt()));
    getIt.registerLazySingleton(
            () => AddRoomBackGroundUseCase(roomRepo: getIt()));
    getIt.registerLazySingleton(
            () => GetMyBackGroundUseCase(roomRepo: getIt()));
    getIt.registerLazySingleton(
    () => GetVipPrevUseCase(baseRepositoryProfile: getIt()));
    getIt.registerLazySingleton(
            () => SendGiftUseCase(roomRepo:getIt() ));
    getIt.registerLazySingleton(
            () => ExistroomUC(roomRepo:getIt() ));
    getIt.registerLazySingleton(
            () => GetAllRoomUserUseCase(roomRepo:getIt() ));
    getIt.registerLazySingleton(
            () => BackGroundUseCase(roomRepo:getIt() ));
    getIt.registerLazySingleton(
            () => UpdateRoomUsecase(roomRepo:getIt() ));
    getIt.registerLazySingleton(
            () => EmojieUseCase(roomRepo:getIt() ));
    getIt.registerLazySingleton(
            () => RemovePassRoomUC(roomRepo:getIt() ));
    getIt.registerLazySingleton(
            () => UpMicUsecase(roomRepo:getIt()));
    getIt.registerLazySingleton(
            () => LeaveMicUC(roomRepo:getIt()));
    getIt.registerLazySingleton(
            () => MuteUnMuteMicUC(roomRepo:getIt()));
    getIt.registerLazySingleton(
            () => LockUnLockMicUC(roomRepo:getIt()));
    getIt.registerLazySingleton(
            () => ChangeRoomModeUC(roomRepo:getIt()));
    getIt.registerLazySingleton(
            () => BanUserFromWritingUC(roomRepo:getIt()));
    getIt.registerLazySingleton(
            () => SendPobUpUC(roomRepo:getIt()));
    getIt.registerLazySingleton(
            () => HideRoomUseCase(roomRepo:getIt()));
    getIt.registerLazySingleton(
            () => DisposeHideRoomUseCase(roomRepo:getIt()));

    getIt.registerLazySingleton(
            () => GiftsUseCase(roomRepo:getIt()));
    getIt.registerLazySingleton(
            () => EnterRoomUC(roomRepo:getIt() ));
    getIt.registerLazySingleton(
            () => GetAllRoomTypesUC(repoHome:getIt() ));
    getIt.registerLazySingleton(
            () => CreateRoomUsecase(repoHome:getIt() ));
    getIt.registerLazySingleton(
        () => SignInWithGoogleUC(baseRepository: getIt()));

    getIt
        .registerLazySingleton(() => AddInFormationUC(baseRepository: getIt()));

    getIt.registerLazySingleton(
        () => RegisterWithPhoneUsecase(baseRepository: getIt()));
    getIt.registerLazySingleton(
        () => LoginWithPhoneUseCase(baseRepository: getIt()));
    getIt.registerLazySingleton(() => LogOutUseCase(baseRepository: getIt()));
    getIt.registerLazySingleton(
        () => GetmyDataUsecase(baseRepositoryProfile: getIt()));
    getIt.registerLazySingleton(
        () => GatDataMallUseCase(baseRepositoryProfile: getIt()));
    getIt.registerLazySingleton(
        () => BuyUseCase(baseRepositoryProfile: getIt()));
    getIt.registerLazySingleton(
        () => GetBackPackUseCase(baseRepositoryProfile: getIt()));
    getIt.registerLazySingleton(
        () => UseItemUseCase(baseRepositoryProfile: getIt()));
    getIt.registerLazySingleton(
        () => UnusedItemUsecase(baseRepositoryProfile: getIt()));
    getIt.registerLazySingleton(
        () => GetVipCenterUsecase(baseRepositoryProfile: getIt()));
    getIt.registerLazySingleton(
        () => BuyOrSendVipUseCase(baseRepositoryProfile: getIt()));
    getIt.registerLazySingleton(
        () => FamilyRankingUsecase(baseRepositoryProfile: getIt()));
    getIt.registerLazySingleton(
        () => CreateFamilyUC(baseRepositoryProfile: getIt()));
    getIt.registerLazySingleton(
        () => GetConfigKeyUc(baseRepositoryProfile: getIt()));
    getIt.registerLazySingleton(
        () => ShowFamilymUsecase(baseRepositoryProfile: getIt()));
    getIt.registerLazySingleton(
        () => GetFamilyMemberUseCase(baseRepositoryProfile: getIt()));
    getIt.registerLazySingleton(
        () => GetFamilyRequestUsecase(baseRepositoryProfile: getIt()));
    getIt.registerLazySingleton(
        () => DeleteFamilyUseCse(baseRepositoryProfile: getIt()));
    getIt.registerLazySingleton(
        () => FamilyTakeActionUsecase(baseRepositoryProfile: getIt()));
    getIt.registerLazySingleton(
        () => ChangeUserTypeUsecase(baseRepositoryProfile: getIt()));

    getIt.registerLazySingleton(
        () => RemoveUserFromFamilyUsecase(baseRepositoryProfile: getIt()));
    getIt.registerLazySingleton(
        () => JoinFamilymUsecase(baseRepositoryProfile: getIt()));
    getIt.registerLazySingleton(
        () => ExitFamilyUsecase(baseRepositoryProfile: getIt()));

    getIt.registerLazySingleton(() => FeedBackUseCase(baseRepository: getIt()));
    getIt.registerLazySingleton(
        () => GetFriendsOrFollowersUsecase(relationRepo: getIt()));
    getIt.registerLazySingleton(
        () => GetVistorUseCase(baseRepositoryProfile: getIt()));
    getIt.registerLazySingleton(
        () => GetUserDataUseCase(baseRepositoryProfile: getIt()));
    getIt.registerLazySingleton(
        () => GiftHistorykUseCase(baseRepositoryProfile: getIt()));
    getIt.registerLazySingleton(
        () => FollowOrUnFollowUsecase(relationRepo: getIt()));
    getIt.registerLazySingleton(
        () => BoundPlatformUC(baseRepositoryProfile: getIt()));
    getIt.registerLazySingleton(
        () => DeleteAccountUC(baseRepositoryProfile: getIt()));
    getIt.registerLazySingleton(() => GetFollwingRoomsUC(repoFollow: getIt()));

    getIt.registerLazySingleton(() => GetCarouselsUsecase(repoHome: getIt()));
    getIt.registerLazySingleton(() => GetCountryUseCase(repoHome: getIt()));
    getIt.registerLazySingleton(() => AllRoomsUsecase(repoHome: getIt()));

    getIt.registerLazySingleton(
        () => SearchUseCase(baseRepositoryProfile: getIt()));

    getIt.registerLazySingleton(() => GetTopUseCase(exploreExp: getIt()));

    getIt.registerLazySingleton(
        () => GetReplaceWithGoldUseCase(baseRepositoryProfile: getIt()));

    getIt.registerLazySingleton(
        () => ExchangeDimondsUseCase(baseRepositoryProfile: getIt()));

    getIt.registerLazySingleton(
        () => JoinToAgencieUsecase(baseRepositoryProfile: getIt()));

    getIt.registerLazySingleton(
        () => TimeDataReportUseCases(getTimeDataReport: getIt()));

    getIt.registerLazySingleton(() => ChargeToUseCases(getChargeTo: getIt()));

    getIt.registerLazySingleton(
        () => GetMyStoreUseCase(baseRepositoryProfile: getIt()));

    getIt.registerLazySingleton(
        () => ShowAgencymUsecase(baseRepositoryProfile: getIt()));

    getIt.registerLazySingleton(
        () => AgencyMembermUsecase(baseRepositoryProfile: getIt()));

    getIt.registerLazySingleton(
        () => AgencyRequestsUsecase(baseRepositoryProfile: getIt()));
    getIt.registerLazySingleton(
        () => AgencyRequestsActionUsecase(baseRepositoryProfile: getIt()));

    getIt.registerLazySingleton(
        () => ChargeHistoryUseCases(chargeHistoryUc: getIt()));

    getIt.registerLazySingleton(
        () => AgencyHistoryTimemUsecase(baseRepositoryProfile: getIt()));

            getIt.registerLazySingleton(
        () => AgencyHistoryUsecase(baseRepositoryProfile: getIt()));

     getIt.registerLazySingleton(
        () => ChargeCoinForUserUsecase(baseRepositoryProfile: getIt()));

             getIt.registerLazySingleton(
        () => ChargeDolarsForUserUsecase(baseRepositoryProfile: getIt()));

                getIt.registerLazySingleton(
        () => GetChargeDolarsAgencyOwnerHistoryUseCase(chargeHistoryUc: getIt()));
                        getIt.registerLazySingleton(
        () => GetChargeCoinsSystemHistoryUseCases(chargeHistoryUc: getIt()));

                                getIt.registerLazySingleton(
        () => GetAllIntrestedUseCase(baseRepositoryProfile: getIt()));
                                        getIt.registerLazySingleton(
        () => AddInterstedUsecase(baseRepositoryProfile: getIt()));

        getIt.registerLazySingleton(
        () => GetUserIntrestedUseCase(baseRepositoryProfile: getIt()));

    getIt.registerLazySingleton(
            () => GetFamilyRoomUsecase(baseRepositoryProfile: getIt()));
               getIt.registerLazySingleton(
        () => PrevActiveUseCases(baseRepositoryProfile: getIt()));
               getIt.registerLazySingleton(
        () => PrevDisposeUseCases(baseRepositoryProfile: getIt()));

                 getIt.registerLazySingleton(
        () => UploadReelUseCase(baseRepositoryReel: getIt()));
                getIt.registerLazySingleton(
        () => GetReelUseCase(baseRepositoryReel: getIt()));
               getIt.registerLazySingleton(
        () => UserReporetUseCase(baseRepository: getIt()));

         getIt.registerLazySingleton(
        () => ReportRealsUseCases(baseRepositoryReel: getIt()));

    getIt.registerLazySingleton(() => GetFollowingReelUseCase(baseRepositoryReel: getIt()));



//repo


    getIt.registerLazySingleton<BaseRepository>(
        () => RepositoryImp(baseRemotlyDataSource: getIt()));

    getIt.registerLazySingleton<BaseRepositoryMoment>(
        () => RepositoryImpMoment(baseRemotlyDataSourceMoment: getIt()));

    getIt.registerLazySingleton<BaseRepositoryProfile>(
        () => RepositoryImpProfile(baseRemotlyDataSourceProfile: getIt()));
    getIt.registerLazySingleton<BaseRepositoryRoom>(
            () => RepositoryImpRoom(baseRemotlyDataSourceRoom: getIt()));
    getIt.registerLazySingleton<RepoHome>(
        () => HomeRepostoryImp(homeRemoteDataSours: getIt()));
    getIt.registerLazySingleton<RepoFollow>(
        () => FollwoingRepostoryImp(follwoingRemoteDataSours: getIt()));
          getIt.registerLazySingleton<BaseRepositoryReels>(
        () => RepositoryReels(baseRemotlyDataSourceReels: getIt()));

//data source
    getIt.registerLazySingleton<BaseRemotlyDataSourceMoment>(
            () => RemotlyDataSourceMoment());
    getIt.registerLazySingleton<BaseRemotlyDataSourceRoom>(
            () => RemotlyDataSourceRoom());
    getIt.registerLazySingleton<BaseRemotlyDataSource>(
        () => RemotlyDataSource());
    getIt.registerLazySingleton<BaseRemotlyDataSourceProfile>(
        () => RemotlyDataSourceProfile());

    getIt.registerLazySingleton<HomeRemoteDataSours>(
        () => HomeRemoteDataSoursImp());

    getIt.registerLazySingleton<FollwoingRemoteDataSours>(
        () => FollwingRemoteDataSoursImp());
            getIt.registerLazySingleton<BaseRemotlyDataSourceReels>(
        () => RemotlyDataSourceReels());




    SetTimerPK setTimerPK = SetTimerPK();
    getIt.registerLazySingleton(() => setTimerPK);

    TimeData timeData = TimeData() ;
    getIt.registerLazySingleton(() => timeData);

    SetTimerLuckyBox setTimer = SetTimerLuckyBox();
    getIt.registerLazySingleton(() => setTimer);

    //extarnal

    final sharedPreferences = await SharedPreferences.getInstance();
    getIt.registerLazySingleton(() => sharedPreferences);
    final cacheManager =  DefaultCacheManager();
    getIt.registerLazySingleton(() => cacheManager);
   final VideoCacheManager videoCacheManager = VideoCacheManager() ;
    getIt.registerLazySingleton(() => videoCacheManager);
    final MyDataModel cacheMyData = await Methods.instance.returnMyData();
    getIt.registerLazySingleton(() => cacheMyData);
    FireBaseDataSource fireBaseDataSource = FireBaseDataSource();
    getIt.registerLazySingleton(() => fireBaseDataSource);

    sharedPreferences.getBool(StringManager.keepLogin) == null
        ? sharedPreferences.setBool(StringManager.keepLogin, false)
        : null;
  }
}
