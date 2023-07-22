



class GetVipPrevModel {
  final bool? hasColorName;
    final bool? anonymous;
    final bool? countryHidden ;
    final bool?  lastActiveHidden;
        final bool?  visitHidden;
            final bool?  roomHidden;



  GetVipPrevModel({
    this.hasColorName,   
    this.anonymous,
    this.countryHidden , 
    this.lastActiveHidden,
    this.roomHidden,
    this.visitHidden,
  });





  factory GetVipPrevModel.fromjosn(Map<String, dynamic> map) {
    return GetVipPrevModel(
      hasColorName: map['has_color_name'] != null ? map['has_color_name'] as bool : null,    
       anonymous: map['anonymous']  != null ? map['anonymous'] as bool : null,
      roomHidden: map['room_hidden'],
            countryHidden: map['country_hidden'] != null ? map['country_hidden'] as bool : null,    

      lastActiveHidden: map['last_active_hidden'] != null ? map['last_active_hidden'] as bool : null,    

      visitHidden: map['visit_hidden'] != null ? map['visit_hidden'] as bool : null,    

    );
  }







 
}
