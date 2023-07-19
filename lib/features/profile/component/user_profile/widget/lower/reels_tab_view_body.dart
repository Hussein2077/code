import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/utils/config_sizee.dart';

class ReelsTabView extends StatelessWidget {
  const ReelsTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: 10,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 4 , horizontal: 4),
            width: MediaQuery.of(context).size.width / 3,
            height: ConfigSize.defaultSize! * 15,
            color: Colors.grey,
          );
        });
  }
}
