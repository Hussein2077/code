import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/custoum_error_widget.dart';
import 'package:tik_chat_v2/core/widgets/empty_widget.dart';
import 'package:tik_chat_v2/core/widgets/loading_widget.dart';
import 'package:tik_chat_v2/features/auth/presentation/widgets/custom_horizental_dvider.dart';
import 'package:tik_chat_v2/features/profile/domin/use_case/buy_coins_uc.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/coins/widgets/coins_card.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/buy_coins_manger/buy_coins_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/buy_coins_manger/buy_coins_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manger_gold_coin/bloc/gold_coin_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manger_gold_coin/bloc/gold_coin_state.dart';


class CoinsTabView extends StatelessWidget {
  final String type;

  const CoinsTabView({required this.type, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CoinCard(
          type: type,
        ),
        Text(
          StringManager.recharge.tr(),
          style: Theme.of(context).textTheme.headlineLarge,
        ),
        CustomHorizntalDvider(
          width: ConfigSize.defaultSize! * 3,
          color: type == "gold" ? ColorManager.orang : Colors.grey,
        ),
        BlocBuilder<GoldCoinBloc,GoldCoinState>(
         builder:
         (context,state){
           if(state is GoldCoinLoadingState){
             return const  LoadingWidget();
           }else if (state is GoldCoinSucssesState){
             if(state.data.isEmpty ){
               return EmptyWidget(message: StringManager.noDataFoundHere.tr());
             }else{
               return Expanded(
                   child: GridView.builder(
                       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                           crossAxisCount: 3),
                       itemCount: state.data.length,
                       itemBuilder: (context, index) {
                         return Container(
                           padding: EdgeInsets.only(top: ConfigSize.defaultSize!),
                           margin: EdgeInsets.symmetric(
                               vertical: ConfigSize.defaultSize!,
                               horizontal: ConfigSize.defaultSize!),
                           decoration: BoxDecoration(
                               borderRadius:
                               BorderRadius.circular(ConfigSize.defaultSize!),
                               color: Theme.of(context).colorScheme.secondary),
                           child: type == "gold"
                               ? InkWell(
                             onTap: (){

BlocProvider.of<BuyCoinsBloc>(context).add(
    BuyCoins(buyCoinsParameter:BuyCoinsParameter(coinsID: '', paymentMethod: '')));
                             },
                             child:Column(
                               children: [
                                 Image.asset(
                                   AssetsPath.goldCoinIcon,
                                   scale: 4,
                                 ),
                                 Text(
                                   "${state.data[index].coin}",
                                   style: TextStyle(
                                       color: ColorManager.yellow,
                                       fontSize: ConfigSize.defaultSize! * 1.7),
                                 ),
                                 Text("${state.data[index].usd}",
                                     style: Theme.of(context).textTheme.bodyMedium)
                               ],
                             ) ,
                           )
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
                                     fontSize: ConfigSize.defaultSize! * 1.7),
                               ),
                               Text("240 L.E",
                                   style: Theme.of(context).textTheme.bodyMedium)
                             ],
                           ),
                         );
                       })) ;
             }
           }else if (state is GoldCoinErrorState){
             return CustomErrorWidget(message: state.error);
           }else{
             return const SizedBox();
           }
         })

      ],
    );
  }
}
