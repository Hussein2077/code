

import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/base_use_case/base_use_case.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/core/model/all_rooms_model.dart';
import 'package:tik_chat_v2/core/model/owner_data_model.dart';
import 'package:tik_chat_v2/core/model/vip_center_model.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/features/profile/data/data_sorce/remotly_data_source_profile.dart';
import 'package:tik_chat_v2/features/profile/data/model/agency_history_model.dart';
import 'package:tik_chat_v2/features/profile/data/model/agency_my_store.dart';
import 'package:tik_chat_v2/features/profile/data/model/agency_time_history_model.dart';
import 'package:tik_chat_v2/features/profile/data/model/black_list_model.dart';
import 'package:tik_chat_v2/features/profile/data/model/charge_history_model.dart';
import 'package:tik_chat_v2/features/profile/data/model/charge_page_model.dart';
import 'package:tik_chat_v2/features/profile/data/model/charge_to_model.dart';
import 'package:tik_chat_v2/features/profile/data/model/family_member_model.dart';
import 'package:tik_chat_v2/features/profile/data/model/family_requests_model.dart';
import 'package:tik_chat_v2/features/profile/data/model/fanily_rank_model.dart';
import 'package:tik_chat_v2/features/profile/data/model/get_config_key_model.dart';
import 'package:tik_chat_v2/features/profile/data/model/get_time_entities.dart';
import 'package:tik_chat_v2/features/profile/data/model/get_vip_prev.dart';
import 'package:tik_chat_v2/features/profile/data/model/gift_history_model.dart';
import 'package:tik_chat_v2/features/profile/data/model/gold_coin_model.dart';
import 'package:tik_chat_v2/features/profile/data/model/replace_with_gold_model.dart';
import 'package:tik_chat_v2/features/profile/data/model/search_model.dart';
import 'package:tik_chat_v2/features/profile/data/model/show_agency_model.dart';
import 'package:tik_chat_v2/features/profile/data/model/show_family_model.dart';
import 'package:tik_chat_v2/features/profile/data/model/silver_coins_model.dart';
import 'package:tik_chat_v2/features/profile/data/model/silver_history.dart';
import 'package:tik_chat_v2/features/profile/data/model/useitem_model.dart';
import 'package:tik_chat_v2/features/profile/domin/Repository/base_repository_profile.dart';
import 'package:tik_chat_v2/features/profile/domin/entitie/data_mall_entities.dart';
import 'package:tik_chat_v2/features/profile/domin/entitie/back_pack_entities.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/bound_platform_uc.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/buy_coins_uc.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/charge_to_uc.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/create_family_uc.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/feed_back_usecase.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/get_config_key.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/update_family_uc.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/user_reporet_uc.dart';



class RepositoryImpProfile extends BaseRepositoryProfile {
  final BaseRemotlyDataSourceProfile baseRemotlyDataSourceProfile;


  RepositoryImpProfile(
      {required this.baseRemotlyDataSourceProfile});


  @override
  Future<Either<OwnerDataModel, Failure>> getmyData(
      Noparamiter noparamiter) async {
    try {
      final result = await baseRemotlyDataSourceProfile.getmyData(noparamiter);
      return Left(result);
    } on Exception catch (e) {
     return Right(DioHelper.buildFailure(e));
    }

    
    
  }

  @override
  Future<Either<List<DataMallEntities>, Failure>> getDataMall(int type) async {
    try {
      final result = await baseRemotlyDataSourceProfile.getDataMall(type);
      return Left(result);
    } on Exception catch (e) {
      return Right(DioHelper.buildFailure(e));
    }
  }

  @override
  Future<Either<Failure, String>> follow({required String userId}) async {
    try {
      final failureOrDone =
          await baseRemotlyDataSourceProfile.follow(userId: userId);
      return Right(failureOrDone);
    } on Exception catch (e) {
      return Left(DioHelper.buildFailure(e));
    }
  }

  @override
  Future<Either<Failure, List<OwnerDataModel>>> getFriendsOrFollowers(
      {required String type , String? page}) async {
    try {
      final failureOrDone =
          await baseRemotlyDataSourceProfile.getFriendsOrFollowers(type: type , page: page);
      return Right(failureOrDone);
    } on Exception catch (e) {
      return Left(DioHelper.buildFailure(e));
    }
  }

  @override
  Future<Either<Failure, String>> unFollow({required String userId}) async {
    try {
      final failureOrDone =
          await baseRemotlyDataSourceProfile.unFollow(userId: userId);
      return Right(failureOrDone);
    } on Exception catch (e) {
      return Left(DioHelper.buildFailure(e));
    }
  }

  @override
  Future<Either<OwnerDataModel, Failure>> getUserData(
      {required String userId  }) async {
    try {
      final result =
          await baseRemotlyDataSourceProfile.getUserData(userId: userId  );
      return left(result);
    } on Exception catch (e) {
      return right(DioHelper.buildFailure(e));
    }
  }

  @override
  Future<Either<List<VipCenterModel>, Failure>> getVipCenter(
      ) async {
    try {
      final result =
          await baseRemotlyDataSourceProfile.getVipCenter();
      return left(result);
    } on Exception catch (e) {
      return right(DioHelper.buildFailure(e));
    }

    
  }

  @override
  Future<Either<int,Failure>> getVipCount() async {
    try {
      final result = await baseRemotlyDataSourceProfile.getvipCount();
   return left(result);    } on Exception catch (e) {
      return right(DioHelper.buildFailure(e));
    }
  }

  @override
  Future<Either<List<OwnerDataModel>, Failure>> getVistors({String?page}) async {
    try {
      final result = await baseRemotlyDataSourceProfile.getVaistors(page : page);
      return left(result);
    } on Exception catch (e) {
      return right(DioHelper.buildFailure(e));
    }
    
  }





  @override
  Future<Either<List<BackPackEnities>, Failure>> getBckPack(String type) async {
    try {
      final result = await baseRemotlyDataSourceProfile.getBackPack(type);
      return left(result);
    } on Exception catch (e) {
      return right(DioHelper.buildFailure(e));
    }
  }

  @override
  Future<Either<UesItemModel, Failure>> useItem(String id) async {
    try {
      final result = await baseRemotlyDataSourceProfile.useItem(id);
      return left(result);
    } on Exception catch (e) {
      return right(DioHelper.buildFailure(e));
    }
  }



  @override
  Future<Either<String, Failure>> createFamily(
      CreateFamilyPramiter createFamilyPramiter) async {
    try {
      final result =
          await baseRemotlyDataSourceProfile.creatFamily(createFamilyPramiter);
      log(result.toString());
      return left(result);
    } on Exception catch (e) {
      return right(DioHelper.buildFailure(e));
    }
    
  }


  @override
  Future<Either<String, Failure>> buy(String idItem, String quantity) async {
    try {
      final result = await baseRemotlyDataSourceProfile.buy(idItem, quantity);
      return left(result);
    } on Exception catch (e) {
      return right(DioHelper.buildFailure(e));
    }
  }

  @override
  Future<Either<String, Failure>> sendItem(String packId, String touid) async {
    try {
      final result = await baseRemotlyDataSourceProfile.sendPack(packId, touid);
      return left(result);
    } on Exception catch (e) {
      return right(DioHelper.buildFailure(e));
    }
  }

  @override
  Future<Either<String, Failure>> unusedItem(String id) async {
    try {
      final result = await baseRemotlyDataSourceProfile.unUsedPack(id);
      return left(result);
    } on Exception catch (e) {
      return right(DioHelper.buildFailure(e));
    }
  }

  @override
  Future<Either<FamilyRankModel, Failure>> familyRanking(String time) async {
    try {
      final result = await baseRemotlyDataSourceProfile.familyRanking(time);
      return left(result);
    } on Exception catch (e) {
      return right(DioHelper.buildFailure(e));
    }

    
  }

  @override
  Future<Either<String, Failure>> deletFamily(String id) async {
    try {
      final result = await baseRemotlyDataSourceProfile.deletFamily(id);
      return left(result);
    } on Exception catch (e) {
      return right(DioHelper.buildFailure(e));
    }
  }

  @override
  Future<Either<String, Failure>> familyRemovUser(
      String uId, String familyId) async {
    try {
      final result = await baseRemotlyDataSourceProfile.removeUserFromFamily(
          uId, familyId);
      return left(result);
    } on Exception catch (e) {
      return right(DioHelper.buildFailure(e));
    }
  }

  @override
  Future<Either<ShowFamilyModel, Failure>> showFamily(String id) async {
    try {
      final result = await baseRemotlyDataSourceProfile.showFamily(id);
      return left(result);
    } on Exception catch (e) {
      return right(DioHelper.buildFailure(e));
    }

     
    
  }

  @override
  Future<Either<String, Failure>> joinFamily(String familyId) async {
    try {
      final result = await baseRemotlyDataSourceProfile.joinFamily(familyId);
      return left(result);
    } on Exception catch (e) {
      return right(DioHelper.buildFailure(e));
    }
  }

  @override
  Future<Either<FamilyRequestsModel, Failure>> getFamilyRequest() async {
    try {
      final result = await baseRemotlyDataSourceProfile.getfamilyRequest();
      return left(result);
    } on Exception catch (e) {
      return right(DioHelper.buildFailure(e));
    }
  }

  @override
  Future<Either<String, Failure>> familyTakeAction(
      String reqId, String status) async {
    try {
      final result =
          await baseRemotlyDataSourceProfile.familyTakeAction(reqId, status);
      return left(result);
    } on Exception catch (e) {
      return right(DioHelper.buildFailure(e));
    }
  }

  @override
  Future<Either<String, Failure>> changeUserType(
      String userId, String familyId, String type) async {
    try {
      final result = await baseRemotlyDataSourceProfile.changeUserType(
          userId, familyId, type);
      return left(result);
    } on Exception catch (e) {
      return right(DioHelper.buildFailure(e));
    }
  }

  @override
  Future<Either<FamilyMemberModel, Failure>> getFamilyMember(
      String familyId , String?page) async {
    try {
      final result =
          await baseRemotlyDataSourceProfile.getFamilyMember(familyId , page);
      return left(result);
    } on Exception catch (e) {
      return right(DioHelper.buildFailure(e));
    }
  }

  @override
  Future<Either<AllRoomsDataModel, Failure>> getFamilyRoom(
      String familyId) async {
    try {
      final result = await baseRemotlyDataSourceProfile.getFamilyRoom(familyId);
      return left(result);
    } on Exception catch (e) {
      return right(DioHelper.buildFailure(e));
    }
  }

  @override
  Future<Either<String, Failure>> exitFamily() async {
    try {
      final result = await baseRemotlyDataSourceProfile.exitFamily();
      return left(result);
    } on Exception catch (e) {
      return right(DioHelper.buildFailure(e));
    }
  }

  @override
  Future<Either<BlackListModel, Failure>> getBlackList() async {
    try {
      final result = await baseRemotlyDataSourceProfile.getBlackList();
      return left(result);
    } on Exception catch (e) {
      return right(DioHelper.buildFailure(e));
    }
  }

  @override
  Future<Either<String, Failure>> removeBlock(String userId) async {
    try {
      final result = await baseRemotlyDataSourceProfile.removeBlock(userId);
      return left(result);
    } on Exception catch (e) {
      return right(DioHelper.buildFailure(e));
    }
  }

  @override
  Future<Either<String, Failure>> addBlock(String userId) async {
    try {
      final result = await baseRemotlyDataSourceProfile.addBlock(userId);
      return left(result);
    } on Exception catch (e) {
      return right(DioHelper.buildFailure(e));
    }
  }

  @override
  Future<Either<SilverCoinsModel, Failure>> getSilverData() async{
   try {
      final result = await baseRemotlyDataSourceProfile.getSilverCoinData();
      return left(result);
    } on Exception catch (e) {
      return right(DioHelper.buildFailure(e));
    }
  }

  @override
  Future<Either<String, Failure>> buySilverCoin(String silverId)async {
     try {
      final result = await baseRemotlyDataSourceProfile.buySilverCoin(silverId);
      return left(result);
    } on Exception catch (e) {
      return right(DioHelper.buildFailure(e));
    }
  }

  @override
  Future<Either<List<SilverCoinHistory>, Failure>> getSilverHistory() async{
      try {
      final result = await baseRemotlyDataSourceProfile.getSilverHistory();
      return left(result);
    } on Exception catch (e) {
      return right(DioHelper.buildFailure(e));
    }
  }

  @override
  Future<Either<DataWalletModel, Failure>> getChargePage()async {
    try {
      final result = await baseRemotlyDataSourceProfile.getChargePage();
      return left(result);
    } on Exception catch (e) {
      return right(DioHelper.buildFailure(e));
    }
     
  }


  @override
  Future<Either<ChargeToModel, Failure>> getChargeTo(ChargeToPramiter chargeToPramiter)async {
    try {
      final result = await baseRemotlyDataSourceProfile.chargeTo(chargeToPramiter);
      return left(result);
    } on Exception catch (e) {
      return right(DioHelper.buildFailure(e));
    }
  }

  @override
  Future<Either<ChargeHistoryModel, Failure>> getChargeHistory(String parameter)async {
    try {
      final result = await baseRemotlyDataSourceProfile.getChargeHistory(parameter);
      return left(result);
    } on Exception catch (e) {
      return right(DioHelper.buildFailure(e));
    }
  }


  
  @override
  Future<Either<String, Failure>> buyOrSendVip(String type, String vipId ,String toUId)async {
   try {
      final result = await baseRemotlyDataSourceProfile.buyOrSendVip(type , vipId , toUId);
      return left(result);
    } on Exception catch (e) {
      return right(DioHelper.buildFailure(e));
    }
    
  }

  @override
  Future<Either<List<GoldCoinsModel>, Failure>> getGoldCoinData()async {
     try {
      final result = await baseRemotlyDataSourceProfile.getGoldCoinData();
      return left(result);
    } on Exception catch (e) {
      return right(DioHelper.buildFailure(e));
    }
    
  }
  


  @override
  Future<Either<ReplaceWithGoldModel, Failure>> replaceWithGold() async{
     try {
      final result = await baseRemotlyDataSourceProfile.getReplaceWithDimondData();
      return left(result);
    } on Exception catch (e) {
      return right(DioHelper.buildFailure(e));
    }
    
  }
  
  @override
  Future<Either<String, Failure>> exchangeDimond(String itemId) async{
   try {
      final result = await baseRemotlyDataSourceProfile.exchangeDimond(itemId);
      return left(result);
    } on Exception catch (e) {
      return right(DioHelper.buildFailure(e));
    }
  }

    @override
  Future<Either<SearchModel, Failure>> search(String keyWord) async {
    try {
      final result = await baseRemotlyDataSourceProfile.search(keyWord);
      return Left(result);
    } on Exception catch (e) {
      return Right(DioHelper.buildFailure(e));
    }
  }
  
  @override
  Future<bool> checkIfFriend(String userId) async {
    try {
      final result = await baseRemotlyDataSourceProfile.checkIfFriend(userId);
      return result;
    } on Exception {
      throw ServerFailure();
    }
  }

    @override
  Future<Either<String, Failure>> lastCommunicationTime(String type) async {
    try {
      final result = await baseRemotlyDataSourceProfile.lastCommunicationTime(type) ;
      return left(result);
    } on Exception catch (e) {
      return Right(DioHelper.buildFailure(e));
    }
  }

  @override
  Future<Either<String, Failure>> hideCountry(String type) async {
    try {
      final result = await baseRemotlyDataSourceProfile.lastCommunicationTime(type) ;
      return left(result);
    } on Exception catch (e) {
      return Right(DioHelper.buildFailure(e));
    }
  }
  @override
  Future<Either<String, Failure>> hideVisitor(String type) async {
    try {
      final result = await baseRemotlyDataSourceProfile.lastCommunicationTime(type) ;
      return left(result);
    } on Exception catch (e) {
      return Right(DioHelper.buildFailure(e));
    }
  }

    @override
  Future<Either<String, Failure>> activeMyseteriousMan(String type) async {
    try {
      final result = await baseRemotlyDataSourceProfile.activeMyseteriousMan(type) ;
      return left(result);
    } on Exception catch (e) {
      return Right(DioHelper.buildFailure(e));
    }
  }

    @override
  Future<Either<String, Failure>> disposeMyseteriousMan(String type) async {
    try {
      final result = await baseRemotlyDataSourceProfile.disposeMyseteriousMan(type) ;
      return left(result);
    } on Exception catch (e) {
      return Right(DioHelper.buildFailure(e));
    }
  }
  
  @override
  Future<Either<String, Failure>> dipsoseLastCommunicationTime(String type)async {
     try {
      final result = await baseRemotlyDataSourceProfile.dipsoseLastCommunicationTime(type) ;
      return left(result);
    } on Exception catch (e) {
      return Right(DioHelper.buildFailure(e));
    }
  }
  
  @override
  Future<Either<String, Failure>> disposeHideCountry(String type)async {
     try {
      final result = await baseRemotlyDataSourceProfile.disposeHideCountry(type) ;
      return left(result);
    } on Exception catch (e) {
      return Right(DioHelper.buildFailure(e));
    }
  }
  
  @override
  Future<Either<String, Failure>> disposeHideVisitor(String type)async {
      try {
      final result = await baseRemotlyDataSourceProfile.disposeHideVisitor(type) ;
      return left(result);
    } on Exception catch (e) {
      return Right(DioHelper.buildFailure(e));
    }
  }
  
  @override
  Future<Either<GetVipPrevModel, Failure>> getVipPerv()async {
        try {
      final result = await baseRemotlyDataSourceProfile.getVipPrev() ;
      return left(result);
    } on Exception catch (e) {
      return Right(DioHelper.buildFailure(e));
    }
  }

  @override
  Future<Either<String, Failure>> buyCoins(BuyCoinsParameter buyCoinsParameter) async {
    try {
      final result = await baseRemotlyDataSourceProfile.buyCoins(buyCoinsParameter);
      return left(result);
    } on Exception catch (e) {
      return right(DioHelper.buildFailure(e));
    }
  }

    @override
  Future<Either<List<GiftHistoryModel>, Failure>> getGiftHistory(String id) async{
    try {
      final result = await baseRemotlyDataSourceProfile.getGiftHistory(id);
      return Left(result);
    } on Exception catch (e) {
      return Right(DioHelper.buildFailure(e));
    }

  }

 @override
  Future<Either<TimeDataReport, Failure>> getTimeDataReport(String time , String userId)async {

   try {
      final result = await baseRemotlyDataSourceProfile.getTimeDataReport(time , userId);
      return left(result);
     } on Exception catch (e) {
      return right(DioHelper.buildFailure(e));
     }
  }

  @override
  Future<Either<String, Failure>> deleteAccount() async {
    try {
      final result = await baseRemotlyDataSourceProfile.deleteAccount();
      log(result.toString());
      return left(result);
    } on Exception catch (e) {
      return right(DioHelper.buildFailure(e));
    }
  }

  @override
  Future<Either<String, Failure>> bountFacebook() async {
    try {
      final result = await baseRemotlyDataSourceProfile.boundFacebook();
      log(result.toString());
      return left(result);
    } on Exception {
      return right(SiginFacebookFailure());
    }
  }

  @override
  Future<Either<String, Failure>> bountGmail() async {
    try {
      final result = await baseRemotlyDataSourceProfile.boundGmail();
      log(result.toString());
      return left(result);
    } on Exception {
      return right(SiginGoogleFailure());
    }
  }

  @override
  Future<Either<String, Failure>> bountNumber(
      BoundNumberPramiter boundNumberPramiter) async {
    try {
      final result =
      await baseRemotlyDataSourceProfile.boundNumber(boundNumberPramiter);
      log(result.toString());
      return left(result);
    } on Exception catch (e) {
      return right(DioHelper.buildFailure(e));
    }
  }

  @override
  // ignore: non_constant_identifier_names
  Future<Either<String, Failure>> ChangePassword(
      BoundNumberPramiter boundNumberPramiter) async {
    try {
      final result = await baseRemotlyDataSourceProfile
          .changePassword(boundNumberPramiter);
      log(result.toString());
      return left(result);
    } on Exception catch (e) {
      return right(DioHelper.buildFailure(e));
    }
  }

  @override
  // ignore: non_constant_identifier_names
  Future<Either<String, Failure>> ChangePhone(
      BoundNumberPramiter boundNumberPramiter) async {
    try {
      final result =
      await baseRemotlyDataSourceProfile.changePhone(boundNumberPramiter);
      return left(result);
    } on Exception catch (e) {
      return right(DioHelper.buildFailure(e));
    }
  }
  
  @override
  Future<Either<bool, Failure>> joinToAgencie(String agencieId, String whatsAppNum)async {
   try {
      final result =
      await baseRemotlyDataSourceProfile.joinToAgencie(agencieId , whatsAppNum);
      return left(result);
    } on Exception catch (e) {
      return right(DioHelper.buildFailure(e));
    }
  }

  @override
  Future<Either<bool, Failure>> updateFamily(UpdateFamilyPramiter parameter) async{
   try {
      final result =
      await baseRemotlyDataSourceProfile.updateFamily( parameter);
      return left(result);
    } on Exception catch (e) {
      return right(DioHelper.buildFailure(e));
    }
  }

  @override
  Future<Either<String, Failure>> userReporet(UserReporetPramiter pramiter) async{
     try {
      final result = await baseRemotlyDataSourceProfile.userReporet(pramiter) ;
      return left(result);
    } on Exception catch (e) {
      return Right(DioHelper.buildFailure(e));
    }
  }

    @override
  Future<Either<GetConfigKeyModel, Failure>> getConfigKey(GetConfigKeyPram getConfigKeyPram) async{
      try {
      final result = await baseRemotlyDataSourceProfile.getConfigKey(getConfigKeyPram);
      return left(result);
    } on Exception catch (e) {
      return Right(DioHelper.buildFailure(e));
    }

  }

    @override
  Future<Either<String, Failure>> feedBack(FeedBackPramiter feedBackPramiter)async {
    try {
      final result =
      await baseRemotlyDataSourceProfile.feedBack(feedBackPramiter);
      return Left(result);
    } catch (e) {
      return right(DioHelper.buildFailure(e));
    }
  }

  @override
  Future<Either<AgencyMyStoreModel, Failure>> myStore()async {
   try {
      final result =
      await baseRemotlyDataSourceProfile.myStore();
      return Left(result);
    } catch (e) {
      return right(DioHelper.buildFailure(e));
    }
  }

  @override
  Future<Either<ShowAgencyModel, Failure>> showAgency()async {
  try {
      final result =
      await baseRemotlyDataSourceProfile.showAgency();
      return Left(result);
    } catch (e) {
      return right(DioHelper.buildFailure(e));
    }
  }
  
  @override
  Future<Either<List<OwnerDataModel>, Failure>> agencyMember(int page) async{
    try {
      final result =
      await baseRemotlyDataSourceProfile.agencyMember(page);
      return Left(result);
    } catch (e) {
      return right(DioHelper.buildFailure(e));
    }
    
  }
  
  @override
  Future<Either<List<OwnerDataModel>, Failure>> agencyRequests() async{
  try {
      final result =
      await baseRemotlyDataSourceProfile.agencyRequests();
      return Left(result);
    } catch (e) {
      return right(DioHelper.buildFailure(e));
    }
  }
  
  @override
  Future<Either<String, Failure>> agencyRequestsAction({required String userId, required bool accept})async {
   try {
      final result =
      await baseRemotlyDataSourceProfile.agencyRequestsAction(accept:accept , userId: userId );
      return Left(result);
    } catch (e) {
      return right(DioHelper.buildFailure(e));
    }
  }

  @override
  Future<Either<List<AgencyHistoryTime>, Failure>> agencyTimeHistory()async {
  /*try {*/
      final result =
      await baseRemotlyDataSourceProfile.getAgencyHistoryTime( );
      return Left(result);
   /* } catch (e) {
      return right(DioHelper.buildFailure(e));
    }*/
  }

  @override
  Future<Either<AgencyHistoryModle, Failure>> agencyHistory({required String month, required String year})async {
    try {
      final result =
      await baseRemotlyDataSourceProfile.getAgencyHistory(month: month , year: year );
      return Left(result);
    } catch (e) {
      return right(DioHelper.buildFailure(e));
    }
  }
  
  @override
  Future<Either<String, Failure>> chargeCoinForUsers({required String id, required String amount})async {
   try {
      final result =
      await baseRemotlyDataSourceProfile.chargeCoinForUsers(amount: amount , id: id );
      return Left(result);
    } catch (e) {
      return right(DioHelper.buildFailure(e));
    }
  }
  
  @override
  Future<Either<String, Failure>> chargeDolarsForUsers({required String id, required String amount})async {
     try {
      final result =
      await baseRemotlyDataSourceProfile.chargeDolarsForUsers(amount: amount , id: id );
      return Left(result);
    } catch (e) {
      return right(DioHelper.buildFailure(e));
    }
  }

}
