import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_huawei_availability/google_huawei_availability.dart';
import 'package:huawei_iap/huawei_iap.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/custoum_error_widget.dart';
import 'package:tik_chat_v2/core/widgets/empty_widget.dart';
import 'package:tik_chat_v2/core/widgets/loading_widget.dart';
import 'package:tik_chat_v2/core/widgets/snackbar.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/features/auth/presentation/widgets/custom_horizental_dvider.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/coins/components/huawei_in_app_purchases.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/coins/components/in_app_purchases.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/coins/widgets/coins_card.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/coins/widgets/payment_method_dialog.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/buy_coins_manger/buy_coins_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/buy_coins_manger/buy_coins_state.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_my_data_manager/get_my_data_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_my_data_manager/get_my_data_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manger_gold_coin/bloc/gold_coin_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manger_gold_coin/bloc/gold_coin_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manger_gold_coin/bloc/gold_coin_state.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/pay_manager/pay_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/pay_manager/pay_states.dart';

class CoinsTabView extends StatefulWidget {
  final String type;

  const CoinsTabView({required this.type, super.key});

  static int productId = 0;

  static List<ProductInfo> list = [];

  @override
  State<CoinsTabView> createState() => _CoinsTabViewState();
}

class _CoinsTabViewState extends State<CoinsTabView> {

  late BuyCoinsBloc buyCoinsBloc;

  late StreamSubscription mSub;

  bool isHuawei = false;

  void GoogleHuawei() async {
    isHuawei = (await GoogleHuaweiAvailability.isHuaweiServiceAvailable)!;
    setState(() {

    });
    if(isHuawei){
      getConsumableProducts();
    }
  }

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
    initialize(context);
    GoogleHuawei();

    super.initState();
  }

  @override
  void dispose() {
    mSub.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PayBloc, payState>(
      listener: (context, state) {
        if(state is huaweiPaySucssesState){
          ScaffoldMessenger.of(context).showSnackBar(successSnackBar(context, state.massege));
          BlocProvider.of<GetMyDataBloc>(context).add(GetMyDataEvent());
          BlocProvider.of<GoldCoinBloc>(context).add(GetGoldCoinDataEvent());
        }else if(state is huaweiPayErrorState){
          ScaffoldMessenger.of(context).showSnackBar(errorSnackBar(context, state.massege));
        }

      },
  builder: (context, state) {
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
        BlocBuilder<GoldCoinBloc, GoldCoinState>(
            builder: (context, state) {
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
                                      if(isHuawei){
                                        if(CoinsTabView.list.isNotEmpty){
                                          showDialog(
                                            context: context,
                                            builder: (BuildContext context) => PaymentMethodDialog(coinPackageId: state.data[index].id, coin: state.data[index].coin.toString(), price: state.data[index].usd.toString()),
                                          );
                                        }else{
                                          errorToast(context: context, title: StringManager.wait.tr());
                                        }
                                      }else{
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) => PaymentMethodDialog(coinPackageId: state.data[index].id, coin: state.data[index].coin.toString(), price: state.data[index].usd.toString(),),
                                        );
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
  },
);
  }
}
