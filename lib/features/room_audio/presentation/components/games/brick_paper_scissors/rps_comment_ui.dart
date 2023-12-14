import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/show_svga.dart';
import 'package:tik_chat_v2/features/home/data/model/svga_data_model_.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/game_cashe_bloc/bloc.dart';
import 'package:tik_chat_v2/features/room_audio/presentation/manager/game_cashe_bloc/state.dart';

class BrickPaperScissorsGame extends StatefulWidget {
  const BrickPaperScissorsGame({super.key, required this.randomNum});

  final int randomNum;

  @override
  State<BrickPaperScissorsGame> createState() => _BrickPaperScissorsGameState();
}

class _BrickPaperScissorsGameState extends State<BrickPaperScissorsGame> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  bool showResultGame = false;

  @override
  void didChangeDependencies() {
    Future.delayed(const Duration(seconds: 4), () {
      setState(() {
        showResultGame = true;
      });
    });
    super.didChangeDependencies();
  }

  List<String> brickPaperNum = [
    AssetsPath.brick,
    AssetsPath.paper,
    AssetsPath.scissors,
  ];
  int isFirst = 0;
  SvgaDataModel? tempData;

  @override
  Widget build(BuildContext context) {
    super.build(context); // Ensure the super build is called
    return BlocBuilder<CacheGamesBloc, CacheStates>(
      builder: (context, state) {
        if (state is ExtraDataSuccess) {
          tempData = state.svgaDataModel;
          isFirst++;
          return SizedBox(
            height: ConfigSize.defaultSize! * 7,
            width: ConfigSize.defaultSize! * 7,
            child: showResultGame
                ? Image.asset(brickPaperNum[widget.randomNum])
                : ShowSVGA(
                    imageId: state.svgaDataModel.rpsModel.id.toString(),
                    url: state.svgaDataModel.rpsModel.image.toString()),
          );
        } else if (state is ExtraDataLoading) {
          if (isFirst == 0) {
            return SizedBox(
              height: ConfigSize.defaultSize! * 7,
              width: ConfigSize.defaultSize! * 7,
            );
          } else {
            return SizedBox(
              height: ConfigSize.defaultSize! * 7,
              width: ConfigSize.defaultSize! * 7,
              child: showResultGame
                  ? Image.asset(brickPaperNum[widget.randomNum])
                  : ShowSVGA(
                      imageId: tempData!.rpsModel.id.toString(),
                      url: tempData!.rpsModel.image.toString()),
            );
          }
        } else if (state is ExtraDataError) {
          return SizedBox(
              height: ConfigSize.defaultSize! * 7,
              width: ConfigSize.defaultSize! * 7,
              child: ErrorWidget(state.error));
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
