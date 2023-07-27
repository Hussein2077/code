




import 'package:equatable/equatable.dart';

class GetConfigKeyModel extends Equatable {
  final String? specialBar ;
    final int? wapelNum ;
    final int? userCoin ;
    final String? userCoinString;
    final String? familyPrice ; 





  const GetConfigKeyModel(
      { this.specialBar,
        this.wapelNum , 
        this.userCoin , 
        this.userCoinString
        ,
        this.familyPrice,

      });


  factory GetConfigKeyModel.fromJson(Map<String,dynamic> jsonData){

    return GetConfigKeyModel(
        specialBar: jsonData['special_bar_coin']??"",
        wapelNum: jsonData["wapel_num"]??0,
        userCoin: jsonData['user_coins']??0,
        userCoinString : jsonData['user_coins_string']??'',
        familyPrice: jsonData["family_price"]??""
    

    );
  }

  @override
  List<Object?> get props => [
   specialBar
  ];
}

