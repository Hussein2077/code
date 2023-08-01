
import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/features/profile/domin/entitie/back_pack_entities.dart';



class MyBagState extends Equatable {
  final List<BackPackEnities> entering;
  final RequestState enteringBackPackRequest;
  final String enteringBackPackMassage;

  final List<BackPackEnities> framesBackPack;
  final RequestState framesBackPackRequest;
  final String framesBackPackMassage;

  final List<BackPackEnities> bubblesPackBack;
  final RequestState bubblesPackBackRequest;
  final String bubblesPackBackMassage;

  const MyBagState(
      {this.entering = const [],
      this.enteringBackPackRequest = RequestState.loading,
      this.enteringBackPackMassage = "",
      this.framesBackPack = const [],
      this.framesBackPackRequest = RequestState.loading,
      this.framesBackPackMassage = "",
      this.bubblesPackBack = const [],
      this.bubblesPackBackRequest = RequestState.loading,
      this.bubblesPackBackMassage = ""});

  MyBagState copyWith({
    List<BackPackEnities>? entering,
    RequestState? enteringBackPackRequest,
    String? enteringBackPackMassage,
    List<BackPackEnities>? framesBackPack,
    RequestState? framesBackPackRequest,
    String? framesBackPackMassage,
    List<BackPackEnities>? bubblesPackBack,
    RequestState? bubblesPackBackRequest,
    String? bubblesPackBackMassage,
  }) {
    return MyBagState(
        entering: entering ?? this.entering,
        enteringBackPackRequest:
            enteringBackPackRequest ?? this.enteringBackPackRequest,
        bubblesPackBackMassage:
            bubblesPackBackMassage ?? this.bubblesPackBackMassage,
        framesBackPack: framesBackPack ?? this.framesBackPack,
        framesBackPackRequest:
            framesBackPackRequest ?? this.framesBackPackRequest,
        framesBackPackMassage:
            framesBackPackMassage ?? this.framesBackPackMassage,
        bubblesPackBack: bubblesPackBack ?? this.bubblesPackBack,
        bubblesPackBackRequest:
            bubblesPackBackRequest ?? this.bubblesPackBackRequest,
        enteringBackPackMassage:
            enteringBackPackMassage ?? this.enteringBackPackMassage);
  }

  @override
  List<Object?> get props => [
        entering,
        enteringBackPackRequest,
        framesBackPackRequest,
        framesBackPack,
        bubblesPackBack,
        bubblesPackBackRequest,
        enteringBackPackMassage,
        framesBackPackMassage,
        bubblesPackBackMassage,
      ];
}