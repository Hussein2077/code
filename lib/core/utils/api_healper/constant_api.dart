import 'dart:convert';
import 'dart:developer';
import 'package:tik_chat_v2/features/room_audio/domine/use_case/up_mic_usecase.dart';



class ConstentApi {
  //static const String baseUrl = 'https://tik-chat.com/api' ;
  static const String baseUrl = 'https://test.tik-chat.com/api' ;
  static const String signUpUrl = "$baseUrl/auth/register";
  static const String sendCodeUrl = "$baseUrl/auth/send-code";
  static const String forgetPassword = "$baseUrl/auth/forget_password";
  static const String forgetPasswordCodeVerification = "$baseUrl/auth/verify-code";
  String getExtraRoomData(String OwnerId) {
    return "$baseUrl/rooms/${OwnerId}/extra-data";
  }
  static  String getUserBadges(String userId) => "$baseUrl/achievement/user/$userId";
  static  String getBadges(String type) => "$baseUrl/achievement/$type";
  static const String getBoxes = "$baseUrl/box/list";
  static const String inviteToGame = "$baseUrl/game-challange/send-reuest-paly";
  static const String inviteToGameNew = "$baseUrl/room-game/send-request-play";
  static const String otherSideGameActionNew = "$baseUrl/room-game/other-side-opinion";
  static const String acceptOrCancelGame = "$baseUrl/game-challange/other-side-opinion";
  static const String sendGameChoise = "$baseUrl/game-challange/challange-result";
  static const String gameResult = "$baseUrl/room-game/challenge-result";
  static  String sendPrivateComment(String roomId) => "$baseUrl/rooms/$roomId/send-private-comment";
  static const String pay = "$baseUrl/pay";
  static const String huaweiPay = "$baseUrl/huawei-payment";
  static const String sendBox = "$baseUrl/box/send";
  static const String pickUpBoxes = "$baseUrl/box/pickup";
  static const String levelUrl = "$baseUrl/level_center";
  static const String useItem = "$baseUrl/user_info/use_pack_item";
  static const String loginUrl = "$baseUrl/auth/login";
  static const String registerUrl = "$baseUrl/auth/register";
  static const String editeUrl = "$baseUrl/profile/update";
  static const String getmyDataUrl = "$baseUrl/my-data";
  static const String getVipCount = "$baseUrl/vip_count";
  static const String getRoomById = "$baseUrl/rooms/get_room_by_owner_id";
  static const String allRooms = "$baseUrl/rooms";
  static const String getRoomUsers = "$baseUrl/rooms/getRoomUsers";
  static const String createRoom = "$allRooms/create";
  static const String enterRoom = "$baseUrl/rooms/enter_room";
  static const String exitRoom = "$baseUrl/rooms/quit_room";
  static const String getAllMainClasses = "$baseUrl/room_category/classes";
  static const String getCountryUrl = "$baseUrl/room-countries";
  static const String getAllRoomTypes = "$baseUrl/room_category/types";
  static const String getBcakground = "$baseUrl/backgrounds";
  static const String getOfficialMsgs = "$baseUrl/community/official_messages";
  static const String getTopUrl = "$baseUrl/ranking";
  static const String getTopUrlInRoom = "$baseUrl/ranking/room";
  static const String sendGift = "$baseUrl/gifts/send";
  static const String getVistors = "$baseUrl/profile/visitors";
  static const String checkRoom = "$baseUrl/rooms/check_if_i_have_room";
  static const String getHistory = "$baseUrl/search/history";
  static const String checkIfFriend = "$baseUrl/relations/is_user_friend";
  static const String emptyHistory = "$baseUrl/search/clean_search_history";
  static const String removePassRoom = "$baseUrl/rooms/remove_pass";
  static const String deleteAccount = "$baseUrl/account/delete";
  static const String getAllCountries = "$baseUrl/auth/all-countries";
  static const String boundAccount = "$baseUrl/account/bind";
  static const String changePassword = "$baseUrl/account/reset_password";
  static const String changePhone = "$baseUrl/account/change_phone";
  static const String joinToAgencies = "$baseUrl/agencies/join_request";
  static const String buy = "$baseUrl/mall/buy";
  static const String sendItem = "$baseUrl/send_pack";
  static const String unUsedItem = "$baseUrl/user_info/takeOff";
  static const String familyRank = "$baseUrl/families/ranking";
  static const String createFamily = "$baseUrl/families/create";
  static const String kickoutUser = "$baseUrl/rooms/kick_out_of_room";
  static const String joinFamily = "$baseUrl/families/join";
  static const String familyRequest = "$baseUrl/families/req_list";
  static const String familyTakeAction = "$baseUrl/families/take_action";
  static const String changeusertype = "$baseUrl/families/change_user_type";
  static const String getMembersFamily = "$baseUrl/families/getMembersList";
  static const String getFamilyRoom = "$baseUrl/families/getFamilyRooms";
  static const String exiteFamily = "$baseUrl/families/exitFamily";
  static const String getBlackList = "$baseUrl/black_list";
  static const String removeBloc = "$baseUrl/black_list/remove";
  static const String addBloc = "$baseUrl/black_list/add";
  static const String addAdmin = "$baseUrl/rooms/add_admin_to_room";
  static const String removeAdmin = "$baseUrl/rooms/remove_admin";
  static const String showPk = "$baseUrl/rooms/showPK";
  static const String startPk = "$baseUrl/rooms/createPK";
  static const String closePk = "$baseUrl/rooms/closePK";
  static const String hidePK = "$baseUrl/hidePk";
  static const String getSilverData = "$baseUrl/silver/value";
  static const String buySilverCoin = "$baseUrl/silver/buy";
  static const String getSilverHistory = "$baseUrl/silver/history";
  static const String chargePage = "$baseUrl/chargePage";
  static const String chargeTo = "$baseUrl/charge_to";
  static const String roomAdmins = "$baseUrl/rooms/admins";
  static const String leaveMic = "$baseUrl/rooms/leave_microphone";
  static const String muteMic = "$baseUrl/rooms/mute_microphone";
  static const String unMuteMic = "$baseUrl/rooms/unmute_microphone";
  static const String lockMic = "$baseUrl/rooms/lock_microphone_place";
  static const String unlockMic = "$baseUrl/rooms/unlock_microphone_place";
  static const String viplist = "$baseUrl/vips/list";
  static const String buyOrSend = "$baseUrl/vips/buyVip";
  static const String feedBack = "$baseUrl/tickets/open";
  static const String getGoldData = "$baseUrl/coins/list";
  static const String sentToZego = "$baseUrl/send_to_zego";

  static const  String getUsersCommenstInRoom ="$baseUrl/rooms/users";
  static const String banUserFromWriting =
      "$baseUrl/rooms/ban_user_from_writing";
  static const String unBanUserFromWriting =
      "$baseUrl/rooms/remove_ban_user_from_writing";
  static const String pobUp = "$baseUrl/check_wapel";
  static const String changeRoomMode = "$baseUrl/change_room_mode";
  static const String getReplaceWithDimondData =
      "$baseUrl/exchange/list?type=0";
  static const String exchangeDimonds = "$baseUrl/exchange/make";
  static const String getvipPrev = "$baseUrl/getUserHides";
  static const String uploadBackGround =
      "$baseUrl/rooms/request-background-image";
  static const String getGroupChat = "$baseUrl/group-chat";
  static const String senGroupChat = "$baseUrl/group-chat/send";
  static const String getMyBackGround = "$baseUrl/backgrounds/me";
  static const String userReporet = "$baseUrl/relations/report_user";
  static const String getConfigKey = "$baseUrl/config/keys-values";
  static const String getConfigApp = "$baseUrl/config/app-check";
  static const String logOut = "$baseUrl/auth/logout";
  static const String myStore = "$baseUrl/my-store";
  static const String showAgency = "$baseUrl/agencies/show";
  static const String agencyMember = "$baseUrl/agencies/showAllusers";
  static const String agencyRequests = "$baseUrl/agencies/show_request";
  static const String agencyRequestsAction = "$baseUrl/agencies/actions_request";
  static const String agencyHistoryTime = "$baseUrl/agencies/list_options_his";
  static const String agencyHistory = "$baseUrl/agencies/historyAgancy";
  static const String chargeCoinForUser = "$baseUrl/agencies/charge_co_for_users";
  static const String chargeDolarsForUser =
      "$baseUrl/agencies/charge_dollar_for_owner";
  static const String getAllIntrested = "$baseUrl/allinterests";
  static const String addIntrested = "$baseUrl/AddInterests";
  static const String getUseIntrested = "$baseUrl/user_interests";
  static const String uploadReel = "$baseUrl/reals";
  static const String getReels = "$baseUrl/reals";
  static const String yallowBanner = "$baseUrl/rooms/yellow-banner";
  static const String addMoment = "$baseUrl/moment";
  static  String makeMomentLikes(String momentID) => "$baseUrl/moment/$momentID/like";
  static   String momentSendGift({required String momentID}) =>"$baseUrl/moment/$momentID/gift";
  static const  String privacyPolicy ="https://test.dragon-chat.co/page/privacy-policy";
  static const String muteUserMic = "$baseUrl/rooms/mute-user";
  static const String unMuteUserMic = "$baseUrl/rooms/unmute-user";
  static String getAllShippingAgents(String? page){
    return "$baseUrl/users/charger_agency?page=$page";
  }

  static const String reportReals = "$baseUrl/report";
 static   String getExtraData (int type)=> "$baseUrl/images?type=$type";
  static String getMoments(
      String userId,
      String type,
      String page,

      ) {
    return "$baseUrl/moment?user_id=$userId&type=$type&page=$page";
  }
  static String getOneMoment(
    String momentId

      ) {
    return "$baseUrl/moment/$momentId";
  }
  static String reportMoment(
      String momentid,
      String type,
      String discreption,

      ) {
    //{{base_url}}/moment/79/report?description=nknkj&type=lmk
    return "$baseUrl/moment/$momentid/report?description=$discreption&type=$type";
  }

  static String addMomentComment(
    String momentId,
  ) {
    return "$baseUrl/moment/$momentId/comment";
  }

  static String deleteMomentComment(String momentId, String comment) {
    return "$baseUrl/moment/$momentId/comment/$comment";
  }

  static String getMomentComment(String momentId, String page) {
    return "$baseUrl/moment/$momentId/comment?page=$page";
  }

  static String getReel({String? reelId, String? page}) {
    if (reelId == null) {
      return "$baseUrl/reals?page=$page";
    } else {
      return "$baseUrl/reals/$reelId";
    }
  }

  static String getReelUser(String? userID, String? page) {
    if (userID == null) {
      return "$baseUrl/reals/user?page=$page";
    } else {
      return "$baseUrl/reals/user/$userID?page=$page";
    }
  }

  static String deleteReel(
    String reelId,
  ) {
    return "$baseUrl/reals/$reelId";
  }

  static String deleteMoment(
    String momentId,
  ) {
    return "$baseUrl/moment/$momentId";
  }

  static String getReelComments(String reelId, String? page) {
    return "$baseUrl/reals/$reelId/comment?page=$page";
  }

  static String makeReelComments(String reelId) {
    return "$baseUrl/reals/$reelId/comment";
  }

  static String makeReelLike(String reelId) {
    return "$baseUrl/reals/$reelId/like";
  }

  static String updateFamily(String familyId) =>
      "$baseUrl/families/edit/$familyId";
  static String prevsUse(String type) => "$baseUrl/hide?type=$type";
  static String prevsUnUse(String type) => "$baseUrl/un_hide?type=$type";

  static String getTimes(String time) =>
      "$baseUrl/user_info/getTimes?time=$time";

  String deleteFamily(String id) {
    return "$baseUrl/families/delete/$id";
  }

  String familyRemoveUser(String userId, String familyId) {
    return "$baseUrl/families/remove_user?user_id=$userId&family_id=$familyId";
  }

  String showFamily(String id) {
    return "$baseUrl/families/show/$id";
  }

  String upMic({required UpMicrophonePramiter upMic}) =>
      "$baseUrl/rooms/up_microphone?owner_id=${upMic.ownerId}&user_id=${upMic.userId}&position=${upMic.position}&is_swap=${upMic.isSwitch}";

  String search({required String keyword}) =>
      "$baseUrl/search?keywords=$keyword";
  String getRoomUpdate({required String roomId}) =>
      "$baseUrl/rooms/$roomId/edit";
  static const String getEmojie = "$baseUrl/emojis";
  static const String getCarousel = "$baseUrl/home_carousels";
  String getDataRooms(
          {int? countryId,
          int? classId,
          int? typeId,
          String? search,
          String? filter,
          int? page}) =>
      "$allRooms?page=$page&country_id=${countryId ?? ''}&class_id=${classId ?? ''}&type_id=${typeId ?? ''}&search=${search ?? ''}&filter=${filter ?? ''}";

  String getUserData({

   required String userId,
   bool? isVisit,
  }) {
    if(isVisit != null){
      return "$baseUrl/users/$userId?is_visit=$isVisit";
    }else {
      return "$baseUrl/users/$userId";
    }
  }

  String getBackPack(String type) {
    return "$baseUrl/user_info/my_pack?type=$type";
  }

  String getChargeHistory(String type) {
    return "$baseUrl/charge_history?type=$type";
  }

  String getChargeDolarsAgencyOwnerHistory(String type) {
    return "$baseUrl/agencies/charge_dollar_for_OwnerHistory?type=$type";
  }

  String getChargeCoinsSystemHistory(String type) {
    return "$baseUrl/agencies/charge_co_for_usersHistory?type=$type";
  }

  String getVipCenter({required String level}) =>
      "$baseUrl/vip_center?level=$level";


  String getImage(imageUrl) =>
      "https://storage.googleapis.com/tik-chat/$imageUrl";
  String getDataMallUrl(int type) => "$baseUrl/mall/wares?type=$type";
  String getGifts(int type) {
    return "$baseUrl/gifts?type=$type";
  }

  String showEmojie(String id, String roomId, String userId, String toZego) {
    return "$baseUrl/emojis/$id?room_id=$roomId&user_id=$userId&to_zego=$toZego";
  }

   static String getMomentGifts(String momentId) {
     return "$baseUrl/moments/$momentId/gifts";
   }

  String changeBackgroundZigo(
      {required String timestamp,
      required String signature,
      required String signatureNonce,
      required String roomId,
      required String fromUserId,
      required Map<String, dynamic> messageContent}) {
    String result = jsonEncode(messageContent);
    log(result);
    log("messageContent$messageContent");
    return "https://rtc-api.zego.im/?Action=SendCustomCommand&AppId=1381228&Timestamp=$timestamp&Signature=$signature&SignatureVersion=2.0&SignatureNonce=$signatureNonce&IsTest=no&RoomId=$roomId&FromUserId=$fromUserId&MessageContent=$result";
  }

  static const String relations = "$baseUrl/relations";
  static const String follow = "$relations/follow";
  static const String unFollow = "$relations/un-follow";
  static const String testGooglePay = "$baseUrl/test-google-pay";
  //User
  static const String data = "data";
  static const String id = "id";
  static const String name = "name";
  static const String email = "email";
  static const String phone = "phone";
  static const String numberOfFans = "number_of_fans";
  static const String numberOfFollowings = "number_of_followings";
  static const String numberOfFriends = "number_of_friends";
  static const String image = "image";
  static const String gender = "gender";
  static const String birthday = "birthday";
  static const String province = "province";
  static const String city = "city";
  static const String country = "country";
  static const String authToken = "auth_token";
  static const String profile = "profile";
  static const String code = "code";
  static const String password = "password";
  static const String succes = "success";
  static const String message = "message";
  static const String type = "type";
  static const String phoneCode = "phone_code";
  static const String phonePass = "phone_pass";
  static String getgiftHistory(String id) => "$baseUrl/my_gifts?user_id=$id";
  static const String sendLuckyGift   = "$baseUrl/gifts/send-lucky-gift";


  // messages send phone request

  static const String seccessSendPhoneRequest = "Will send code for you";

  // messages send code request

  static const String seccessSendCodeRequest = "Code is Right";

  // messages register
  static const String seccessRegister = "Register seccessfully";

  //Data Mall
  static const String title = "title";
  static const String price = "price";
  static const String color = "color";
  static const String expire = "expire";

  //rooms
  static const String roomPass = "room_pass";
  static const String ownerId = 'owner_id';

  //payment
  String payment({required String idPackageCoin}) {
    return "$baseUrl/payment-create?coins_id=${idPackageCoin}";
  }

  static String getMomentLike(String momentId, String page) {
    return "$baseUrl/moment/$momentId/like?page=$page";
  }
  static String getFollowingReels( String page,) {
    return "$baseUrl/reals/user-followers?page=$page";
  }

  static String activeNotification = "$baseUrl/reals/user-followers";
  static String getFixedTargetReport(String date){
   return "$baseUrl/user-statistics?date=$date";
  }
  static const String hostOnMicTime = "$baseUrl/rooms/liveTime";


  static const String encryptionKey = "L9:65W&+nG@g";
  static const String merchantId = "BCR2DN4T3GPIDDAG";
  static const String merchantName = "software";
  static String checkBlockUnblock( String userId) {
    return "$baseUrl/black_list/check/$userId";
  }
  static  String invitCode(String userId) {
    return "$baseUrl/add-code-invitation?code=$userId";
  }
  static const String invitationParent = "$baseUrl/parent-statistic";
  static const String invitationUsers = "$baseUrl/user-earn-from-invitation";
  static const String explainInvitation = "$baseUrl/explain-invitation";


}
