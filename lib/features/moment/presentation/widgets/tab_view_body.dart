
import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/moment/data/model/moment_model.dart';
import 'package:tik_chat_v2/features/moment/presentation/moment_controller.dart';
import 'package:tik_chat_v2/features/moment/presentation/widgets/moment_appbar.dart';
import 'package:tik_chat_v2/features/moment/presentation/widgets/moment_bottom_bar.dart';
import 'package:tik_chat_v2/features/moment/presentation/widgets/moment_view.dart';


class TabViewBody extends StatelessWidget {
 final List<MomentModel> momentModelList;
 final String? type;

  const TabViewBody({Key? key,
    required this.momentModelList,
  this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: ConfigSize.screenWidth,
      height: ConfigSize.screenHeight,
      padding: EdgeInsets.symmetric(
          horizontal: ConfigSize.defaultSize! * 0.2),
      child: ListView.builder(
        itemCount: momentModelList.length,
        itemBuilder: (context, i) {




          return Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                ),
                child: Column(
                  children: [
                    MomentAppBar(
                      momentModel: momentModelList[i],
                    ),
                    MomentView(
                      momentModel: momentModelList[i],
                    ),
                    SizedBox(
                      height: ConfigSize.defaultSize! * 1.5,
                    ),
                    MomentBottomBar(
                      type: type,
                      momentModel: momentModelList[i],
                    ),
                    SizedBox(
                      height: ConfigSize.defaultSize! * 1.5,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
