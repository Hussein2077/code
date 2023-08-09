class AgencyHistoryTime {
  final String? month ;
  final String? year ;

  const AgencyHistoryTime({this.month , this.year});

  factory AgencyHistoryTime.fromJson(Map <String , dynamic> json){
    return AgencyHistoryTime(
      month: json['month']??"",
      year: json['year']??""
    );
  }
}