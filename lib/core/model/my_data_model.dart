



import 'dart:developer';

import 'package:tik_chat_v2/core/model/level_data_model.dart';
import 'package:tik_chat_v2/core/model/my_agency_model.dart';
import 'package:tik_chat_v2/core/model/my_store_model.dart';
import 'package:tik_chat_v2/core/model/owner_data_model.dart';
import 'package:tik_chat_v2/core/utils/api_healper/constant_api.dart';
import 'profile_room_model.dart';
import 'vip_center_model.dart';

class MyDataModel {
   int? id;
   String? chatId;
   String? name;
   String? email;
   String? phone;
   int? numberOfFans;
   int? numberOfFollowings;
   int? numberOfFriends;
   int? profileVisotrs;
   ProfileRoomModel? profile;
   LevelDataModel? level;
   VipCenterModel? vip1;
   MyStoreModel? myStore;
   String? authToken;
   String? frame;
   String? intro;
   int? frameId;
   int? introId;
   int? bubbleId;
   String? bubble;
   MyAgencyModel? myAgencyModel;
   bool? isAgencyRequest;//todo check this
   bool? isFirst;
   int? familyId;
   String? uuid;
   String? notificationId;
   String? bio;
   bool? hasRoom;
   bool? hasColorName;
   bool? isAanonymous;
   bool? isFacebook;
   bool? isGoogle;
   bool? isPhone;
   int? myType ;
   bool? isHideRoom ;


  static  MyDataModel? _instance ;



  MyDataModel({
    this.isFirst,
    this.bubbleId,
    this.introId,
    this.frameId,
    this.isAanonymous,
    this.hasRoom,
    this.profileVisotrs,
    this.id,
    this.chatId,
    this.name,
    this.email,
    this.phone,
    this.numberOfFans,
    this.numberOfFollowings,
    this.numberOfFriends,
    this.profile,
    this.level,
    this.vip1,
    this.myStore,
    this.authToken,
    this.intro,
    this.frame,
    this.myAgencyModel,
    this.isAgencyRequest,
    this.familyId,
    this.uuid,
    this.notificationId,
    this.bio,
    this.bubble,
    this.isFacebook,
    this.isGoogle,
    this.isPhone,
    this.hasColorName,
    this.myType,
    this.isHideRoom
  });

  

   setNewMyData({int? id ,String? chatId,
     String? name ,String? email
     ,String? phone,int? numberOfFans,
     int? numberOfFollowings,
     int? numberOfFriends,int? profileVisotrs,
     ProfileRoomModel? profile ,LevelDataModel? level,
     MyStoreModel? myStore ,String? authToken,
     String? frame,String? intro,
     int? frameId,int? introId,
     int? bubbleId,String? bubble,
     MyAgencyModel? myAgencyModel,bool? isAgencyRequest,
     bool? isFirst,int? familyId,String? uuid,
     String? notificationId,String? bio,bool? hasRoom,
     bool? hasColorName,bool? isAanonymous,bool? isFacebook,
     bool? isGoogle, VipCenterModel? vip1, bool? isPhone,
     int? myType , bool? isHideRoom


   }) {
     this.id = id??this.id;
     this.chatId = chatId?? this.chatId;
     this.name = name?? this.name;
     this.email =email?? this.email;
     this.phone = phone?? this.phone;
     this.numberOfFans = numberOfFans?? this.numberOfFans;
     this.numberOfFollowings = numberOfFollowings ?? this.numberOfFollowings;
     this.numberOfFriends = numberOfFriends ?? this.numberOfFans;
     this.profileVisotrs = profileVisotrs ?? this.profileVisotrs;
     this.profile = profile ?? this.profile;
     this.level = level ?? this.level;
     this.myStore = myStore?? this.myStore;
     this.authToken = authToken ?? this.authToken;
     this.frame =frame ?? this.frame;
     this.intro =intro  ?? this.intro;
     this.frameId =frameId ?? this.frameId;
     this.introId =introId ?? this.introId;
     this.bubble =bubble ?? this.bubble ;
     this.bubbleId = bubbleId ?? this.bubbleId;
     this.myAgencyModel= myAgencyModel ?? this.myAgencyModel;
     this.isAgencyRequest = isAgencyRequest  ?? this.isAgencyRequest;
     this.isFirst = isFirst ?? this.isFirst;
     this.uuid = uuid ?? this.uuid;
     this.hasColorName = hasColorName  ?? this.hasColorName;
     this.vip1 = vip1 ?? this.vip1;
     this.isFacebook = isFacebook  ?? this.isFacebook;
     this.isGoogle = isGoogle  ?? this.isGoogle;
     this.isAanonymous =isAanonymous ?? this.isAanonymous;
     this.hasRoom = hasRoom ?? this.hasRoom;
     this.notificationId = notificationId ?? this.notificationId;
     this.bio = bio ?? this.bio;
     this.frameId = frameId ?? this.frameId;
     this.myType = myType ?? this.myType;
     this.isHideRoom = isHideRoom ?? this.isHideRoom;




   }








  factory MyDataModel.fromMap(Map<String, dynamic> map) {
    //check singleton pattern
    if(_instance==null){
      //create to frist time
      _instance = MyDataModel(
        id: map['id'] ,
        chatId: map['chat_id'],
        notificationId: map['notification_id'],
        name: map['name'] ,
        email: map['email'] ,
        phone: map['phone'] ,
        frame: map['frame'] ,
        intro: map['intro'] ,
        bubbleId: map['bubble_id'] ,
        bubble: map['bubble'],
        hasColorName: map['has_color_name'],
        frameId: map['frame_id'] ,
        introId: map['intro_id'] ,
        isFirst: map['is_first'],
        isAgencyRequest: map['is_agency_request'],
        hasRoom: map['has_room'],
        isAanonymous: map['anonymous'],
        isFacebook: map['facebook_bind'],
        isGoogle: map['google_bind'],
        isPhone: map['phone_bind'],
        isHideRoom: map['room_hidden'] ,
        vip1: map['vip'] == null ? null : VipCenterModel.fromJson(map['vip']),
        familyId: map['family_id'],
        uuid: map['uuid'] != null ? map['uuid'] as String : "0",
        bio: map['bio'] != null ? map['bio'] as String : "",
        authToken: map[ConstentApi.authToken],
        numberOfFans: map['number_of_fans'] ,
        numberOfFollowings: map['number_of_followings'] ,
        numberOfFriends: map['number_of_friends'],
        profileVisotrs: map['profile_visitors'],
        profile: map['profile'] != null
            ? ProfileRoomModel.fromMap(map['profile'] as Map<String, dynamic>)
            : null,
        level: map['level'] != null
            ? LevelDataModel.fromMap(map['level'] as Map<String, dynamic>)
            : null,
        myStore: map['my_store'] != null
            ? MyStoreModel.fromMap(map['my_store'] as Map<String, dynamic>)
            : null,
        myAgencyModel: map['agency'] != null
            ? MyAgencyModel.fromjson(map["agency"])
            : null,
            myType: map['type_user']??0


      ) ;
    }else {
   _instance?.setNewMyData(
     id: map['id'] ,
     chatId: map['chat_id'],
     notificationId: map['notification_id'],
     name: map['name'] ,
     email: map['email'] ,
     phone: map['phone'] ,
     frame: map['frame'] ,
     intro: map['intro'] ,
     bubbleId: map['bubble_id'] ,
     bubble: map['bubble'],
     hasColorName: map['has_color_name'],
     frameId: map['frame_id'] ,
     introId: map['intro_id'] ,
     isFirst: map['is_first'],
     isAgencyRequest: map['is_agency_request'],
     hasRoom: map['has_room'],
     isAanonymous: map['anonymous'],
     isFacebook: map['facebook_bind'],
     isGoogle: map['google_bind'],
     isPhone: map['phone_bind'],
     vip1: map['vip'] == null ? null : VipCenterModel.fromJson(map['vip']),
     familyId: map['family_id'],
     uuid: map['uuid'] != null ? map['uuid'] as String : "0",
     bio: map['bio'] != null ? map['bio'] as String : "",
     authToken: map[ConstentApi.authToken],
     numberOfFans: map['number_of_fans'] ,
     numberOfFollowings: map['number_of_followings'] ,
     numberOfFriends: map['number_of_friends'],
     profileVisotrs: map['profile_visitors'],
     profile: map['profile'] != null
         ? ProfileRoomModel.fromMap(map['profile'] as Map<String, dynamic>)
         : null,
     level: map['level'] != null
         ? LevelDataModel.fromMap(map['level'] as Map<String, dynamic>)
         : null,
     myStore: map['my_store'] != null
         ? MyStoreModel.fromMap(map['my_store'] as Map<String, dynamic>)
         : null,
     myAgencyModel: map['agency'] != null
         ? MyAgencyModel.fromjson(map["agency"])
         : null,
                     myType: map['type_user']??0

   );
    }

  return _instance! ;
  }
  static MyDataModel getInstance(){
     return _instance?? MyDataModel() ;
 }


  UserDataModel convertToUserObject() {
     log('_instance'+_instance.toString());
    return UserDataModel(
      id: id,
      bubble:bubble,
      bubbleId:bubbleId,
      intro:intro,
      introId:introId,
      frame: frame,
      familyId: familyId,
      frameId: familyId,
      bio: bio,
      uuid:uuid,
      myStore: MyStoreModel(
        totalCoins: myStore?.totalCoins,
        coins: myStore?.coins,
        coupons: myStore?.coupons,
        silverCoin: myStore?.silverCoin,
        diamonds: myStore?.diamonds
      ),
      profile: ProfileRoomModel(
        image:profile?.image??'',
        gender: profile?.gender??1,
        age: profile?.age??0,


      ),
      name: name,
      chatId: chatId,
      hasColorName: hasColorName,
      notificationId: notificationId,
      level: LevelDataModel(
          senderImage: level?.senderImage,
          receiverImage: level?.receiverImage),
      vip1: VipCenterModel(level: vip1?.level),
      userType: myType,
      numberOfFans: numberOfFans,
      numberOfFollowings: numberOfFollowings,
      numberOfFriends: numberOfFriends,
      profileVisotrs: profileVisotrs
    );

  }
}