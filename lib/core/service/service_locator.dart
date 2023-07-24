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
import 'package:tik_chat_v2/features/home/data/model/config_model.dart';
import 'package:tik_chat_v2/features/home/data/repository_imp/repository_imp.dart';
import 'package:tik_chat_v2/features/home/domin/repository/rebostory_ab.dart';
import 'package:tik_chat_v2/features/profile/data/Repository_Imp/repository_imp.dart';
import 'package:tik_chat_v2/features/profile/data/data_sorce/remotly_data_source_profile.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/get_data_use_case.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/get_mydata_usecase.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_my_data_manager/get_my_data_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/mall_manager/mall_bloc.dart';

final getIt = GetIt.instance;

class ServerLocator {
    Future<void> init() async {
 
 //bloc
    getIt.registerFactory(() => SignInWithPlatformBloc(signInWithGoogleUC: getIt()));
    getIt.registerFactory(() => AddInfoBloc(addInFormationUC: getIt()));
        getIt.registerFactory(() => RegisterWithPhoneBloc(registerWithPhoneUsecase: getIt()));

        getIt.registerFactory(() => LoginWithPhoneBloc(loginWithPhoneUseCase: getIt()));
        getIt.registerFactory(() => LogOutBloc(logOutUseCase: getIt()));

            getIt.registerFactory(() => GetMyDataBloc(getmyDataUsecase: getIt()));
                        getIt.registerFactory(() => MallBloc(gatDataUseCase: getIt()));




//usecase
    getIt.registerLazySingleton(
        () => SignInWithGoogleUC(baseRepository: getIt()));

    getIt.registerLazySingleton(
        () => AddInFormationUC(baseRepository: getIt()));

    getIt.registerLazySingleton(
        () => RegisterWithPhoneUsecase(baseRepository: getIt()));
            getIt.registerLazySingleton(
        () => LoginWithPhoneUseCase(baseRepository: getIt()));
        getIt.registerLazySingleton(
        () => LogOutUseCase(baseRepository: getIt()));
            getIt.registerLazySingleton(
        () => GetmyDataUsecase(baseRepositoryProfile: getIt()));
          getIt.registerLazySingleton(
        () => GatDataMallUseCase(baseRepositoryProfile: getIt()));


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

    final OwnerDataModel cacheMyData = await Methods().returnUserData() ;
      getIt.registerLazySingleton(() => cacheMyData);
     FireBaseDataSource fireBaseDataSource = FireBaseDataSource();
    getIt.registerLazySingleton(() => fireBaseDataSource);

      
    }
}
