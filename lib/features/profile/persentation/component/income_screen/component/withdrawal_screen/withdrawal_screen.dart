import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/model/my_data_model.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/text_field.dart';
import 'package:tik_chat_v2/core/widgets/toast_widget.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/income_screen/component/all_shipping_agents/all_shipping_agents_screen.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/income_screen/component/withdrawal_screen/widget/container_of_cash_withdrawal.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_all_shipping_agents_manager/get_all_shipping_agents_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_all_shipping_agents_manager/get_all_shipping_agents_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_charge_to/charge_to_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_charge_to/charge_to_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_charge_to/charge_to_state.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_my_store/my_store_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_my_store/my_store_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_my_store/my_store_state.dart';

// ignore: must_be_immutable
class CashWithdrawal extends StatefulWidget {

  static String userId='' ;

  CashWithdrawal({Key? key}) : super(key: key);

  @override
  State<CashWithdrawal> createState() => _CashWithdrawalState();
}

class _CashWithdrawalState extends State<CashWithdrawal> {
  final TextEditingController userID = TextEditingController();

  final TextEditingController withdrawalAmount = TextEditingController();

  final formGlobalKey = GlobalKey<FormState>();

  String usd = " ";

  @override
  void dispose() {
    CashWithdrawal.userId = '';
    // TODO: implement dispose
    super.dispose();
  }


  @override
  void initState() {
    CashWithdrawal.  userId = '';
    BlocProvider.of<AllShippingAgentsBloc>(context).add(GetAllShippingAgentsEvents());

    // TODO: implement initState
    super.initState();
  }

  bool isActive = false ;
  bool isActive2 = false ;

  @override
  Widget build(BuildContext context) {
    return BlocListener<ChargeToBloc, ChargeToState>(
      listener: (context, state) {
        if (state is ChargeToLoadingState) {
          loadingToast(context: context, title: StringManager.loading.tr());
        } else if (state is ChargeToSuccessState) {
          sucssesToast(context: context, title: state.chargeToModel.message);
          BlocProvider.of<MyStoreBloc>(context).add(GetMyStoreEvent());
        } else if (state is ChargeToErrorState) {
          errorToast(context: context, title: state.error);
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Padding(
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
                      StringManager.cashWithdrawal.tr(),
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(
                            context, Routes.detailsWithdrawal);
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
                    if (state is MyStoreSucssesState) {
                      usd = state.myStore.userUsd.toString();
                      return ContainerWithdrawal(
                        usd: state.myStore.userUsd.toString(),
                      );
                    } else {
                      return ContainerWithdrawal(
                        usd: usd,
                      );
                    }
                  },
                ),
                SizedBox(
                  height: ConfigSize.defaultSize! * 1.0,
                ),
                Text(StringManager.notChargeToAgancy.tr(),overflow: TextOverflow.visible),
                SizedBox(
                  height: ConfigSize.defaultSize! * 2.0,
                ),
                Visibility(
                  visible: isActive,
                  child: Column(
                    children: [

                      /// Text Withdrawal
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
                    ],
                  ),
                ),
                Row(
                  children: [

                    Switch(
                      activeColor: ColorManager.mainColor,
                        value: isActive,
                        onChanged: (value){
                        if(value){
                          CashWithdrawal.userId =MyDataModel.getInstance().uuid.toString();
                          log("User Id ${CashWithdrawal.userId}");
                        }else{
                          CashWithdrawal.userId = '';
                          log("User  ${CashWithdrawal.userId}");

                        }
                        setState(() {});
                        isActive=value;
                        isActive2=false;


                    }),
                     Text(StringManager.changeDollars.tr()),
                  ],
                ),


                Row(
                  children: [

                    Switch(
                        activeColor: ColorManager.mainColor,
                        value: isActive2,
                        onChanged: (value){
                          setState(() {
                            isActive2=value;
                            isActive= false;
                          });
                          if(isActive==false){
                            CashWithdrawal.userId = '';
                          }if(isActive2==false){
                            CashWithdrawal.userId = '';

                          }
                          log("User Switch 2 $CashWithdrawal.userId");

                        }),
                     Text(StringManager.forShippingAgent.tr()),
                  ],
                ),
                Visibility(
                  visible: isActive2,
                  child: Expanded(
                    child: Column(
                      children: [
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
                         AllShippingAgent(

                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: ConfigSize.defaultSize!*1,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (CashWithdrawal.userId.toString()=='') {
                      errorToast(
                          context: context,
                          title: StringManager.pleseSelectUser.tr());
                    } else if (withdrawalAmount.text.isEmpty) {
                      errorToast(
                          context: context,
                          title: StringManager.pleaseEnterquantity.tr());
                    } else {
                      BlocProvider.of<ChargeToBloc>(context).add(SendCharge(
                          uId: CashWithdrawal.userId, usd: withdrawalAmount.text));
                      log("Agabcy ${CashWithdrawal.userId}");
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
                ),
                SizedBox(
                  height: ConfigSize.defaultSize!*2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
