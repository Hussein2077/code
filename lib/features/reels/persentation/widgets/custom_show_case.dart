import 'package:flutter/material.dart';
import 'package:showcaseview/showcaseview.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

class RealsShowcaseWidget extends StatefulWidget {
  final String textInContainer;
  final Widget child;
  final GlobalKey globalKey;
  final bool isSwap;
  final void Function()? onTargetClick;
  final bool? disableMovingAnimation;
  final CrossAxisAlignment? crossAxisAlignment;

  const RealsShowcaseWidget({
    super.key,
    required this.globalKey,
    required this.child,
    required this.textInContainer,
    this.onTargetClick,
    this.isSwap = false,
    this.crossAxisAlignment,
    this.disableMovingAnimation = false,
  });

  @override
  State<RealsShowcaseWidget> createState() => _RealsShowcaseWidgetState();
}

class _RealsShowcaseWidgetState extends State<RealsShowcaseWidget> with TickerProviderStateMixin{
  late AnimationController _controller;
  late Animation<Offset> _animation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat();
    _animation = Tween<Offset>(
      begin: const Offset(-0.5, 0.0),
      end: const Offset(0.5, 0.0),
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInCubic,
    ));
if(!widget.isSwap){
  _controller.stop();
}
  }
  @override
  dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Showcase.withWidget(

      key: widget.globalKey,
      height: ConfigSize.defaultSize! * 7,
      width:widget.isSwap? ConfigSize.defaultSize! * 15: ConfigSize.defaultSize! * 7,
      disableMovingAnimation: widget.disableMovingAnimation,
      overlayColor: Colors.transparent,
      container: Builder(
        builder: (context) {
          return Container(
            height: ConfigSize.defaultSize!*10,
            width: ConfigSize.defaultSize!*10,
            color: Colors.transparent,
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment:
                        widget.crossAxisAlignment ?? CrossAxisAlignment.start,
                    children: [
                      SlideTransition(
                        position: _animation,
                        textDirection: TextDirection.ltr,
                        child: RotatedBox(
                         quarterTurns: widget.isSwap ? 3 : 0,
                         child: SizedBox(
                             height: ConfigSize.defaultSize! * 4,
                             width: ConfigSize.defaultSize! * 4,
                             child: Image.asset(
                               AssetsPath.hand2,
                               color: Colors.white,
                             )),
                        ),
                      ),
                      SizedBox(
                        height: ConfigSize.defaultSize!,
                      ),
                      SizedBox(
                        width: ConfigSize.defaultSize! * 8,
                        child: Text(
                          widget.textInContainer ?? "",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: ConfigSize.defaultSize!,
                          ),
                        ),
                      ),
                    ],
                  ),
                  // SizedBox(
                  //   width: ConfigSize.defaultSize! * 3,
                  // ),
                ],
              ),
            ),
          );
        }
      ),
      // description: textInContainer,
      child: widget.child,
    );
  }
}
