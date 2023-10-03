import 'package:equatable/equatable.dart';

class EmojieModel extends Equatable {

  final int id;
  final int pid;
  final String name;
  final String emoji;
  final int tLength;
  final int sort;
  final String userId ;
  const EmojieModel(
      {required this.emoji,
        required this.id,
        required this.userId,
        required this.name,
        required this.pid,
        required this.sort,
        required this.tLength});


  factory EmojieModel.fromjson(Map<String, dynamic> json) {
    return EmojieModel(
    userId: json['user_id']??"0",
        emoji: json["emoji"],
        id: json["id"],
        name: json["name"],
        pid: json["pid"],
        sort: json["sort"]??1,
        tLength: json["t_length"]);
  }

  @override
  // TODO: implement props
  List<Object?> get props => [ userId ,id, pid, name, emoji, tLength, sort];
}
