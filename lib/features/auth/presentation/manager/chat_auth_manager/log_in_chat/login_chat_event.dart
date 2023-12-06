
import 'package:equatable/equatable.dart';

abstract class BaseLoginChatEvent {
  const BaseLoginChatEvent ();
}

class LoginChatEvent extends BaseLoginChatEvent {
  final String id ;
  final String name ;
  final String avatar ;

  const LoginChatEvent({required this.id , required this.name , required this.avatar});
}
