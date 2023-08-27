import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/model/user_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/api_healper/constant_api.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/custoum_error_widget.dart';
import 'package:tik_chat_v2/core/widgets/loading_widget.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/gift_history_manger/gift_history_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/gift_history_manger/gift_history_state.dart';
import 'dart:ui' as ui;

class ProfileTabViewBody extends StatelessWidget {
  final UserDataModel userDataModel;

  const ProfileTabViewBody({required this.userDataModel, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            cover(
                title: StringManager.diamond.tr(),
                num: userDataModel.myStore!.diamonds.toString(),
                image: AssetsPath.dimondCover),
            cover(
              title: StringManager.level.tr(),
              num: "lvl ${userDataModel.level!.senderLevel.toString()}",
              image: AssetsPath.leveCover,
              onTap: () => Navigator.pushNamed(context, Routes.level),
            ),
            cover(
              title: StringManager.vip.tr(),
              num: "vip. ${userDataModel.vip1!.level.toString()}",
              image: AssetsPath.vipCover,
              onTap: () => Navigator.pushNamed(context, Routes.vip),
            ),
          ],
        ),
        SizedBox(
          height: ConfigSize.defaultSize! * 2,
        ),
        InkWell(
          onTap: () {
            Navigator.pushNamed(context, Routes.giftGallery);
          },
          child: Row(
            children: [
              const Spacer(
                flex: 1,
              ),
              Text(
                StringManager.giftGallery.tr(),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const Spacer(
                flex: 15,
              ),
              Icon(
                Icons.arrow_forward_ios,
                color: Theme.of(context).colorScheme.primary,
                size: ConfigSize.defaultSize! * 1.5,
              ),
              const Spacer(
                flex: 1,
              )
            ],
          ),
        ),
        SizedBox(
          height: ConfigSize.defaultSize! * 2,
        ),
        BlocBuilder<GiftHistoryBloc, BaseGiftHistoryState>(
          builder: (context, state) {
            if (state is GiftHistorySucssesState) {
              return Expanded(
                child: ListView.builder(
                    itemCount: state.data.length > 4 ? 4 : state.data.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: ConfigSize.defaultSize!),
                            width: ConfigSize.defaultSize! * 10,
                            height: ConfigSize.defaultSize! * 10,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: CachedNetworkImageProvider(
                                        ConstentApi().getImage(
                                            state.data[index].data.img)))),
                          ),
                          Text(
                            "${state.data[index].num} x",
                            style: Theme.of(context).textTheme.bodyMedium,
                          )
                        ],
                      );
                    }),
              );
            } else if (state is GiftHistoryLoadingState) {
              return SizedBox(
                width: MediaQuery.of(context).size.width,
                height: ConfigSize.defaultSize! * 8,
                child: const LoadingWidget(),
              );
            } else if (state is GiftHistoryErrorState) {
              return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: ConfigSize.defaultSize! * 5,
                  child: CustomErrorWidget(
                    message: state.error,
                  ));
            } else {
              return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: ConfigSize.defaultSize! * 5,
                  child:  CustomErrorWidget(
                    message: StringManager.unexcepectedError.tr(),
                  ));
            }
          },
        )
      ],
    );
  }
}

Widget cover(
    {required String title,
    required String num,
    required String image,
    void Function()? onTap}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.only(
          top: ConfigSize.defaultSize!, right: ConfigSize.defaultSize!),
      width: ConfigSize.defaultSize! * 13,
      height: ConfigSize.defaultSize! * 7,
      decoration: BoxDecoration(
        image: DecorationImage(image: AssetImage(image), fit: BoxFit.fill),
      ),
      child: Directionality(
        textDirection:ui.TextDirection.ltr,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              title,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: ConfigSize.defaultSize! * 1.4,
                  fontWeight: FontWeight.bold),
            ),
            Text(
              num,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: ConfigSize.defaultSize! * 1.4,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    ),
  );
}
