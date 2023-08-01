import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/api_healper/constant_api.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/header_with_only_title.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/gift_history_manger/gift_history_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/gift_history_manger/gift_history_state.dart';

class GiftGallery extends StatelessWidget {
  const GiftGallery({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GiftHistoryBloc, BaseGiftHistoryState>(
      builder: (context, state) {
        if (state is GiftHistorySucssesState){
 return Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          body: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: ConfigSize.defaultSize! * 3),
                color: Theme.of(context).colorScheme.background,
                width: MediaQuery.of(context).size.width,
                height: ConfigSize.defaultSize! * 9,
                child:
                    const HeaderWithOnlyTitle(title: StringManager.giftGallery),
              ),
              Expanded(
                child: GridView.builder(
                    itemCount: state.data.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 1.1, crossAxisCount: 4),
                    itemBuilder: (context, index) {
                      return Container(
                          margin: EdgeInsets.only(
                              left: ConfigSize.defaultSize!,
                              right: ConfigSize.defaultSize!,
                              bottom: ConfigSize.defaultSize!),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(
                              ConfigSize.defaultSize!,
                            ),
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                          child: Column(
                            children: [
                              const Spacer(
                                flex: 1,
                              ),
                                 Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: ConfigSize.defaultSize! , ),
                            width: ConfigSize.defaultSize! * 10,
                            height: ConfigSize.defaultSize! * 5,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: CachedNetworkImageProvider(
                                      
                                        ConstentApi().getImage(
                                            state.data[index].data.img)), fit: BoxFit.contain)),
                          ),
                              const Spacer(
                                flex: 1,
                              ),
                              Text(
                                "${state.data[index].num} x",
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ));
                    }),
              )
            ],
          ),
        );
        }else {
          return const SizedBox();
        }
       
      },
    );
  }
}
