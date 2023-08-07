import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/features/room/data/model/all_main_classes_model.dart';

class AllRoomsDataModel {
  final bool? success;
  final String? message;
  final List<RoomModelOfAll>? data;
  final Map<String, dynamic>? extraData;
  final dynamic? paginates;
  AllRoomsDataModel({
    this.success,
    this.message,
    this.data,
    this.extraData,
    this.paginates,
  });

  AllRoomsDataModel copyWith({
    bool? success,
    String? message,
    List<RoomModelOfAll>? data,
    Map<String, dynamic>? extraData,
    dynamic? paginates,
  }) {
    return AllRoomsDataModel(
      success: success ?? this.success,
      message: message ?? this.message,
      data: data ?? this.data,
      extraData: extraData ?? this.extraData,
      paginates: paginates ?? this.paginates,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'success': success,
      'message': message,
      'data': data?.map((x) => x.toMap()).toList(),
      'extra_data': extraData,
      'paginates': paginates,
    };
  }

  factory AllRoomsDataModel.fromMap(Map<String, dynamic> map) {
    return AllRoomsDataModel(
      success: map['success'] != null ? map['success'] as bool : null,
      message: map['message'] != null ? map['message'] as String : null,
      data: map['data'] != null
          ? List<RoomModelOfAll>.from(
        ( map['data']).map<RoomModelOfAll?>(
              (x) => RoomModelOfAll.fromMap(x as Map<String, dynamic>),
        ),
      )
          : null,
      extraData: map['extra_data'] != null
          ? Map<String, dynamic>.from(
          (map['extra_data'] as Map<String, dynamic>))
          : null,
      paginates: map['paginates'] != null ? map['paginates'] as dynamic : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory AllRoomsDataModel.fromJson(String source) =>
      AllRoomsDataModel.fromMap(json.decode(source) as Map<String, dynamic>);


}

class RoomModelOfAll {
  final int? id;
  var roomId;
    final String? roomName;

  final dynamic name;
  final int? visitorsCount;
  final String? cover;
  final AllMainClassesModel? classRoom;
  final AllMainClassesModel? type;
  final int? isHot;
  final int? isPopular;
  final dynamic? roomStatus;
  final String? roomIntro;
  final int? isRecommended;
  final int? ownerId;
  final String? lang;
  final CounterRoomModel? country ;
  final bool? passwordStatus;
  final bool?  isPK ;
  final bool? isBoxLucky ;
  RoomModelOfAll(
      {
        this.roomName,
        this.id,
        this.roomId,
        this.name,
        this.visitorsCount,
        this.cover,
        this.isBoxLucky,
        this.classRoom,
        this.type,
        this.isHot,
        this.isPK,
        this.isPopular,
        this.roomStatus,
        this.roomIntro,
        this.isRecommended,
        this.ownerId,
        this.country,
        this.lang,
        this.passwordStatus
      });



  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'room_id': roomId,
      'name': name,
      'visitors_count': visitorsCount,
      'cover': cover,
      'class': classRoom,
      'type': type,
      'is_hot': isHot,
      'is_popular': isPopular,
      'room_status': roomStatus,
      'room_intro': roomIntro,
      'is_recommended': isRecommended,
      'owner_id': ownerId,
      'lang':lang,
      'country':country,
      'password_status':passwordStatus,
      'owner_id':ownerId,
      'have_luck_box': isBoxLucky

    };
  }

  factory RoomModelOfAll.fromMap(Map<String, dynamic> map) {
    return   RoomModelOfAll(
    roomName:map['name'] ,  
        id: map['id'],
        roomId: map['room_id'],
        name: map['name'],
        visitorsCount: map['visitors_count'],
        cover:map['cover'],
        //classRoom: AllMainClassesModel.fromjson(map['class']),
        type: map['type']==null?  null:  AllMainClassesModel.fromjson(map['type']),
        isHot: map['is_hot'],
        isPopular: map['is_popular'],
        roomStatus: map['room_status'],
        passwordStatus: map['password_status'],
        roomIntro: map['room_intro'],
        isRecommended: map['is_recommended'],
        lang: map['lang'],
        country: map['country']==null ? null : CounterRoomModel.fromJson(map['country']) ,
        ownerId: map['owner_id'],
        isPK:  map['is_pk'],
        isBoxLucky: map['have_luck_box']
    ) ;
  }

  String toJson() => json.encode(toMap());

  factory RoomModelOfAll.fromJson(String source) =>
      RoomModelOfAll.fromMap(json.decode(source) as Map<String, dynamic>);


}

class CounterRoomModel extends Equatable{

  final int id ;
  final   String name ;
  final String flag ;
  final String phoneCode;
  final String lang ;


  CounterRoomModel({required this.id, required  this.phoneCode,required this.lang,required this.name, required this.flag});

  @override
  List<Object?> get props => [
    id ,
    name ,
    flag ,
    phoneCode,
    lang
  ];

  factory CounterRoomModel.fromJson(Map<String,dynamic> jsonData){

    return CounterRoomModel(
        id: jsonData['id'],
        name:  jsonData['name'],
        flag: jsonData['flag'],
        phoneCode: jsonData['phone_code'],
        lang:  jsonData['lang']
    );
  }




}
