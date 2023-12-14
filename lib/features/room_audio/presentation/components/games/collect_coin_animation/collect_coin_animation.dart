import 'package:flutter/material.dart';
import 'package:gif/gif.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';


class CoinCollectAnimate extends StatefulWidget {
  const CoinCollectAnimate({super.key});

  @override
  State<CoinCollectAnimate> createState() => _CoinCollectAnimateState();
}

class _CoinCollectAnimateState extends State<CoinCollectAnimate> with TickerProviderStateMixin {
  late GifController _controller ;

  @override
  void initState() {
    _controller = GifController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return

    SizedBox(
      height: MediaQuery.of(context).size.height,
      child: Gif(
        image: const AssetImage(AssetsPath.coinAnimate),
        controller: _controller, // if duration and fps is null, original gif fps will be used.
        //fps: 30,
        //duration: const Duration(seconds: 3),
        autostart: Autostart.loop,
        placeholder: (context) => const Text('Loading...'),
        onFetchCompleted: () {
          _controller.reset();
          _controller.forward();
        },
      ),
    );
  }
}
