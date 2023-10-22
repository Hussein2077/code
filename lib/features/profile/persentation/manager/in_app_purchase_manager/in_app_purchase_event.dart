
// ignore_for_file: non_constant_identifier_names

import 'package:equatable/equatable.dart';

abstract class InAppPurchaseEvent extends Equatable {
  const InAppPurchaseEvent();

  @override
  List<Object> get props => [];
}
class PostInAppPurchaseEvent extends InAppPurchaseEvent{
  final String user_id ; 
  final String product_id ; 
  const PostInAppPurchaseEvent({required this.user_id , required this.product_id});
}