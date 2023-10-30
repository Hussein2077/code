
import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/core/model/profile_room_model.dart';

import '../../../../core/Model/level_data_model.dart';

class GroupChatModel extends Equatable{
  final int? id;
  final int? frameId;
  final int? vipLevel;
  final String? uuid;
  final String? name;
  final String? frame;
  final String? groupMessage;
  final String? massageCreatedAt;
  final ProfileRoomModel? profile;
  final LevelDataModel? level;
  final bool? hasColorName;

  const GroupChatModel( {
     this.frameId,
     this.uuid,
     this.name,
     this.frame,
     this.groupMessage,
     this.massageCreatedAt,
     this.id,
     this.profile,
     this.level,
     this.vipLevel,
      this.hasColorName

});


  factory GroupChatModel.fromJson(Map<String, dynamic>json){
    return GroupChatModel(
        uuid: json['uuid'],
        name: json['name'],
        frame: json['frame'],
        groupMessage: json['group_message'],
        massageCreatedAt: json['created_at'],
        id: json['id'],
        frameId: json['frame_id'],
      profile: json['profile'] != null
          ? ProfileRoomModel.fromMap(json['profile'] as Map<String, dynamic>)
          : null,
      level: json['level'] != null
          ? LevelDataModel.fromMap(json['level'] as Map<String, dynamic>)
          : null,
      vipLevel: json['vip']['level'],
        hasColorName:json['has_color_name'],

    );
  }

  @override
  List<Object?> get props => [vipLevel,level,profile,
    frame,frameId,id,massageCreatedAt,groupMessage,name,uuid,hasColorName];

}
