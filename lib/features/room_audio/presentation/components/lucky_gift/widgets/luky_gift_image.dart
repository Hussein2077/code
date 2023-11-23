
import 'package:flutter/widgets.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/cached_network_image.dart';

class LukyGiftImage extends StatefulWidget {


 final String giftImg ;
  const LukyGiftImage({required this.giftImg , Key? key}) : super(key: key);

  @override
  _LukyGiftImageState createState() => _LukyGiftImageState();
}

class _LukyGiftImageState extends State<LukyGiftImage>
    with TickerProviderStateMixin {

  late Animation<double> _scaleAnimation;
  late AnimationController animationController;
  late Animation<Offset> offsetAnimation;
  late AnimationController controllerAnimationTransform;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );
    _scaleAnimation = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(
        parent:animationController,
        curve: Curves.linear,
      ),
    );
    controllerAnimationTransform = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    controllerAnimationTransform.addListener(() {
      if (controllerAnimationTransform.isCompleted) {
        controllerAnimationTransform.stop();
        animationController.forward();
      }
    });
    offsetAnimation = Tween(
        begin: const Offset(0, -650),
        end: const  Offset(0,10))
        .animate(CurvedAnimation(
      parent: controllerAnimationTransform,
      curve: Curves.easeInOut,
    ));
    controllerAnimationTransform.forward();



  }



  void dispose() {
    animationController.dispose() ;
    controllerAnimationTransform.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controllerAnimationTransform,
        builder: (context, child) {
      return Transform.translate(
        offset: offsetAnimation.value,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child:
        //Padding(
        //  padding: EdgeInsets.only(bottom: ConfigSize.defaultSize!*18),
        //  child:
          CustoumCachedImage(url: widget.giftImg,
            height: ConfigSize.defaultSize!*20,
            width: ConfigSize.defaultSize!*20,),
      //  )
      ),
      );});
  }
}
