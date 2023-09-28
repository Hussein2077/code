import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/moment/data/model/moment_model.dart';


class MomentView extends StatelessWidget{
  final MomentModel momentModel;

  const MomentView({super.key,
    required this.momentModel
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: ConfigSize.defaultSize!*2),

      child:
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(momentModel.moment,
            style: Theme.of(context).textTheme.bodyMedium,),
SizedBox(height: ConfigSize.defaultSize!*1.2,),

Container(
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(ConfigSize.defaultSize!*2),
    color: Colors.blue,

  ),
  width: ConfigSize.screenWidth!,
  height: ConfigSize.defaultSize!*28,
 child:  CachedNetworkImage(imageUrl: momentModel.momentImage),
),



        ],
      ),
    );
  }

}