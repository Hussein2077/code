import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/utils/api_healper/constant_api.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/moment/data/model/moment_model.dart';

class MomentView extends StatelessWidget {
  final MomentModel momentModel;

  const MomentView({super.key, required this.momentModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ConfigSize.defaultSize! * 2,
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              momentModel.moment,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            SizedBox(
              height: ConfigSize.defaultSize! * 1.2,
            ),
            if (momentModel.momentImage != '')
              InkWell(
                onTap: (){
                  showImageViewer(
                      context,
                      CachedNetworkImageProvider(
                        ConstentApi().getImage(momentModel.momentImage),
                      ),
                      swipeDismissible: false);
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.circular(ConfigSize.defaultSize! * 2),
                    ),

                  child: Image.network(  ConstentApi().getImage(momentModel.momentImage),fit: BoxFit.fill,),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
