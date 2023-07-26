
import 'package:dartz/dartz.dart';
import 'package:tik_chat_v2/core/base_use_case/base_use_case.dart';
import 'package:tik_chat_v2/core/error/failures.dart';
import 'package:tik_chat_v2/core/model/all_rooms_model.dart';
import 'package:tik_chat_v2/core/model/owner_data_model.dart';
import 'package:tik_chat_v2/core/model/vip_center_model.dart';
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
import 'package:tik_chat_v2/features/profile/data/model/show_family_model.dart';
import 'package:tik_chat_v2/features/profile/data/model/silver_coins_model.dart';
import 'package:tik_chat_v2/features/profile/data/model/silver_history.dart';
import 'package:tik_chat_v2/features/profile/data/model/useitem_model.dart';
import 'package:tik_chat_v2/features/profile/domin/entitie/data_mall_entities.dart';
import 'package:tik_chat_v2/features/profile/domin/entitie/back_pack_entities.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/bound_platform_uc.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/buy_coins_uc.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/charge_to_uc.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/create_family_uc.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/get_config_key.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/update_family_uc.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/user_reporet_uc.dart';


abstract class BaseRepositoryProfile {

  Future<Either<OwnerDataModel, Failure>> getmyData(Noparamiter noparamiter);

  Future<Either<List<DataMallEntities>, Failure>> getDataMall(int type);

  Future<Either<Failure, List<OwnerDataModel>>> getFriendsOrFollowers(
      {required String type, String? page});
  Future<Either<Failure, String>> follow({required String userId});

  Future<Either<Failure, String>> unFollow({required String userId});

  Future<Either<OwnerDataModel, Failure>> getUserData({required String userId , bool? sendFireBase ,});

  Future<Either<List<VipCenterModel>, Failure>> getVipCenter();

  Future<Either<int,Failure>> getVipCount();


  Future<Either<List<OwnerDataModel>, Failure>> getVistors({String?page});
  Future<bool> checkIfFriend(String userId);

  Future<Either<List<BackPackEnities>, Failure>> getBckPack(String type);

  Future<Either<UesItemModel, Failure>> useItem(String id);


  Future<Either<String, Failure>> deleteAccount();
  Future<Either<String, Failure>> createFamily(
      CreateFamilyPramiter createFamilyPramiter);

  Future<Either<String, Failure>> buy(String idItem, String quantity);

  Future<Either<String, Failure>> sendItem(String packId, String touid);

  Future<Either<String, Failure>> unusedItem(String id);

  Future<Either<FamilyRankModel, Failure>> familyRanking(String time);

  Future<Either<String, Failure>> deletFamily(String id);

  Future<Either<String, Failure>> familyRemovUser(String uId, String familyId);

  Future<Either<ShowFamilyModel, Failure>> showFamily(String id);

  Future<Either<String, Failure>> joinFamily(String familyId);

  Future<Either<FamilyRequestsModel, Failure>> getFamilyRequest();

  Future<Either<String, Failure>> familyTakeAction(String reqId, String status);

  Future<Either<String, Failure>> changeUserType(
      String userId, String familyId, String type);

  Future<Either<FamilyMemberModel, Failure>> getFamilyMember(String familyId , String? page);

  Future<Either<AllRoomsDataModel, Failure>> getFamilyRoom(String familyId);

  Future<Either<String, Failure>> exitFamily();

  Future<Either<BlackListModel, Failure>> getBlackList();

  Future<Either<String, Failure>> removeBlock(String userId);

  Future<Either<String, Failure>> addBlock(String userId);

  Future<Either<SearchModel, Failure>> search(String keyWord);

  Future<Either<DataWalletModel, Failure>> getChargePage();

  Future<Either<ChargeToModel, Failure>> getChargeTo(
      ChargeToPramiter chargeToPramiter);

  Future<Either<ChargeHistoryModel, Failure>> getChargeHistory(
      String parameter);


  Future<Either<SilverCoinsModel, Failure>> getSilverData();

  Future<Either<String, Failure>> buySilverCoin(String silverId);

  Future<Either<List<SilverCoinHistory>, Failure>> getSilverHistory();

  Future<Either<String, Failure>> buyOrSendVip(
      String type, String vipId, String toUId);

  Future<Either<List<GoldCoinsModel>, Failure>> getGoldCoinData();

  Future<Either<ReplaceWithGoldModel, Failure>> replaceWithGold();

  Future<Either<String, Failure>> exchangeDimond(String itemId);

  Future<Either<String, Failure>> lastCommunicationTime(String type);

  Future<Either<String, Failure>> hideCountry(String type);

  Future<Either<String, Failure>> hideVisitor(String type);

  Future<Either<String, Failure>> activeMyseteriousMan(String type);

  Future<Either<String, Failure>> disposeMyseteriousMan(String type);

  ///xxxxxxxxxx
  Future<Either<String, Failure>> disposeHideVisitor(String type);

  Future<Either<String, Failure>> disposeHideCountry(String type);

  Future<Either<String, Failure>> dipsoseLastCommunicationTime(String type);

  Future<Either<GetVipPrevModel, Failure>> getVipPerv();

  Future<Either<String, Failure>> buyCoins(BuyCoinsParameter buyCoinsParameter);
    Future<Either<List<GiftHistoryModel>, Failure>> getGiftHistory(String id);
  Future<Either<TimeDataReport, Failure>> getTimeDataReport(String time);
  Future<Either<String, Failure>> bountFacebook();

  Future<Either<String, Failure>> bountGmail();

  Future<Either<String, Failure>> bountNumber(
      BoundNumberPramiter boundNumberPramiter);

  // ignore: non_constant_identifier_names
  Future<Either<String, Failure>> ChangePassword(
      BoundNumberPramiter boundNumberPramiter);

  // ignore: non_constant_identifier_names
  Future<Either<String, Failure>> ChangePhone(
      BoundNumberPramiter boundNumberPramiter);

         Future<Either<bool, Failure>> joinToAgencie(
    String agencieId, String whatsAppNum);
          Future<Either<bool, Failure>> updateFamily(
   UpdateFamilyPramiter parameter);

       Future<Either<String, Failure>> userReporet(UserReporetPramiter pramiter);

      Future<Either<GetConfigKeyModel,Failure>> getConfigKey(GetConfigKeyPram getConfigKeyPram  );


}
