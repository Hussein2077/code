import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:svgaplayer_flutter/svgaplayer_flutter.dart';
import 'package:tik_chat_v2/core/service/service_locator.dart';
import 'package:tik_chat_v2/core/utils/api_healper/constant_api.dart';
import 'package:tik_chat_v2/core/utils/api_healper/methods.dart';

class ShowSVGA extends StatefulWidget {
  final String imageId;
  final double? width;
  final double? hieght;
  final String url;
  const ShowSVGA(
      {required this.imageId,
      required this.url,
      this.width,
      this.hieght,
      Key? key})
      : super(key: key);

  @override
  ShowSVGAState createState() => ShowSVGAState();
}

class ShowSVGAState extends State<ShowSVGA> with TickerProviderStateMixin {
  late SVGAAnimationController animationController;
  //late SVGAAnimationController animationControllerHandler;

  @override
  void initState() {
    animationController = SVGAAnimationController(vsync: this);
    //this.animationControllerHandler = SVGAAnimationController(vsync: this);
    animationController.addListener(() {
      if (animationController.status == AnimationStatus.dismissed) {

      //  _getSvgaImage(giftId: widget.imageId);
      }
    });
    //todo solve that from zego
    if(widget.imageId.contains('null')){
      Future.delayed(const Duration(seconds:3 ),(){
        _getSvgaImage(giftId: widget.imageId);
      });
    }else{
      _getSvgaImage(giftId: widget.imageId);
    }


    super.initState();
  }

  @override
  void dispose() {
    //to handle any exception when svga not found
    if(animationController.isAnimating){
      animationController.dispose();
    }

    super.dispose();

  }

  @override
  Widget build(BuildContext context) {
      return SizedBox(
        width: widget.width,
        height: widget.hieght,
        child:SVGAImage(animationController),
      );
    }


  Future<void> _getSvgaImage(
      {required String giftId}) async {
    final cacheManager =  getIt<DefaultCacheManager>() ;
    final file = await cacheManager.getFileFromCache(giftId);
    final bytes = await file?.file.readAsBytes();

    if (bytes != null) {
      try{

        final videoItem =
        await SVGAParser.shared.decodeFromBuffer(bytes.toList());
        animationController.videoItem = videoItem;
        animationController
            .repeat()
            .whenComplete(() => animationController.videoItem = null );
      }catch (e){

        // if data does not cached
        final videoItem = await SVGAParser.shared
            .decodeFromURL(ConstentApi().getImage(widget.url));
        animationController.videoItem = videoItem;
        animationController
            .repeat() // Try to use .forward() .reverse()
            .whenComplete(() => animationController.videoItem = null);
        // load data again
        await Methods.instance.cacheSvgaImage(
          svgaUrl: ConstentApi().getImage(widget.url),
          imageId: giftId,
        );
      }
    }
    else {

  try{

      // if data does not cached
      final videoItem = await SVGAParser.shared
          .decodeFromURL(ConstentApi().getImage(widget.url));
      animationController.videoItem = videoItem;
      animationController
          .repeat() // Try to use .forward() .reverse()
          .whenComplete(() => animationController.videoItem = null);

      // load data again
      await Methods.instance.cacheSvgaImage(
        svgaUrl: ConstentApi().getImage(widget.url),
        imageId: giftId,
      );
  }catch(e){
    log(e.toString());
  }
    }

  }

}
