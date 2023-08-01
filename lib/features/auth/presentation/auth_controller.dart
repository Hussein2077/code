import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:tik_chat_v2/features/auth/presentation/component/otp/widget/otp_continers.dart';
import 'package:tik_chat_v2/features/auth/presentation/widgets/phone_wtih_country.dart';

class Authcontroller {

  Future<void> clearAuth ()async{

PhoneWithCountry.number=PhoneNumber();
OtpContiners.code="";

  }
}