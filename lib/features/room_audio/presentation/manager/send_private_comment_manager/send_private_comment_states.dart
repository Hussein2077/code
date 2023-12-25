import 'package:tik_chat_v2/features/room_audio/data/model/SendPrivateCommentModel.dart';

abstract class SendPrivateCommentStates{
  const SendPrivateCommentStates();

  @override
  List<Object?> get props => [];
}

class SendPrivateCommentInitialState extends SendPrivateCommentStates {}

class SendPrivateCommentLoadinglState extends SendPrivateCommentStates {}

class SendPrivateCommentSucssesState extends SendPrivateCommentStates {
  final SendPrivateCommentModel data;
  SendPrivateCommentSucssesState(this.data);
}

class SendPrivateCommentErrorState extends SendPrivateCommentStates {
  final String errorMassage ;
  SendPrivateCommentErrorState(this.errorMassage);
}
