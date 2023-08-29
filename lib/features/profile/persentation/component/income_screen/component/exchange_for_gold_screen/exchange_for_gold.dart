import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/custoum_error_widget.dart';
import 'package:tik_chat_v2/core/widgets/header_with_only_title.dart';
import 'package:tik_chat_v2/core/widgets/loading_widget.dart';
import 'package:tik_chat_v2/core/widgets/pop_up_dialog.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/features/auth/presentation/widgets/custom_horizental_dvider.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/income_screen/widget/card_diamonds_earned.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/exchange_dimonds_manger/bloc/exchange_dimond_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/exchange_dimonds_manger/bloc/exchange_dimond_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/exchange_dimonds_manger/bloc/exchange_dimond_state.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_my_store/my_store_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_my_store/my_store_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/replace_with_gold_manger/bloc/replace_with_gold_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/replace_with_gold_manger/bloc/replace_with_gold_state.dart';

class ExchangeForGoldScreen extends StatelessWidget {
  const ExchangeForGoldScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            height: ConfigSize.defaultSize! * 3.5,
          ),
          const HeaderWithOnlyTitle(title: StringManager.exchangeDaimond),
          SizedBox(
            height: ConfigSize.defaultSize! * 2,
          ),
           CardOfDiamondEarned(
            assetCard: AssetsPath.moneyBag,
          ),
          SizedBox(
            height: ConfigSize.defaultSize! * 2,
          ),
          Text(
            StringManager.recharge.tr(),
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          CustomHorizntalDvider(
            width: ConfigSize.defaultSize! * 3,
            color: ColorManager.orang,
          ),
          BlocBuilder<ReplaceWithGoldBloc, ReplaceWithGoldState>(
            builder: (context, state) {
              if (state is ReplaceWithGoldSucssesState) {
                return Expanded(
                    child: GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3),
                        itemCount: state.data.data.length,
                        itemBuilder: (context, index) {
                          return exchangeDaimondCard(
                              context: context,
                              id: state.data.data[index].id.toString(),
                              daimond:
                                  state.data.data[index].dimaond.toString(),
                              gold: state.data.data[index].coin.toString());
                        }));
              } else if (state is ReplaceWithGoldLodingState) {
                return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 2.5,
                    child: const LoadingWidget());
              } else if (state is ReplaceWithGoldErrorState) {
                return CustomErrorWidget(message: state.error);
              } else {
                return const CustomErrorWidget(
                    message: StringManager.unexcepectedError);
              }
            },
          )
        ],
      ),
    );
  }
}

Widget exchangeDaimondCard({
  required BuildContext context,
  required String gold,
  required String daimond,
  required String id,
}) {
  return BlocListener<ExchangeDimondBloc, ExchangeDimondState>(
    listener: (context, state) {
      if (state is ExchangeDimondLoadingState){
        loadingToast(context: context, title: StringManager.loading);

      }else if (state is ExchangeDimondSucssesState){
          BlocProvider.of<MyStoreBloc>(context).add(GetMyStoreEvent());
        sucssesToast(context: context, title: state.massage);
      }else if (state is ExchangeDimondErrorState){
        errorToast(context: context, title: state.error);
      }

    },
    child: InkWell(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return PopUpDialog(
                  headerText:
                      StringManager.exchangeDaimondMethod(gold, daimond),
                  accpetText: () {
                    BlocProvider.of<ExchangeDimondBloc>(context)
                        .add(ExchangeDimondEvent(itemId: id));
                        Navigator.pop(context);
                  });
            });
      },
      child: Container(
        padding: EdgeInsets.only(top: ConfigSize.defaultSize!),
        margin: EdgeInsets.symmetric(
            vertical: ConfigSize.defaultSize!,
            horizontal: ConfigSize.defaultSize!),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(ConfigSize.defaultSize!),
            color: Theme.of(context).colorScheme.secondary),
        child: Column(
          children: [
              Icon(Icons.diamond_rounded, color: Colors.blue.shade900,size: ConfigSize.defaultSize!*3.9),

            Text(daimond, style: Theme.of(context).textTheme.bodyMedium),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  gold,
                  style: TextStyle(
                      color: ColorManager.yellow,
                      fontSize: ConfigSize.defaultSize! * 1.7),
                ),
                SizedBox(
                  width: ConfigSize.defaultSize! * 0.5 ,
                ),
                Image.asset(
                  AssetsPath.goldCoinIcon,
                  scale: 12,
                ),
              ],
            )
          ],
        ),
      ),
    ),
  );
}
