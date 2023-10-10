import 'dart:async';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/custoum_error_widget.dart';
import 'package:tik_chat_v2/core/widgets/empty_widget.dart';
import 'package:tik_chat_v2/core/widgets/loading_widget.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/features/auth/presentation/widgets/custom_horizental_dvider.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/buy_coins_uc.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/coins/widgets/coins_card.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/coins/widgets/payment_method_dialog.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/buy_coins_manger/buy_coins_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/buy_coins_manger/buy_coins_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/buy_coins_manger/buy_coins_state.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manger_gold_coin/bloc/gold_coin_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manger_gold_coin/bloc/gold_coin_state.dart';

class CoinsTabView extends StatefulWidget {
  final String type;

  CoinsTabView({required this.type, super.key});

  @override
  State<CoinsTabView> createState() => _CoinsTabViewState();
}

class _CoinsTabViewState extends State<CoinsTabView> {
  var coinPackageId;

  late BuyCoinsBloc buyCoinsBloc;

  late StreamSubscription mSub;

  @override
  void initState() {
    buyCoinsBloc = BlocProvider.of<BuyCoinsBloc>(context);
    mSub = buyCoinsBloc.stream.listen((state) {
      if (state is BuyCoinsSuccessState) {
        Navigator.pushNamed(context, Routes.webView,
            arguments: WebViewPramiter(
                url: state.urlWeb,
                title: StringManager.payment.tr(),
                titleColor: Colors.green));
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    buyCoinsBloc.close();
    mSub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CoinCard(
          type: widget.type,
        ),
        Text(
          StringManager.recharge.tr(),
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        CustomHorizntalDvider(
          width: ConfigSize.defaultSize! * 3,
          color: widget.type == "gold" ? ColorManager.orang : Colors.grey,
        ),
        BlocBuilder<GoldCoinBloc, GoldCoinState>(builder: (context, state) {
          if (state is GoldCoinLoadingState) {
            return const LoadingWidget();
          } else if (state is GoldCoinSucssesState) {
            if (state.data.isEmpty) {
              return EmptyWidget(message: StringManager.noDataFoundHere.tr());
            } else {
              return Expanded(
                  child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3),
                      itemCount: state.data.length,
                      itemBuilder: (context, index) {
                        return Container(
                          padding:
                              EdgeInsets.only(top: ConfigSize.defaultSize!),
                          margin: EdgeInsets.symmetric(
                              vertical: ConfigSize.defaultSize!,
                              horizontal: ConfigSize.defaultSize!),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  ConfigSize.defaultSize!),
                              color: Theme.of(context).colorScheme.secondary),
                          child: widget.type == "gold"
                              ? BlocListener<BuyCoinsBloc, BuyCoinsState>(
                                  child: InkWell(
                                    onTap: () {
                                      if (Platform.isIOS) {
                                        coinPackageId =
                                            state.data[index].id.toString();
                                        showAlertDialog(context);
                                      } else {
                                        BlocProvider.of<BuyCoinsBloc>(context)
                                            .add(BuyCoins(
                                                buyCoinsParameter:
                                                    BuyCoinsParameter(
                                                        coinsID: state
                                                            .data[index].id
                                                            .toString(),
                                                        paymentMethod:
                                                            'opay')));
                                      }
                                    },
                                    child: Column(
                                      children: [
                                        Image.asset(
                                          AssetsPath.goldCoinIcon,
                                          scale: 4,
                                        ),
                                        Text(
                                          "${state.data[index].coin}",
                                          style: TextStyle(
                                              color: ColorManager.yellow,
                                              fontSize:
                                                  ConfigSize.defaultSize! *
                                                      1.7),
                                        ),
                                        Text("\$ ${state.data[index].usd}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium)
                                      ],
                                    ),
                                  ),
                                  listener: (context, state) {
                                    if (state is BuyCoinsLoadingState) {
                                      loadingToast(context: context, title: '');
                                    } else if (state is BuyCoinsErrorState) {
                                      errorToast(
                                          context: context, title: state.error);
                                    }
                                  })
                              : Column(
                                  children: [
                                    Image.asset(
                                      AssetsPath.sliverCoinIcon,
                                      scale: 5.5,
                                    ),
                                    Text(
                                      "1200",
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize:
                                              ConfigSize.defaultSize! * 1.7),
                                    ),
                                    Text("240 L.E",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium)
                                  ],
                                ),
                        );
                      }));
            }
          } else if (state is GoldCoinErrorState) {
            return CustomErrorWidget(message: state.error);
          } else {
            return const SizedBox();
          }
        })
      ],
    );
  }

  showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => PaymentMethodDialog(
        coinPackageId: coinPackageId,
      ),
    );
  }
}
