

// ignore_for_file: avoid_renaming_method_parameters

import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tik_chat_v2/core/base_use_case/base_use_case.dart';
import 'package:tik_chat_v2/core/error/exceptions.dart';
import 'package:tik_chat_v2/core/model/all_rooms_model.dart';
import 'package:tik_chat_v2/core/model/owner_data_model.dart';
import 'package:tik_chat_v2/core/model/vip_center_model.dart';
import 'package:tik_chat_v2/core/utils/api_healper/constant_api.dart';
import 'package:tik_chat_v2/core/utils/api_healper/dio_healper.dart';
import 'package:tik_chat_v2/core/utils/api_healper/methods.dart';
import 'package:tik_chat_v2/features/auth/data/model/user_platform_model.dart';
import 'package:tik_chat_v2/features/profile/data/model/data_mall_model.dart';
import 'package:tik_chat_v2/features/profile/data/model/back_pack_model.dart';
import 'package:tik_chat_v2/features/profile/data/model/black_list_model.dart';
import 'package:tik_chat_v2/features/profile/data/model/charge_history_model.dart';
import 'package:tik_chat_v2/features/profile/data/model/charge_page_model.dart';
import 'package:tik_chat_v2/features/profile/data/model/charge_to_model.dart';
import 'package:tik_chat_v2/features/profile/data/model/family_member_model.dart';
import 'package:tik_chat_v2/features/profile/data/model/family_requests_model.dart';
import 'package:tik_chat_v2/features/profile/data/model/fanily_rank_model.dart';
import 'package:tik_chat_v2/features/profile/data/model/get_time_entities.dart';
import 'package:tik_chat_v2/features/profile/data/model/get_vip_prev.dart';
import 'package:tik_chat_v2/features/profile/data/model/gift_history_model.dart';
import 'package:tik_chat_v2/features/profile/data/model/gold_coin_model.dart';
import 'package:tik_chat_v2/features/profile/data/model/replace_with_gold_model.dart';
import 'package:tik_chat_v2/features/profile/data/model/search_model.dart';
import 'package:tik_chat_v2/features/profile/data/model/show_family_model.dart';
import 'package:tik_chat_v2/features/profile/data/model/silver_coins_model.dart';
import 'package:tik_chat_v2/features/profile/data/model/silver_history.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/bound_platform_uc.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/buy_coins_uc.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/charge_to_uc.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/create_family_uc.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/update_family_uc.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/user_reporet_uc.dart';


abstract class BaseRemotlyDataSourceProfile {
  Future<OwnerDataModel> getmyData(Noparamiter noparamiter);
  Future<List<DataMallModel>> getDataMall(int type);
  Future<List<OwnerDataModel>> getFriendsOrFollowers(
      {required String type, String? page});
  Future<String> follow({required String userId});
  Future<String> unFollow({required String userId});
  Future<OwnerDataModel> getUserData(
      {required String userId, bool? sendFireBase});
  Future<List<VipCenterModel>> getVipCenter();
  Future<int> getvipCount();
  Future<List<OwnerDataModel>> getVaistors({String? page});
  Future<List<BackPackModel>> getBackPack(String type);
  Future<String> useItem(String id);

  Future<ShowFamilyModel> creatFamily(CreateFamilyPramiter creatFamilyPramiter);

  Future<String> buy(String idItem, String quantity);

  Future<String> sendPack(String packId, String touid);

  Future<String> unUsedPack(String id);

  Future<FamilyRankModel> familyRanking(String time);

  Future<String> deletFamily(String id);

  Future<String> removeUserFromFamily(String uId, String familyId);

  Future<ShowFamilyModel> showFamily(String id);

  Future<String> joinFamily(String familyId);

  Future<FamilyRequestsModel> getfamilyRequest();

  Future<String> familyTakeAction(String reqId, String status);

  Future<String> changeUserType(String userId, String familyId, String type);

  Future<FamilyMemberModel> getFamilyMember(String familyId , String? page);

  Future<AllRoomsDataModel> getFamilyRoom(String familyId);

  Future<String> exitFamily();

  Future<BlackListModel> getBlackList();

  Future<String> removeBlock(String userId);

  Future<String> addBlock(String userId);

  Future<DataWalletModel> getChargePage();

  Future<ChargeToModel> chargeTo(ChargeToPramiter chargeToPramiter);

  Future<ChargeHistoryModel> getChargeHistory(String parameter);

  Future<SilverCoinsModel> getSilverCoinData();

  Future<String> buySilverCoin(String sliverId);

  Future<List<SilverCoinHistory>> getSilverHistory();

  Future<String> buyOrSendVip(String type, String vipId, String touId);

  Future<List<GoldCoinsModel>> getGoldCoinData();

  Future<ReplaceWithGoldModel> getReplaceWithDimondData();

  Future<String> exchangeDimond(String itemId);

  Future<SearchModel> search(String keyWord);

  Future<bool> checkIfFriend(String user);

  Future<String> lastCommunicationTime(String type);

  Future<String> hideCountry(String type);

  Future<String> hideVisitor(String type);

  Future<String> activeMyseteriousMan(String type);

  Future<String> disposeMyseteriousMan(String type);

  Future<String> dipsoseLastCommunicationTime(String type);

  Future<String> disposeHideCountry(String type);

  Future<String> disposeHideVisitor(String type);

  Future<GetVipPrevModel> getVipPrev();

  Future<String> buyCoins(BuyCoinsParameter buyCoinsParameter);
   Future<List<GiftHistoryModel>> getGiftHistory(String id);
     Future<TimeDataReport> getTimeDataReport(String time);

  Future<String> deleteAccount();
  Future<String> boundGmail();
  Future<String> boundFacebook();
  Future<String> boundNumber(BoundNumberPramiter boundNumberPramiter);
  Future<String> changePassword(BoundNumberPramiter boundNumberPramiter);
  Future<String> changePhone(BoundNumberPramiter boundNumberPramiter);
  Future<bool> joinToAgencie(String agencieId, String whatsAppNum);
    Future<bool> updateFamily(UpdateFamilyPramiter updateFamilyPramiter);

    Future<String> userReporet(UserReporetPramiter userReporetPramiter);



}



class RemotlyDataSourceProfile extends BaseRemotlyDataSourceProfile {

  @override
  Future<OwnerDataModel> getmyData(Noparamiter noparamiter) async {
    Map<String, String> headers = await DioHelper().header();

    try {
      final response = await Dio().get(
        ConstentApi.getmyDataUrl,
        options: Options(
          headers: headers,
        ),
      );
      bool succes = response.data[ConstentApi.succes];
      if (succes) {
        Methods().saveUserData(jsonString: response.data);
      }
      OwnerDataModel userData =
          OwnerDataModel.fromMap(response.data[ConstentApi.data]);
      return userData;
    } on DioError catch (e) {
      throw DioHelper.handleDioError(e);
    }
    
  }

  @override
  Future<List<DataMallModel>> getDataMall(int type) async {
    Map<String, String> headers = await DioHelper().header();
    try {
      final response = await Dio().get(
        ConstentApi().getDataMallUrl(type),
        options: Options(
          headers: headers,
        ),
      );
      Map<String, dynamic> jsonData = response.data;
      bool succes = jsonData[ConstentApi.succes];
      List<DataMallModel> listDataMall = [];
      if (succes) {
        for (int i = 0; i < jsonData[ConstentApi.data].length; i++) {
          DataMallModel dataModel =
              DataMallModel.fromJson(jsonData[ConstentApi.data][i]);
          listDataMall.add(dataModel);
        }
      }
      return listDataMall;
    } on DioError catch (e) {
      throw DioHelper.handleDioError(e);
    }
  }

  @override
  Future<String> follow({required String userId}) async {
    Map<String, String> headers = await DioHelper().header();

    try {
      final response = await Dio().post(
        ConstentApi.follow,
        data: {'user_id': userId},
        options: Options(
          headers: headers,
        ),
      );

      return response.data[ConstentApi.message];
    } on DioError catch (e) {
      throw DioHelper.handleDioError(e);
    }
  }

  @override
  Future<List<OwnerDataModel>> getFriendsOrFollowers(
      {required String type, String? page}) async {
    Map<String, String> headers = await DioHelper().header();

    try {
      final response = page == null
          ? await Dio().get(
              '${ConstentApi.relations}?type=$type',
              options: Options(
                headers: headers,
              ),
            )
          : await Dio().get(
              '${ConstentApi.relations}?type=$type&page=$page',
              options: Options(
                headers: headers,
              ),
            );
      // log(response.toString());

      List<OwnerDataModel> relation = List<OwnerDataModel>.from(
          (response.data["data"] as List)
              .map((e) => OwnerDataModel.fromMap(e)));
      return Future.value(relation);
    } on DioError catch (e) {
      throw DioHelper.handleDioError(e);
    }
  }

  @override
  Future<String> unFollow({required String userId}) async {
    Map<String, String> headers = await DioHelper().header();

    try {
      final response = await Dio().post(
        ConstentApi.unFollow,
        data: {'user_id': userId},
        options: Options(
          headers: headers,
        ),
      );

      return response.data[ConstentApi.message];
    } on DioError catch (e) {
      throw DioHelper.handleDioError(e);
    }
  }

  @override
  Future<OwnerDataModel> getUserData(
      {required String userId, bool? sendFireBase}) async {

    Map<String, String> headers = await DioHelper().header();
    try {
      final response = await Dio().get(
          ConstentApi().getUserData(userId: userId, sendFireBase: sendFireBase),
          options: Options(
            headers: headers,
          ));

      OwnerDataModel userData = OwnerDataModel.fromMap(response.data["data"]);
      return userData;
    } on DioError catch (e) {
      throw DioHelper.handleDioError(e);
    }
  }

  @override
  Future<List<VipCenterModel>> getVipCenter() async {
    Map<String, String> headers = await DioHelper().header();


    try {
      final response = await Dio().get(
        ConstentApi.viplist,
        options: Options(
          headers: headers,
        ),
      );

      Map<String, dynamic> data = response.data;
      List<VipCenterModel> dataVip = [];
      for (int i = 0; i < data['data'].length; i++) {
        dataVip.add(VipCenterModel.fromJson(data['data'][i]));
      }
      return dataVip;
    } on DioError catch (e) {
      throw DioHelper.handleDioError(e);
    }
  }

  @override
  Future<int> getvipCount() async {
    Map<String, String> headers = await DioHelper().header();


    try {
      final response = await Dio().get(
        ConstentApi.getVipCount,
        options: Options(
          headers: headers,
        ),
      );

      Map<String, dynamic> data = response.data;
      return data['data']['vip_count'];
    } on DioError catch (e) {
      throw DioHelper.handleDioError(e);
    }
  }

  @override
  Future<List<OwnerDataModel>> getVaistors({String? page}) async {
    Map<String, String> headers = await DioHelper().header();

    try {
      final response = page == null
          ? await Dio().get(ConstentApi.getVistors,
              options: Options(
                headers:headers,
              ))
          : await Dio().get('${ConstentApi.getVistors}?page=$page',
              options: Options(
                headers:headers,
              ));

      List<OwnerDataModel> result = List<OwnerDataModel>.from(
          (response.data["data"] as List)
              .map((e) => OwnerDataModel.fromMap(e)));

      return result;
    } on DioError catch (e) {
      throw DioHelper.handleDioError(e);
    }
  }

  @override
  Future<List<BackPackModel>> getBackPack(String type) async {
    Map<String, String> headers = await DioHelper().header();
    try {
      final response = await Dio().get(ConstentApi().getBackPack(type),
          options: Options(
            headers:headers,
          ));
      List<BackPackModel> result = List<BackPackModel>.from(
          (response.data["data"] as List)
              .map((e) => BackPackModel.fromjson(e)));

      return result;
    } on DioError catch (e) {
      throw DioHelper.handleDioError(e);
    }
  }

  @override
  Future<String> useItem(String id) async {
    Map<String, String> headers = await DioHelper().header();
    try {
      final response = await Dio().post(ConstentApi.useItem,
          data: {"item_id": id},
          options: Options(
            headers: headers,
          ));
      return response.data["message"];
    } on DioError catch (e) {
      throw DioHelper.handleDioError(e);
    }
  }



  @override
  Future<ShowFamilyModel> creatFamily(creatFamilyPramiter) async {
    Map<String, String> headers = await DioHelper().header();


    FormData formData;
    File file = creatFamilyPramiter.image;
    String fileName = file.path.split('/').last;

    formData = FormData.fromMap({
      "image": await MultipartFile.fromFile(file.path, filename: fileName),
      'name': creatFamilyPramiter.name,
      'introduce': creatFamilyPramiter.introduce,
    });
    try {
      final response = await Dio().post(
        ConstentApi.createFamily,
        data: formData,
        options: Options(
          headers: headers,
        ),
      );
      Map<String, dynamic> resultData = response.data;
      log(resultData.toString());
      return ShowFamilyModel.fromJson(resultData['data']);
    } on DioError catch (e) {
      throw DioHelper.handleDioError(e);
    }
  }

  @override
  Future<String> buy(String idItem, String quantity) async {
    Map<String, String> headers = await DioHelper().header();

    final body = {'ware_id': idItem, 'qty': quantity};

    try {
      final response = await Dio().post(
        ConstentApi.buy,
        data: body,
        options: Options(
          headers: headers,
        ),
      );
      Map<String, dynamic> resultData = response.data;

      return resultData['message'];
    } on DioError catch (e) {
      throw DioHelper.handleDioError(e);
    }
  }

  @override
  Future<String> sendPack(String packId, String touid) async {
    Map<String, String> headers = await DioHelper().header();

    final body = {'pack_id': packId, 'touid': touid};

    try {
      final response = await Dio().post(
        ConstentApi.sendItem,
        data: body,
        options: Options(
          headers: headers,
        ),
      );
      Map<String, dynamic> resultData = response.data;
      log(resultData.toString());
      return resultData['message'];
    } on DioError catch (e) {
      throw DioHelper.handleDioError(e);
    }
  }

  @override
  Future<String> unUsedPack(String id) async {
    Map<String, String> headers = await DioHelper().header();

    final body = {
      'type': id,
    };

    try {
      final response = await Dio().post(
        ConstentApi.unUsedItem,
        data: body,
        options: Options(
          headers: headers,
        ),
      );
      Map<String, dynamic> resultData = response.data;

      return resultData['message'];
    } on DioError catch (e) {
      throw DioHelper.handleDioError(e);
    }
  }

  @override
  Future<FamilyRankModel> familyRanking(String time) async {
    Map<String, String> headers = await DioHelper().header();

    final body = {
      'time': time,
    };

    try {
      final response = await Dio().post(
        ConstentApi.familyRank,
        data: body,
        options: Options(
          headers: headers,
        ),
      );

      Map<String, dynamic> resultData = response.data;

      FamilyRankModel data = FamilyRankModel.fromJson(resultData);
      log(data.toString());

      return data;
    } on DioError catch (e) {
      throw DioHelper.handleDioError(e);
    }

  }

  @override
  Future<String> deletFamily(String id) async {
    Map<String, String> headers = await DioHelper().header();
    try {
      final response = await Dio().get(ConstentApi().deleteFamily(id),
          options: Options(
            headers: headers,
          ));
      Map<String, dynamic> resultData = response.data;
      return resultData['message'];
    } on DioError catch (e) {
      log(e.toString());
      throw DioHelper.handleDioError(e);
    }
  }

  @override
  Future<String> removeUserFromFamily(String uId, String familyId) async {
    Map<String, String> headers = await DioHelper().header();

    final body = {'user_id': uId, 'familyId': familyId};

    try {
      final response = await Dio().post(
        ConstentApi().familyRemoveUser(uId, familyId),
        data: body,
        options: Options(
          headers: headers,
        ),
      );
      Map<String, dynamic> resultData = response.data;
      log(response.data.toString());
      return resultData['message'];
    } on DioError catch (e) {
      log(e.toString());
      throw DioHelper.handleDioError(e);
    }
  }

  @override
  Future<ShowFamilyModel> showFamily(String id) async {
    Map<String, String> headers = await DioHelper().header();
    try {
      final response = await Dio().get(ConstentApi().showFamily(id),
          options: Options(
            headers: headers,
          ));
      Map<String, dynamic> resultData = response.data;

      ShowFamilyModel data = ShowFamilyModel.fromJson(resultData['data']);
      log(data.toString());
      return data;
    } on DioError catch (e) {
      throw DioHelper.handleDioError(e);
    }

  }

  @override
  Future<String> joinFamily(String familyId) async {
    Map<String, String> headers = await DioHelper().header();

    final body = {'family_id': familyId};

    try {
      final response = await Dio().post(
        ConstentApi.joinFamily,
        data: body,
        options: Options(
          headers: headers,
        ),
      );
      log(response.toString());

      Map<String, dynamic> resultData = response.data;

      return resultData['message'];
    } on DioError catch (e) {
      throw DioHelper.handleDioError(e);
    }
  }

  @override
  Future<FamilyRequestsModel> getfamilyRequest() async {
    Map<String, String> headers = await DioHelper().header();


    try {
      final response = await Dio().post(
        ConstentApi.familyRequest,
        options: Options(
          headers: headers,
        ),
      );

      Map<String, dynamic> resultData = response.data;

      FamilyRequestsModel data = FamilyRequestsModel.fromjson(resultData);
      // log(data.toString());
      return data;
    } on DioError catch (e) {
      throw DioHelper.handleDioError(e);
    }
  }

  @override
  Future<String> familyTakeAction(String reqId, String status) async {
    Map<String, String> headers = await DioHelper().header();

    final body = {'req_id': reqId, 'status': status};

    try {
      final response = await Dio().post(
        ConstentApi.familyTakeAction,
        data: body,
        options: Options(
          headers: headers,
        ),
      );
      log(response.toString());

      Map<String, dynamic> resultData = response.data;

      return resultData['message'];
    } on DioError catch (e) {
      throw DioHelper.handleDioError(e);
    }
  }

  @override
  Future<String> changeUserType(
      String userId, String familyId, String type) async {
    log('her');

    Map<String, String> headers = await DioHelper().header();

    final body = {'family_id': familyId, 'user_id': userId, 'type': type};

    try {
      final response = await Dio().post(
        ConstentApi.changeusertype,
        data: body,
        options: Options(
          headers: headers,
        ),
      );

      Map<String, dynamic> resultData = response.data;

      return resultData['message'];
    } on DioError catch (e) {
      throw DioHelper.handleDioError(e);
    }
  }

  @override
  Future<FamilyMemberModel> getFamilyMember(String familyId , String? page) async {
    Map<String, String> headers = await DioHelper().header();

    final body = {
      'family_id': familyId,
      "page": page ?? 1
    };

    try {
      final response = await Dio().post(
        ConstentApi.getMembersFamily,
        data: body,
        options: Options(
          headers: headers,
        ),
      );
      log(response.toString());

      Map<String, dynamic> resultData = response.data;
      FamilyMemberModel data = FamilyMemberModel.fromJson(resultData['data']);

      return data;
    } on DioError catch (e) {
      throw DioHelper.handleDioError(e);
    }
  }

  @override
  Future<AllRoomsDataModel> getFamilyRoom(String familyId) async {
    Map<String, String> headers = await DioHelper().header();

    final body = {
      'family_id': familyId,
    };

    try {
      final response = await Dio().post(
        ConstentApi.getFamilyRoom,
        data: body,
        options: Options(
          headers: headers,
        ),
      );
      log(response.toString());

      Map<String, dynamic> resultData = response.data;
      AllRoomsDataModel data = AllRoomsDataModel.fromMap(resultData);

      return data;
    } on DioError catch (e) {
      throw DioHelper.handleDioError(e);
    }
  }

  @override
  Future<String> exitFamily() async {
    Map<String, String> headers = await DioHelper().header();


    try {
      final response = await Dio().post(
        ConstentApi.exiteFamily,
        options: Options(
          headers: headers,
        ),
      );
      log(response.toString());

      Map<String, dynamic> resultData = response.data;

      return resultData['message'];
    } on DioError catch (e) {
      throw DioHelper.handleDioError(e);
    }
  }

  @override
  Future<BlackListModel> getBlackList() async {
    Map<String, String> headers = await DioHelper().header();


    try {
      final response = await Dio().get(
        ConstentApi.getBlackList,
        options: Options(
          headers: headers,
        ),
      );

      Map<String, dynamic> resultData = response.data;
      BlackListModel data = BlackListModel.fromJson(resultData);

      return data;
    } on DioError catch (e) {
      throw DioHelper.handleDioError(e);
    }
  }

  @override
  Future<String> removeBlock(String userId) async {
    Map<String, String> headers = await DioHelper().header();

    final body = {
      'user_id': userId,
    };

    try {
      final response = await Dio().post(
        ConstentApi.removeBloc,
        data: body,
        options: Options(
          headers: headers,
        ),
      );
      log(response.toString());

      Map<String, dynamic> resultData = response.data;

      return resultData['message'];
    } on DioError catch (e) {
      throw DioHelper.handleDioError(e);
    }
  }

  @override
  Future<String> addBlock(String userId) async {
    Map<String, String> headers = await DioHelper().header();

    final body = {
      'user_id': userId,
    };

    try {
      final response = await Dio().post(
        ConstentApi.addBloc,
        data: body,
        options: Options(
          headers: headers,
        ),
      );
      log(response.toString());

      Map<String, dynamic> resultData = response.data;

      return resultData['message'];
    } on DioError catch (e) {
      throw DioHelper.handleDioError(e);
    }
  }

  @override
  Future<DataWalletModel> getChargePage() async {
    Map<String, String> headers = await DioHelper().header();

   try {
    final response = await Dio().post(
      ConstentApi.chargePage,
      options: Options(
        headers: headers,
      ),
    );
    Map<String, dynamic> resultData = response.data;

    DataWalletModel data = DataWalletModel.fromJson(resultData['data']);

    return data;
    } on DioError catch (e) {
      throw DioHelper.handleDioError(e);
    }
  }

  @override
  Future<ChargeToModel> chargeTo(ChargeToPramiter chargeToPramiter) async {
    Map<String, String> headers = await DioHelper().header();

    final body = {
      'to_id': chargeToPramiter.toId,
      'usd': chargeToPramiter.usd,
    };

    try {
      final response = await Dio().post(
        ConstentApi.chargeTo,
        data: body,
        options: Options(
          headers: headers,
        ),
      );
      Map<String, dynamic> resultData = response.data;

      ChargeToModel data = ChargeToModel.fromJason(resultData);

      return data;
    } on DioError catch (e) {
      throw DioHelper.handleDioError(e);
    }
  }

  @override
  Future<ChargeHistoryModel> getChargeHistory(String type) async {
    Map<String, String> headers = await DioHelper().header();

    final body = {
      'type': type,
    };

    try {
      final response = await Dio().post(
        ConstentApi().getChargeHistory(type),
        data: body,
        options: Options(
          headers: headers,
        ),
      );
      Map<String, dynamic> resultData = response.data;

      ChargeHistoryModel data = ChargeHistoryModel.fromJson(resultData);

      return data;
    } on DioError catch (e) {
      throw DioHelper.handleDioError(e);
    }
  }

  @override
  Future<SilverCoinsModel> getSilverCoinData() async {
    Map<String, String> headers = await DioHelper().header();


    try {
      final response = await Dio().get(
        ConstentApi.getSilverData,
        options: Options(
          headers: headers,
        ),
      );

      Map<String, dynamic> resultData = response.data;
      SilverCoinsModel data = SilverCoinsModel.fromjson(resultData);

      return data;
    } on DioError catch (e) {
      throw DioHelper.handleDioError(e);
    }
  }

  @override
  Future<String> buySilverCoin(String sliverId) async {
    Map<String, String> headers = await DioHelper().header();

    final body = {
      'silver_id': sliverId,
    };

    try {
      final response = await Dio().post(
        ConstentApi.buySilverCoin,
        data: body,
        options: Options(
          headers: headers,
        ),
      );

      Map<String, dynamic> resultData = response.data;

      return resultData['message'];
    } on DioError catch (e) {
      throw DioHelper.handleDioError(e);
    }
  }

  @override
  Future<List<SilverCoinHistory>> getSilverHistory() async {
    Map<String, String> headers = await DioHelper().header();


    try {
      final response = await Dio().get(
        ConstentApi.getSilverHistory,
        options: Options(
          headers: headers,
        ),
      );

      Map<String, dynamic> resultData = response.data;
      List<SilverCoinHistory> data = List<SilverCoinHistory>.from(
          resultData['data'].map((x) => SilverCoinHistory.fromjson(x)));
      return data;
    } on DioError catch (e) {
      throw DioHelper.handleDioError(e);
    }
  }

  @override
  Future<String> buyOrSendVip(String type, String vipId, String touId) async {
    Map<String, String> headers = await DioHelper().header();

    final body = {'type': type, 'vip_id': vipId, 'to_user': touId};

    try {
      final response = await Dio().post(
        ConstentApi.buyOrSend,
        data: body,
        options: Options(
          headers: headers,
        ),
      );

      Map<String, dynamic> resultData = response.data;
      log(response.toString());
      return resultData['message'];
    } on DioError catch (e) {
      throw DioHelper.handleDioError(e);
    }
  }

  @override
  Future<List<GoldCoinsModel>> getGoldCoinData() async {
    Map<String, String> headers = await DioHelper().header();


    try {
      final response = await Dio().get(
        ConstentApi.getGoldData,
        options: Options(
          headers: headers,
        ),
      );

      Map<String, dynamic> resultData = response.data;
      List<GoldCoinsModel> data = List<GoldCoinsModel>.from(
          resultData['data'].map((x) => GoldCoinsModel.fromjson(x)));

      return data;
    } on DioError catch (e) {
      throw DioHelper.handleDioError(e);
    }
    
  }

  @override
  Future<ReplaceWithGoldModel> getReplaceWithDimondData() async {
    Map<String, String> headers = await DioHelper().header();


    try {
      final response = await Dio().get(
        ConstentApi.getReplaceWithDimondData,
        options: Options(
          headers: headers,
        ),
      );

      Map<String, dynamic> resultData = response.data;
      ReplaceWithGoldModel data = ReplaceWithGoldModel.fromjson(resultData);

      return data;
    } on DioError catch (e) {
      throw DioHelper.handleDioError(e);
    }
  }

  @override
  Future<String> exchangeDimond(String itemId) async {
    Map<String, String> headers = await DioHelper().header();

    final body = {
      'item_id': itemId,
    };

    try {
      final response = await Dio().post(
        ConstentApi.exchangeDimonds,
        data: body,
        options: Options(
          headers: headers,
        ),
      );

      Map<String, dynamic> resultData = response.data;

      return resultData['message'].toString();
    } on DioError catch (e) {
      throw DioHelper.handleDioError(e);
    }
  }

  @override
  Future<SearchModel> search(String keyWord) async {
    Map<String, String> headers = await DioHelper().header();


    try {
      final response = await Dio().get(
        ConstentApi().search(keyword: keyWord),
        options: Options(
          headers: headers,
        ),
      );
      final result = response.data;
      SearchModel searchModel = SearchModel.fromJson(result['data']);
      return searchModel;
    } on DioError catch (e) {
      throw DioHelper.handleDioError(e);
    }
  }

  @override
  Future<bool> checkIfFriend(String user) async {
    Map<String, String> headers = await DioHelper().header();

    final body = {'user_id': user};
    try {
      final response = await Dio().post(
        ConstentApi.checkIfFriend,
        data: body,
        options: Options(
          headers: headers,
        ),
      );
      Map<String, dynamic> jsonData = response.data;
      bool succes = jsonData['data'];
      return succes;
    } on DioError catch (e) {
      throw DioHelper.handleDioError(e);
    }
  }

  @override
  Future<String> lastCommunicationTime(String type) async {
    Map<String, String> headers = await DioHelper().header();


    try {
      final response = await Dio().post(
        ConstentApi.prevsUse(type),
        options: Options(
          headers: headers,
        ),
      );
      log(response.data.toString());

      return response.data['message'];
    } on DioError catch (e) {
      throw DioHelper.handleDioError(e);
    }
  }

  @override
  Future<String> hideCountry(String type) async {
    Map<String, String> headers = await DioHelper().header();


    try {
      final response = await Dio().post(
        ConstentApi.prevsUse(type),
        options: Options(
          headers: headers,
        ),
      );
      log(response.data.toString());

      return response.data['message'];
    } on DioError catch (e) {
      throw DioHelper.handleDioError(e);
    }
  }

  @override
  Future<String> hideVisitor(String type) async {
    Map<String, String> headers = await DioHelper().header();


    try {
      final response = await Dio().post(
        ConstentApi.prevsUse(type),
        options: Options(
          headers: headers,
        ),
      );
      log(response.data.toString());

      return response.data['message'];
    } on DioError catch (e) {
      throw DioHelper.handleDioError(e);
    }
  }

  @override
  Future<String> activeMyseteriousMan(String type) async {
    Map<String, String> headers = await DioHelper().header();


    try {
      final response = await Dio().post(
        ConstentApi.prevsUse(type),
        options: Options(
          headers: headers,
        ),
      );
      log(response.data.toString());

      return response.data['message'];
    } on DioError catch (e) {
      throw DioHelper.handleDioError(e);
    }
  }

  @override
  Future<String> disposeMyseteriousMan(String type) async {
    Map<String, String> headers = await DioHelper().header();


    try {
      final response = await Dio().post(
        ConstentApi.prevsUnUse(type),
        options: Options(
          headers: headers,
        ),
      );
      log(response.data.toString());

      return response.data['message'];
    } on DioError catch (e) {
      throw DioHelper.handleDioError(e);
    }
  }

  @override
  Future<String> dipsoseLastCommunicationTime(String type) async {
    Map<String, String> headers = await DioHelper().header();


    try {
      final response = await Dio().post(
        ConstentApi.prevsUnUse(type),
        options: Options(
          headers: headers,
        ),
      );
      log(response.data.toString());

      return response.data['message'];
    } on DioError catch (e) {
      throw DioHelper.handleDioError(e);
    }
  }

  @override
  Future<String> disposeHideCountry(String type) async {
    Map<String, String> headers = await DioHelper().header();


    try {
      final response = await Dio().post(
        ConstentApi.prevsUnUse(type),
        options: Options(
          headers: headers,
        ),
      );
      log(response.data.toString());

      return response.data['message'];
    } on DioError catch (e) {
      throw DioHelper.handleDioError(e);
    }
  }

  @override
  Future<String> disposeHideVisitor(String type) async {
    Map<String, String> headers = await DioHelper().header();


    try {
      final response = await Dio().post(
        ConstentApi.prevsUnUse(type),
        options: Options(
          headers: headers,
        ),
      );
      log(response.data.toString());

      return response.data['message'];
    } on DioError catch (e) {
      throw DioHelper.handleDioError(e);
    }
  }

  @override
  Future<GetVipPrevModel> getVipPrev() async {
    Map<String, String> headers = await DioHelper().header();


    try {
      final response = await Dio().get(
        ConstentApi.getvipPrev,
        options: Options(
          headers: headers,
        ),
      );
      log(response.data.toString());

      return GetVipPrevModel.fromjosn(response.data['data']);
    } on DioError catch (e) {
      throw DioHelper.handleDioError(e);
    }
  }

  @override
  Future<String> buyCoins(BuyCoinsParameter buyCoinsParameter) async {
    Map<String, String> headers = await DioHelper().header();
    final body = {
      'pay_method': buyCoinsParameter.paymentMethod,
      'coin_id': buyCoinsParameter.coinsID ,
    };

    try {
      final response = await Dio().post(
        ConstentApi.addBloc,
        data: body,
        options: Options(
          headers: headers,
        ),
      );
      Map<String, dynamic> resultData = response.data;
      log(resultData.toString());
      return resultData['message'];
    } on DioError catch (e) {
      throw DioHelper.handleDioError(e);
    }
  }


      @override
  Future<List<GiftHistoryModel>> getGiftHistory(String id)async {
        Map<String, String> headers = await DioHelper().header();
    try {
      final response = await Dio().get(
        ConstentApi.getgiftHistory(id),
        options: Options(
          headers: headers,
        ),
      );

      Map<String, dynamic> resultData = response.data;
        List<GiftHistoryModel> data = List<GiftHistoryModel>.from(
          resultData['data'].map((x) => GiftHistoryModel.fromjson(x)));

      return data;
    } on DioError catch (e) {
      throw DioHelper.handleDioError(e);
    }


}

 @override
  Future<TimeDataReport> getTimeDataReport(String time) async {
   Map<String, String> headers = await DioHelper().header();
    try {
     final response = await Dio().post(
      ConstentApi.getTimes(time),
      options: Options(
        headers: headers,
      ),
    );
    Map<String, dynamic> resultData = response.data;
    TimeDataReport data = TimeDataReport.fromJason(resultData["data"]);
    return data;
    } on DioError catch (e) {
      throw DioHelper.handleDioError(e);
    }

    
  }

  @override
  Future<String> deleteAccount() async {
    Map<String, String> headers = await DioHelper().header();
    try {
      final response = await Dio().get(ConstentApi.deleteAccount,
          options: Options(
            headers: headers,
          ));
      return response.data['message'];
    } on DioError catch (e) {
      throw DioHelper.handleDioError(e);
    }
  }

  @override
  Future<String> boundGmail() async {
    // ignore: no_leading_underscores_for_local_identifiers
    final _googleSignIn = GoogleSignIn(scopes: ['email']);

    // ignore: unused_local_variable
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    Future<GoogleSignInAccount?> login() => _googleSignIn.signIn();
    // ignore: unused_element
    Future logout() => _googleSignIn.disconnect();
    final userModel = await login();
    if (userModel == null) {
      throw SiginGoogleException();
    } else {
      final body = {"google_id": userModel.id};
      final response = await Dio().post(
        ConstentApi.boundAccount,
        data: body,
      );

      if (response.statusCode == 200) {
        return response.data['message'];
      } else {
        throw ServerException();
      }
    }
  }

  @override
  Future<String> boundFacebook() async {
    final LoginResult result =
    await FacebookAuth.i.login(permissions: ['email']);
    Map<String, String> headers = await DioHelper().header();
    if (result.status == LoginStatus.success) {
      final data = await FacebookAuth.i.getUserData();

      UserPlatformModel model = UserPlatformModel.fromJson(data);
      final body = {
        "facebook_id": model.id,
      };
      final response = await Dio().post(
        ConstentApi.boundAccount,
        data: body,
        options: Options(
          headers: headers,
        ),
      );

      Map<String, dynamic> resultData = response.data;
      log(resultData.toString());
      bool sussec = resultData["success"];
      if (sussec) {
        return resultData['message'];
      } else {
        throw SiginFacebookException();
      }
    } else {
      throw SiginFacebookException();
    }
  }

  @override
  Future<String> boundNumber(BoundNumberPramiter boundNumberPramiter) async {
    Map<String, String> headers = await DioHelper().header();
    final body = {
      'phone': boundNumberPramiter.phoneNumber,
      'vr_code': boundNumberPramiter.vrCode,
      'password': boundNumberPramiter.password
    };
    try{
    final response = await Dio().post(
      ConstentApi.boundAccount,
      data: body,
      options: Options(
        headers: headers,
      ),
    );

    Map<String, dynamic> resultData = response.data;
    
    
      return resultData['message'];
    
    
    }on DioError catch (e){
      throw DioHelper.handleDioError(e);
    }
  }


  @override
  Future<String> changePassword(BoundNumberPramiter boundNumberPramiter) async {
    Map<String, String> headers = await DioHelper().header();
    final body = {
      'phone': boundNumberPramiter.phoneNumber,
      'vr_code': boundNumberPramiter.vrCode,
      'password': boundNumberPramiter.password
    };
    try {
      final response = await Dio().post(
        ConstentApi.changePassword,
        data: body,
        options: Options(
          headers: headers,
        ),
      );
      Map<String, dynamic> resultData = response.data;

      return resultData['message'];
    } on DioError catch (e) {
      throw DioHelper.handleDioError(e);
    }
  }

  @override
  Future<String> changePhone(BoundNumberPramiter boundNumberPramiter) async {
    Map<String, String> headers = await DioHelper().header();
    final body = {
      'phone': boundNumberPramiter.phoneNumber,
      'vr_code': boundNumberPramiter.vrCode,
      'current_phone': boundNumberPramiter.currentPhone
    };
    try {
      final response = await Dio().post(
        ConstentApi.changePhone,
        data: body,
        options: Options(
          headers: headers,
        ),
      );
      Map<String, dynamic> resultData = response.data;
      return resultData['message'];
    } on DioError catch (e) {
      throw DioHelper.handleDioError(e);
    }
  }
  
  @override
  Future<bool> joinToAgencie(String agencieId, String whatsAppNum) async{
 Map<String, String> headers = await DioHelper().header();
   final body = {'agency_id': agencieId, 'whatsapp': whatsAppNum};

    try {
      final response = await Dio().post(
        ConstentApi.joinToAgencies,
        data: body,
        options: Options(
          headers: headers,
        ),
      );
      Map<String, dynamic> resultData = response.data;
      log(resultData.toString());
      return resultData['success'];
    } on DioError catch (e) {
      throw DioHelper.handleDioError(e);
    }
  }
  
  @override
  Future<bool> updateFamily(UpdateFamilyPramiter updateFamilyPramiter)async {
  Map<String, String> headers = await DioHelper().header();
   final body = {'name': updateFamilyPramiter.name, 'introduce': updateFamilyPramiter.introduce};

    try {
      final response = await Dio().post(
        ConstentApi.updateFamily(updateFamilyPramiter.familyId),
        data: body,
        options: Options(
          headers: headers,
        ),
      );
      Map<String, dynamic> resultData = response.data;
      log(resultData.toString());
      return resultData['success'];
    } on DioError catch (e) {
      throw DioHelper.handleDioError(e);
    }
  }

   @override
  Future<String> userReporet(UserReporetPramiter userReporetPramiter)async {
   Map<String, String> headers = await DioHelper().header();
      FormData formData;
    if (userReporetPramiter.image == null) {
      formData = FormData.fromMap({
        'id': userReporetPramiter.id,
        'type_report': userReporetPramiter.typeReporet,
        'report_content': userReporetPramiter.reporetContetnt,
      });
    } else {
      File file = userReporetPramiter.image!;
      String fileName = file.path.split('/').last;

      formData = FormData.fromMap({
        "image": await MultipartFile.fromFile(file.path, filename: fileName),
        'id': userReporetPramiter.id,
        'type_report': userReporetPramiter.typeReporet,
        'report_content': userReporetPramiter.reporetContetnt,
      });
    }
    try {
      final response = await Dio().post(
        ConstentApi.userReporet,
        data: formData,
        options: Options(
          headers: headers,
          
        ),
      );
      log(response.data.toString());

      return response.data['message'];
    } on DioError catch (e) {
      throw DioHelper.handleDioError(e);
    }
  }
  }

