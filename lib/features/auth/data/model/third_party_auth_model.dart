// ignore_for_file: prefer_typing_uninitialized_variables

class ThirdPartyAuthModel{
  var data;
  String? type;

   bool? isAgeNotComplete;
   bool? isCountryNotComplete;
  ThirdPartyAuthModel( {this.data,  this.type,this.isCountryNotComplete,this.isAgeNotComplete,});
}