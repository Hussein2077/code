

import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/utils/config_sizee.dart';

class NumVistor extends StatelessWidget {
  const NumVistor({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
                    children: [
                      SizedBox(
                        width: ConfigSize.defaultSize,
                      ),
                      Text(
                        "44",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: ConfigSize.defaultSize! * 1.5),
                      ),
                      Icon(
                        Icons.person,
                        color: Colors.white,
                        size: ConfigSize.defaultSize! * 2,
                      ),
                    ],
                  );
  }
}