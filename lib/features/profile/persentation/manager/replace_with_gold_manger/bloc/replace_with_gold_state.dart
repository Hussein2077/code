


import 'package:equatable/equatable.dart';
import 'package:tik_chat_v2/features/profile/data/model/replace_with_gold_model.dart';


abstract class ReplaceWithGoldState extends Equatable {
  const ReplaceWithGoldState();
  
  @override
  List<Object> get props => [];
}

class ReplaceWithGoldInitial extends ReplaceWithGoldState {}
class ReplaceWithGoldLodingState extends ReplaceWithGoldState {}
class ReplaceWithGoldSucssesState extends ReplaceWithGoldState {
  final ReplaceWithGoldModel data ; 
  const ReplaceWithGoldSucssesState({required this.data});
}
class ReplaceWithGoldErrorState extends ReplaceWithGoldState {
  final String error ; 
  const ReplaceWithGoldErrorState({required this.error});
}

