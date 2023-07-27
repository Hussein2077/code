import 'dart:developer';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tik_chat_v2/core/model/owner_data_model.dart';
import 'package:tik_chat_v2/core/utils/api_healper/methods.dart';
import 'package:tik_chat_v2/features/auth/data/data_soruce/fire_base_datasource.dart';
import 'package:tik_chat_v2/features/auth/data/data_soruce/remotly_datasource.dart';
import 'package:tik_chat_v2/features/auth/data/repo_imp/repo_imp.dart';
import 'package:tik_chat_v2/features/auth/domin/repo/base_repo.dart';
import 'package:tik_chat_v2/features/auth/domin/use_case/add_info_use_case.dart';
import 'package:tik_chat_v2/features/auth/domin/use_case/google_sign_in_usecase.dart';
import 'package:tik_chat_v2/features/auth/domin/use_case/log_out_usecase.dart';
import 'package:tik_chat_v2/features/auth/domin/use_case/login_with_phone_usecase.dart';
import 'package:tik_chat_v2/features/auth/domin/use_case/register_with_phone_usecase.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/add_info_bloc/add_info_bloc.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/log_out_manager/log_out_bloc.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/login_with_phone_manager/login_with_phone_bloc.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/register_with_phone_manager/register_with_phone_bloc.dart';
import 'package:tik_chat_v2/features/auth/presentation/manager/sign_in_with_paltform_manager/sign_in_with_platform_bloc.dart';
import 'package:tik_chat_v2/features/following/data/data_sorce/follwoing_remote_data_sours.dart';
import 'package:tik_chat_v2/features/following/data/repository_imp/repository_imp.dart';
import 'package:tik_chat_v2/features/following/domin/repository/follwoing_repository.dart';
import 'package:tik_chat_v2/features/home/data/data_source/home_remote_data_source.dart';
import 'package:tik_chat_v2/features/home/data/repository_imp/repository_imp.dart';
import 'package:tik_chat_v2/features/home/domin/repository/rebostory_ab.dart';
import 'package:tik_chat_v2/features/profile/data/Repository_Imp/repository_imp.dart';
import 'package:tik_chat_v2/features/profile/data/data_sorce/remotly_data_source_profile.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/back_pack_usecase.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/buy_or_send_vip.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/buy_usecase.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/change_user_type.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/create_family_uc.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/delet_family_usecase.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/family_ranking_usecase.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/family_take_action_usecase.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/get_config_key.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/get_data_use_case.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/get_family_member_usecase.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/get_family_request_usecase.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/get_mydata_usecase.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/get_vip_center_usecase.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/join_family_usecase.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/remove_user_family_usecase.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/show_family_usecase.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/unused_item_usecase.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/use_item_usecase.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/family_manager/family_ranking_manager/family_ranking_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/family_manager/manager_delete_family/bloc/delete_family_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/family_manager/manager_family_member/bloc/family_member_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/family_manager/manager_family_take_action/bloc/take_action_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/family_manager/manager_join_family/bloc/join_family_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/family_manager/manager_remove_user/bloc/family_remove_user_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/family_manager/manger_change_user_type/bloc/change_user_type_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/family_manager/manger_create_family/bloc/create_family_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/family_manager/manger_show_family/bloc/show_family_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_my_data_manager/get_my_data_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/mall_buy_manager/mall_buy_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/mall_manager/mall_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/family_manager/manager_family_requests/bloc/family_request_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_get_config_key/get_config_keys_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_use_item/use_item_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manger_buy_send_vip/bloc/buy_or_send_vip_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manger_vip_center/vip_center_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/my_bag_manager/my_bag_bloc.dart';

final getIt = GetIt.instance;

class ServerLocator {
  Future<void> init() async {
    //bloc
    getIt.registerFactory(
        () => SignInWithPlatformBloc(signInWithGoogleUC: getIt()));
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
        

//usecase
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
//repo
    getIt.registerLazySingleton<BaseRepository>(
        () => RepositoryImp(baseRemotlyDataSource: getIt()));
    getIt.registerLazySingleton<BaseRepositoryProfile>(
        () => RepositoryImpProfile(baseRemotlyDataSourceProfile: getIt()));

    getIt.registerLazySingleton<RepoHome>(
        () => HomeRepostoryImp(homeRemoteDataSours: getIt()));
    getIt.registerLazySingleton<RepoFollow>(
        () => FollwoingRepostoryImp(follwoingRemoteDataSours: getIt()));

//data source

    getIt.registerLazySingleton<BaseRemotlyDataSource>(
        () => RemotlyDataSource());
    getIt.registerLazySingleton<BaseRemotlyDataSourceProfile>(
        () => RemotlyDataSourceProfile());

    getIt.registerLazySingleton<HomeRemoteDataSours>(
        () => HomeRemoteDataSoursImp());

    getIt.registerLazySingleton<FollwoingRemoteDataSours>(
        () => FollwingRemoteDataSoursImp());

    //extarnal

    final sharedPreferences = await SharedPreferences.getInstance();
    getIt.registerLazySingleton(() => sharedPreferences);

    final OwnerDataModel cacheMyData = await Methods().returnUserData();
    log('cacheMyData${cacheMyData.id}');
    getIt.registerLazySingleton(() => cacheMyData);
    FireBaseDataSource fireBaseDataSource = FireBaseDataSource();
    getIt.registerLazySingleton(() => fireBaseDataSource);
  }
}
