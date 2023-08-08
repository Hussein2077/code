
import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/core/model/owner_data_model.dart';
import 'package:tik_chat_v2/core/model/pk_model.dart';
import 'package:tik_chat_v2/features/profile/data/model/room_family_model.dart';
import 'package:tik_chat_v2/features/profile/data/model/show_family_model.dart';


class EnterRoomModel extends Equatable {
  final int? id ;
  final String? roomIdNum ;
  final int?  ownerId ;
  final String?  roomStatus;
  final bool? roomPassStatus;
  final String? roomName;
  final String? roomCover;
  final String? name ;
  final String? roomIntro;
  final String? roomPass;
  final String? roomType;
  final String? hot ;
  final String? roomBackground;
  final String? roomAdmin;
  final String? roomSpeak;
  final String? roomSound;
  final String? microPhone;
  final String? roomJudge;
  final int? isAfk;
  final String? nickName;
  final String? roomVisitor;
  final String? playNum;
  final String? freeMic;
  final String?  roomWelcome;
  final dynamic  giftPrice ;
  final int?  userType;
  final int?  isSound;
  final int?  ownerSound;
  final  int?  uidBlack;
  final String? ownerAvatar;
  final int?  isFavorite;
  final String?  backImg;
  final String?   txk ;
  final String?  micColor;
  final  int?    gap ;
  final int?  exp;
  final String?  phase;
  final int?  sort;
  final int?   num;
  final int?  audioSort;
  final  int? audioNum;
  final int?  strtoTime;
  final int? roomVisitorCount;
  final String? remainingTime ;
  final int?  isPK ;
  final PKModel? pkModel;
  final List<dynamic>? seats ;
  final OwnerDataModel? topUser ;
  final int? mode ;
  final List<String>? admins ;
  final List<String>? banedUsers ;
  final ShowFamilyModel? ownerFamliy ;
  final String? uuidOwnerRoom ;
  final List<Boxes>? boxes;
  final RoomFamilyModel? roomFamily;
  final int? showPk ;
  final String? roomRule;
  final bool? isUsersBaned ;
  final int? timePK ;



  const EnterRoomModel(
      { this.strtoTime,
        this.isUsersBaned,
        this.timePK,
        this.boxes,
        this.roomIdNum,
         this.ownerId,
        this.admins,
        this.banedUsers,
         this.roomStatus,
        this.pkModel,
        this.remainingTime,
         this.roomName,
         this.roomCover,
         this.name,
         this.roomIntro,
         this.roomPass,
         this.roomType,
         this.hot,
         this.roomBackground,
         this.roomAdmin,
         this.roomSpeak,
         this.roomSound,
         this.microPhone,
         this.roomJudge,
         this.isAfk,
         this.nickName,
         this.roomVisitor,
         this.playNum,
         this.freeMic,
          this.roomWelcome,
         this.giftPrice,
         this.userType,
         this.isSound,
          this.ownerSound,
         this.uidBlack,
         this.ownerAvatar,
         this.isFavorite,
         this.backImg,
         this.isPK,
         this.txk,
         this.micColor,
         this.gap,
          this.exp,
          this.phase,
          this.sort,
          this.num,
           this.audioSort,
         this.audioNum,
         this.id,
         this.roomVisitorCount,
         this.roomPassStatus,
        required this.seats,
        required this.topUser,
        required this.mode,
         this.ownerFamliy,
        this.uuidOwnerRoom,
        this.roomFamily,
        this.showPk , 
        this.roomRule,

      });


  factory EnterRoomModel.fromJson(Map<String,dynamic> jsonData){

    return EnterRoomModel(
      id: jsonData['id'],
      uuidOwnerRoom:  jsonData['uuid'],
      boxes:jsonData['boxes'] ==null ? null:  List<Boxes>.from(jsonData['boxes'].map((x)=>Boxes.fromJson(x))),
      mode :jsonData['mode'],
      admins: jsonData['admins'] ==null? null:List<String>.from(jsonData['admins']),
      banedUsers:  jsonData['ban_users'] ==null?
      null:List<String>.from(jsonData['ban_users']),
      remainingTime: jsonData['remaining_time'],
      isUsersBaned:jsonData['isUsersBaned'],
      timePK:jsonData['current_time_pk'],
      roomPassStatus: jsonData['password_status'],
      roomVisitorCount: jsonData['room_visitors_count'],
      roomIdNum :jsonData['room_id_num'],
      ownerId :jsonData['owner_id'],
      roomStatus:jsonData['room_status'],
      roomName :jsonData['room_name'],
      roomCover :jsonData['room_cover'],
      name :jsonData['name'],
      roomIntro:jsonData['room_intro'],
      roomPass:jsonData['room_pass'],
      roomType:jsonData['room_type'],
      hot :jsonData['hot'],
      roomBackground:jsonData['room_background'],
      roomAdmin:jsonData['room_admin'],
      roomSpeak:jsonData['room_speak'],
      roomSound:jsonData['room_sound'],
      microPhone:jsonData['microphone'],
      roomJudge:jsonData['room_judge'],
      isAfk:jsonData['is_afk'],
      nickName:jsonData['nickname'],
      roomVisitor:jsonData['room_visitor'],
      playNum:jsonData['play_num'],
      freeMic:jsonData['free_mic'],
      roomWelcome:jsonData['room_welcome'],
      giftPrice :jsonData['giftPrice'],
      userType:jsonData['user_type'],
      isSound:jsonData['is_sound'],
      ownerSound:jsonData['owner_sound'],
      uidBlack:jsonData['uid_black'],
      ownerAvatar:jsonData['owner_avatar'],
      isFavorite:jsonData['is_favorite'],
      backImg:jsonData['back_img'],
      txk :jsonData['txk'],
       micColor:jsonData['mic_color'],
       gap :jsonData['gap'],
       exp:jsonData['exp'],
      sort:jsonData['sort'],
      num:jsonData['num'],
      audioSort:jsonData['audio_sort'],
      audioNum:jsonData['audio_num'],
      strtoTime:jsonData['strto_time'],
      showPk: jsonData['show_pk'],
            roomRule: jsonData['room_rule']??"",

     ownerFamliy: jsonData['owner_family']==null?null:ShowFamilyModel.fromJson( jsonData['owner_family']),
     isPK:  jsonData['is_pk'],
        pkModel:jsonData['pk']==null? null: PKModel.fromJson(jsonData['pk']),
      seats:  jsonData['microphones'] ,
      topUser:jsonData['top_user']==null ? null : OwnerDataModel.fromMap(jsonData['top_user']),
       roomFamily:jsonData['room_family'] ==null ? null: RoomFamilyModel.fromJson( jsonData['room_family']),

    );
  }

  @override
  List<Object?> get props => [
    roomIdNum ,
    ownerId ,
    roomStatus,
    roomName,
    roomCover,
    name ,
    roomIntro,
    roomPass,
    roomType,
    hot ,
    roomBackground,
    roomAdmin,
    roomSpeak,
    roomSound,
    microPhone,
    roomJudge,
    timePK,
    isAfk,
    nickName,
    roomVisitor,
    playNum,
    freeMic,
    roomWelcome,
    giftPrice ,
    userType,
    isSound,
    ownerSound,
    uidBlack,
    ownerAvatar,
    isFavorite,
    backImg,
    txk ,
    micColor,
    gap ,
    exp,
    phase,
    sort,
    num,
    audioSort,
    audioNum,
    strtoTime,
    roomVisitorCount,
    roomPassStatus,
    seats,
    topUser
  ];
}

class Boxes extends Equatable {


  final int id ;
  final OwnerBox ownerBoxData ;
  final int coins ;
  final String type ;
  final int remmingTime ;


  const Boxes({required this.id,
    required this.ownerBoxData,
    required this.coins,
    required this.type ,
    required this.remmingTime,

  });

  factory Boxes.fromJson(Map<String,dynamic> json) => Boxes(
          id: json['id'],
          ownerBoxData: OwnerBox.fromJason( json['user']),
          coins: json['coins'],
          remmingTime :json['rem_time'],
          type: json['type']);

  @override
  // TODO: implement props
  List<Object?> get props => [id,ownerBoxData,coins,type,remmingTime];
}


class OwnerBox extends Equatable{


  final String? name ;
  final int? id ;
  final String? uuid;
  final String? image ;

  const OwnerBox({
     this.name,
     this.id,
     this.uuid,
     this.image});


  factory OwnerBox.fromJason(Map<String,dynamic> jsonData )=>
      OwnerBox(
        name:jsonData['name'],
        id: jsonData['id'],
        uuid: jsonData['uuid'],
        image: jsonData['image'],
      ) ;

  @override
  List<Object?> get props => [name,id,uuid,image];



}