import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/api_healper/constant_api.dart';
import 'package:tik_chat_v2/core/utils/api_healper/enum.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/custoum_error_widget.dart';
import 'package:tik_chat_v2/core/widgets/loading_widget.dart';
import 'package:tik_chat_v2/core/widgets/mian_button_for_mybag.dart';
import 'package:tik_chat_v2/features/profile/data/model/get_badges_model.dart';

class MedlesTabBarView extends StatelessWidget {
  const MedlesTabBarView(
      {Key? key,

      required this.type,
      required this.getBadges,
      required this.stateRequest,
      required this.getBadgesMassage,
      required this.index})
      : super(key: key);
   final String type;
  final List<GetBadgesModel> getBadges;
  final RequestState stateRequest;
  final String getBadgesMassage;
  final int index;
  void dialog(BuildContext context,{required String description,}) {
    showDialog(
      context: context,
      builder: (BuildContext context,) {
        return AlertDialog(
          title: const Text("Description"),
          content: Text(description, overflow: TextOverflow.clip,),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    switch (stateRequest) {
      case RequestState.loaded:
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: ConfigSize.defaultSize! * 2,
          crossAxisSpacing: ConfigSize.defaultSize! * 2,
        ),
        shrinkWrap: true,
        itemCount: getBadges[0].levels.length,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(ConfigSize.defaultSize! * 2)),
            child: Padding(
              padding: EdgeInsets.all(ConfigSize.defaultSize! * 2),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CachedNetworkImage(
                    imageUrl: ConstentApi().getImage(getBadges[0].levels[index].image),
                    height: ConfigSize.screenHeight!*.117,
                    width:  ConfigSize.screenWidth!*.25,),

                  SizedBox(
                    width: ConfigSize.defaultSize! * 7,
                    child: MainButtonForMyBag(
                      title: StringManager.description.tr(),
                      onTap: () {
                        dialog(context, description: getBadges[0].levels[index].description);
                      },
                      titleSize: ConfigSize.defaultSize! * 1,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
      case RequestState.loading:
        return const LoadingWidget();
      case RequestState.error:
        return CustomErrorWidget(message: getBadgesMassage);
    }
  }
}
