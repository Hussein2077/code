import 'package:equatable/equatable.dart';

class ConfigModel extends Equatable {
  final bool? isAuth ;
  final bool? isForce ;
  final bool? isLastVersion ;
  final bool?  updateGiftCache ;
  final bool?  updateFrameCach ;
  final bool? updateExtraCach ;
  final bool? updateEntroCach ;
  final bool? updateEmojieCach ;

  const ConfigModel(
      {this.isForce,
       this.isAuth,
       this.updateEmojieCach,
        this.updateEntroCach,
      this.isLastVersion,
      this.updateGiftCache,
      this.updateFrameCach,
      this.updateExtraCach});


  factory ConfigModel.fromJson(Map<String,dynamic> json)=>
      ConfigModel(
       isAuth: json['is_auth'],
      isForce: json['is_force'],
      isLastVersion: json['is_last_version'],
       updateExtraCach: json['cache_update']['extras'],
       updateFrameCach:  json['cache_update']['frames'],
          updateGiftCache: json['cache_update']['gifts'],
        updateEmojieCach:json['cache_update']['emoji'] ,
        updateEntroCach: json['cache_update']['intro']
      ) ;

  @override
  List<Object?> get props =>[isAuth,isLastVersion,
    isForce,updateExtraCach,updateFrameCach,updateEmojieCach,updateGiftCache,updateEntroCach];


}
class ConfigModelBody  {
  final  String appVersion   ;

  ConfigModelBody({required this.appVersion});

}