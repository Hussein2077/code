import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';

import '../resource_manger/color_manager.dart';


class DilogLoadingWidget extends StatelessWidget {
  const DilogLoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: ConfigSize.defaultSize!*6,
        height: ConfigSize.defaultSize!*6,
        child: Card(
          elevation: 10,
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ConfigSize.defaultSize!*5),
          ),
          child: const  Center(child: Padding(
            padding:  EdgeInsets.all(15.0),
            child: CircularProgressIndicator(
              backgroundColor: Colors.white,
              color: ColorManager.mainColor,
            ),
          )),
        ),
      ),
    );
  }
}
