

import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

class NumVistor extends StatelessWidget {
  final String numOfVistor ; 
  const NumVistor({required this.numOfVistor ,  super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
                    children: [
                      SizedBox(
                        width: ConfigSize.defaultSize,
                      ),
                      Text(
                        numOfVistor,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: ConfigSize.defaultSize! * 1.5),
                      ),
                      Icon(
                        Icons.person,
                        color: Colors.black,
                        size: ConfigSize.defaultSize! * 2,
                      ),
                    ],
                  );
  }
}