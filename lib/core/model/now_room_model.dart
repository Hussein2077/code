class NowRoomModel {
  bool? isnInRoom;
  int? uid;
  bool? inMine;
    bool? roomstatus ; 

  NowRoomModel(
      { this.roomstatus ,   this.isnInRoom,  this.uid,  this.inMine});
  factory NowRoomModel.fromjson(Map<String, dynamic> json) {
    return NowRoomModel(
       roomstatus: json['password_status'],
        isnInRoom: json["is_in_room"],
        uid: json["uid"]??0,
        inMine: json["is_mine"]);
  }
}
