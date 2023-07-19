import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/utils/config_sizee.dart';


class CustomIcon extends StatelessWidget {
  final Color color ; 
  final String icon ; 
  final String title ; 
  final double?scale ; 
  
  const CustomIcon({this.scale,  required this.title ,  required this.color , required this.icon , super.key});

  @override
  Widget build(BuildContext context) {
    return     Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      decoration: BoxDecoration(
                          color: color,
                          borderRadius:
                              BorderRadius.circular(ConfigSize.defaultSize!)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Image.asset(
                           icon,
                            scale:scale?? 2.5,
                          ),
                          Text(
                           title,
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: ConfigSize.defaultSize!),
                          )
                        ],
                      ),
                    );
  }
}