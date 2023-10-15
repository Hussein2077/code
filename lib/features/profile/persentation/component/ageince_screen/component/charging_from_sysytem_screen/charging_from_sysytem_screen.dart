// ignore: must_be_immutable
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/search_container_visibity.dart';
import 'package:tik_chat_v2/core/widgets/text_field.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/features/home/presentation/manager/manger_search/search_bloc.dart';
import 'package:tik_chat_v2/features/home/presentation/manager/manger_search/search_events.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/income_screen/component/withdrawal_screen/widget/container_of_cash_withdrawal.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_charge_coin_for_user/charge_coin_for_user_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_charge_coin_for_user/charge_coin_for_user_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_charge_coin_for_user/charge_coin_for_user_state.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_my_store/my_store_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_my_store/my_store_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_my_store/my_store_state.dart';

// ignore: must_be_immutable
class CharchingCoinsForUsers extends StatefulWidget {
  CharchingCoinsForUsers({Key? key}) : super(key: key);

  @override
  State<CharchingCoinsForUsers> createState() => _CharchingCoinsForUsersState();
}

class _CharchingCoinsForUsersState extends State<CharchingCoinsForUsers> {
  late bool searchContainerVisible;
  late final TextEditingController withdrawalAmount;
  late final TextEditingController userID;



  @override
  void dispose() {
    searchContainerVisible = false;
    userID.dispose();
    withdrawalAmount.dispose();
    super.dispose();
  }

  void initState() {
    BlocProvider.of<MyStoreBloc>(context).add(GetMyStoreEvent());
    userID = TextEditingController();
    withdrawalAmount = TextEditingController();
    searchContainerVisible = false;
    super.initState();
  }

  final formGlobalKey = GlobalKey<FormState>();

  String coins = " " ;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChargeCoinForUserBloc, ChargeCoinForUserState>(
      listener: (context, state) {
        if (state is ChargeCoinForUserLoadingState) {
          loadingToast(context: context, title: StringManager.loading.tr());
        } else if (state is ChargeCoinForUserSucssesState) {
          sucssesToast(context: context, title: state.message);
          BlocProvider.of<MyStoreBloc>(context).add(GetMyStoreEvent());
        } else if (state is ChargeCoinForUserErrorState) {
          errorToast(context: context, title: state.error);
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Padding(
              padding: EdgeInsets.only(
                  top: ConfigSize.defaultSize! * 4.5,
                  right: ConfigSize.defaultSize! * 1.5,
                  left: ConfigSize.defaultSize! * 1.5),
              child: Form(
                key: formGlobalKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(Icons.arrow_back_ios)),
                        Text(
                          StringManager.chargeCoins.tr(),
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, Routes.chargeFromSystemHistory);
                          },
                          child: Text(
                            StringManager.details.tr(),
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: ConfigSize.defaultSize! * 2.0,
                    ),
                     BlocBuilder<MyStoreBloc, MyStoreState>(
                      builder: (context, state) {
                        if(state is MyStoreSucssesState){
                          coins = state.myStore.coins.toString() ;
      return  ContainerWithdrawal(
                          usd:state.myStore.coins.toString(),
                          icon:  Image.asset(AssetsPath.goldCoinIcon, scale: 8),
                          title: StringManager.coins.tr(),
                        );
                        }else {
                     return  ContainerWithdrawal(
                          usd:coins,
                          icon:  Image.asset(AssetsPath.goldCoinIcon, scale: 8),
                          title: StringManager.coins.tr(),
                        );
                        }

                      },
                    ),
                    SizedBox(
                      height: ConfigSize.defaultSize! * 2.0,
                    ),
                    Text(
                      StringManager.userID.tr(),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    SizedBox(
                      height: ConfigSize.defaultSize! * 1.0,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: ConfigSize.defaultSize!),
                      width: MediaQuery.of(context).size.width - 50,
                      height: ConfigSize.defaultSize! * 6,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: ColorManager.mainColor,
                        ),
                        borderRadius:
                            BorderRadius.circular(ConfigSize.defaultSize! * 2),
                      ),
                      child: TextFieldWidget(
                        type: TextInputType.number,
                        controller: userID,
                        hintText: StringManager.enterUserID.tr(),
                        onChanged: (value){
                          Future.delayed(const Duration(milliseconds: 1000),
                                  () {
                                BlocProvider.of<SearchBloc>(context)
                                    .add(SearchEvent(keyWord: userID.text));
                              });
                          setState(() {
                            searchContainerVisible = true;
                          });

                        },
                        onTap: () {
                          if (!searchContainerVisible) {
                            searchContainerVisible = true;
                          }
                        },
                      ),
                    ),
                    SearchContainerVisibility(
                      searchContainerVisible: searchContainerVisible,
                      userID: userID,
                    ),
                    SizedBox(
                      height: ConfigSize.defaultSize! * 2.0,
                    ),
                    Text(
                      StringManager.withdrawal.tr(),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    SizedBox(
                      height: ConfigSize.defaultSize! * 1.0,
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: ConfigSize.defaultSize!),
                      width: MediaQuery.of(context).size.width - 50,
                      height: ConfigSize.defaultSize! * 6,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: ColorManager.mainColor,
                        ),
                        borderRadius:
                            BorderRadius.circular(ConfigSize.defaultSize! * 2),
                      ),
                      child: TextFieldWidget(
                        type: TextInputType.number,
                        controller: withdrawalAmount,
                        hintText: StringManager.enterQuantityHere.tr(),
                      ),
                    ),
                    const Spacer(
                      flex: 6,
                    ),
                    BlocBuilder<ChargeCoinForUserBloc, ChargeCoinForUserState>(
                      builder: (BuildContext context, state) {
                        if(state is ChargeCoinForUserLoadingState){
                          return const SizedBox();
                        }else{
                          return ElevatedButton(
                            onPressed: () {
                              if (userID.text.isEmpty) {
                                errorToast(
                                    context: context,
                                    title: StringManager.pleaseEnterID.tr());
                              } else if (withdrawalAmount.text.isEmpty) {
                                errorToast(
                                    context: context,
                                    title: StringManager.pleaseEnterquantity.tr());
                              } else {
                                BlocProvider.of<ChargeCoinForUserBloc>(context).add(ChargeCoinForUserEvent(
                                    id: userID.text, amount: withdrawalAmount.text));
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        ConfigSize.defaultSize! * 1.2)),
                                backgroundColor: ColorManager.mainColor,
                                fixedSize: Size(MediaQuery.of(context).size.width,
                                    ConfigSize.defaultSize! * 6.0)),
                            child: Text(
                              StringManager.withdrawal.tr(),
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          );
                        }
                      },
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}