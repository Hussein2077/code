class AgencyHistoryTime {
  final int? month ; 
  final int? year ;

  const AgencyHistoryTime({this.month , this.year});

  factory AgencyHistoryTime.fromJson(Map <String , dynamic> json){
    return AgencyHistoryTime(
      month: json['month']??0,
      year: json['year']??0
    );
  }
}