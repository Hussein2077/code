
// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

import 'sender_history_model.dart';

class ChargeHistoryModel extends Equatable {
  List<Data>? data;

  ChargeHistoryModel({this.data});

  ChargeHistoryModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  @override
  List<Object?> get props => [data];
}

class Data {
  int? id;
  SenderHistory? sender;
  SenderHistory? receiver;
  String? value;
  String? time;
  String?type ; 

  Data({this.id, this.sender, this.receiver, this.value, this.time , this.type });

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sender =
        json['sender'] != null ? SenderHistory.fromJson(json['sender']) : null;
    receiver = json['receiver'] != null
        ? SenderHistory.fromJson(json['receiver'])
        : null;
    value = json['value'];
    time = json['time'];
    type = json["type"];
  }
}
