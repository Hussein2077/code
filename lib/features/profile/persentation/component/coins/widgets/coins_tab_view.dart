import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
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
import 'package:tik_chat_v2/features/profile/persentation/manager/buy_coins_manger/buy_coins_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/buy_coins_manger/buy_coins_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/buy_coins_manger/buy_coins_state.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manger_gold_coin/bloc/gold_coin_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manger_gold_coin/bloc/gold_coin_state.dart';

class CoinsTabView extends StatefulWidget {
  final String type;

  const CoinsTabView({required this.type, super.key});

  @override
  State<CoinsTabView> createState() => _CoinsTabViewState();
}

class _CoinsTabViewState extends State<CoinsTabView> {

  final InAppPurchase _connection = InAppPurchase.instance;

  final Set<String> _productIds = {"140", "1400", "4200", "14000", "28000", "70000"};

  List<ProductDetails> _products = [];

  Map<String, dynamic> productsMap = {
    "140": '',
    "1400": '',
    "4200": '',
    "14000": '',
    "28000": '',
    "70000": '',
  };

  late StreamSubscription<List<PurchaseDetails>> purchaseUpdatedSubscription;

  Future<void> _initialize() async {
    final bool available = await _connection.isAvailable();
    if (available) {
      await _queryProducts();
      // Subscribe to purchase updates
      _connection.purchaseStream.listen((detailsList) {
        _handlePurchaseUpdates(detailsList);
      });
    }
  }

  Future<void> _queryProducts() async {
    final ProductDetailsResponse response = await _connection.queryProductDetails(_productIds);
    if (response.error == null) {
      setState(() {
        _products = response.productDetails;
        for(int i = 0; i < _products.length; i++){
          productsMap[_products[i].id] = _products[i];
        }
      });
    }
  }

  Future<void> _handlePurchaseUpdates(List<PurchaseDetails> detailsList) async{
    for (PurchaseDetails purchaseDetails in detailsList) {
      log("status: ${purchaseDetails.status.name}");
      if (purchaseDetails.status == PurchaseStatus.purchased) {
        await acknowledgePurchase(purchaseDetails);
        print("#################");
        print(purchaseDetails);
        print("#################");
        // Handle the purchased item, e.g., grant access to premium content.
        // Make sure to verify and acknowledge the purchase on your server.
        // You can also save purchase details locally for later reference.
      } else if (purchaseDetails.status == PurchaseStatus.error) {
        // Handle purchase errors, if any.
        log("status error: ${purchaseDetails.error!.message}");
      }
    }
  }

  Future<void> acknowledgePurchase(PurchaseDetails purchaseDetails) async {
    try {
      if (purchaseDetails.pendingCompletePurchase) {
        log("pendingCompletePurchase");
        await InAppPurchase.instance.completePurchase(purchaseDetails);
      }
    } catch (e) {
      // Handle any errors or exceptions that may occur during the acknowledgment process.
    }
  }

  Future<void> _buyProduct(ProductDetails product) async {
    final PurchaseParam purchaseParam = PurchaseParam(productDetails: product);
    try {
      await _connection.buyConsumable(purchaseParam: purchaseParam);
    } catch (e) {
      log("error in buy function: $e");
      // Handle purchase errors, if any.
    }
  }

  late BuyCoinsBloc buyCoinsBloc;

  late StreamSubscription mSub;

  @override
  void initState() {
    _initialize();
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
                                        _buyProduct(productsMap[state.data[index].coin.toString()]);
                                      } else {
                                        BlocProvider.of<BuyCoinsBloc>(context).add(BuyCoins(buyCoinsParameter: BuyCoinsParameter(coinsID: state.data[index].id.toString(), paymentMethod: 'opay')));
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
}
