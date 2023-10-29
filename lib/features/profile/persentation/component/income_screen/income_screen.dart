import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/resource_manger/asset_path.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/core/widgets/custoum_error_widget.dart';
import 'package:tik_chat_v2/core/widgets/header_with_only_title.dart';
import 'package:tik_chat_v2/core/widgets/mian_button.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/income_screen/widget/card_diamonds_earned.dart';
import 'package:tik_chat_v2/features/profile/persentation/component/income_screen/widget/linear_gradient_contaner.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_my_data_manager/get_my_data_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/get_my_data_manager/get_my_data_state.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_my_store/my_store_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_my_store/my_store_event.dart';

class IncomeScreen extends StatefulWidget {
  const IncomeScreen({super.key});

  @override
  State<IncomeScreen> createState() => _IncomeScreenState();
}

class _IncomeScreenState extends State<IncomeScreen> {
  @override
  void initState() {
    BlocProvider.of<MyStoreBloc>(context).add(GetMyStoreEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: BlocBuilder<GetMyDataBloc, GetMyDataState>(
          builder: (context, state) {
            if (state is GetMyDataSucssesState) {
              return Column(
                children: [
                  SizedBox(height: ConfigSize.defaultSize! / 0.2),
                  HeaderWithOnlyTitle(title: StringManager.income.tr()),
                  SizedBox(height: ConfigSize.defaultSize! / 0.4),
                 const CardOfDiamondEarned(
                  assetCard: AssetsPath.moneyBag,
                ),
                SizedBox(height: ConfigSize.defaultSize! / 0.4),
                LinearGradientContainer(
                  onPress: () {
                    Navigator.pushNamed(context, Routes.liveReportScreen , arguments: state.myDataModel);
                  },
                  title: StringManager.liveReport.tr(),
                ),
                const Spacer(
                  flex: 4,
                ),
                if (state.myDataModel.myAgencyModel!.name=="")
                MainButton(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.instructionsScreen);
                  },
                  title: StringManager.joinRequests.tr(),
                ),
                SizedBox(height: ConfigSize.defaultSize! / 0.4),
                  if ((state.myDataModel.myAgencyModel!.name!="")&&(state.myDataModel.myType ==1))
                MainButton(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.cashWithdrawal);
                  },
                  title: StringManager.withdrawal.tr(),
                ),
                SizedBox(height: ConfigSize.defaultSize! / 0.4),
                  if (state.myDataModel.myAgencyModel!.name=="")
                MainButton(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.exchangeForGoldScreen);
                  },
                  title: StringManager.exchangeDaimond.tr(),
                ),
                const Spacer()
              ],
            );
            }else {
              return const CustomErrorWidget(message: StringManager.unexcepectedError);
            }

          },
        ));
  }
}
