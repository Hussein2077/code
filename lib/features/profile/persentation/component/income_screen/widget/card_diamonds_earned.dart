import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_my_store/my_store_bloc.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_my_store/my_store_event.dart';
import 'package:tik_chat_v2/features/profile/persentation/manager/manager_my_store/my_store_state.dart';

// ignore: must_be_immutable
class CardOfDiamondEarned extends StatefulWidget {
  final String assetCard;
   CardOfDiamondEarned({super.key, required this.assetCard});

  @override
  State<CardOfDiamondEarned> createState() => _CardOfDiamondEarnedState();
}

class _CardOfDiamondEarnedState extends State<CardOfDiamondEarned> {
  void initState() {
    BlocProvider.of<MyStoreBloc>(context).add(GetMyStoreEvent());
    super.initState();
  }
   String diamond = "" ;

  @override
  Widget build(BuildContext context) {

    return Container(
      width: MediaQuery.of(context).size.width - 30,
      height: ConfigSize.defaultSize! * 15,
      padding: EdgeInsets.symmetric(
        horizontal: ConfigSize.defaultSize! * 2.5,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(ConfigSize.defaultSize! * 1.8),
        gradient: const LinearGradient(colors: ColorManager.mainColorList),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(widget.assetCard, scale: 3),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                StringManager.diamondsEarned.tr(),
                style: TextStyle(
                    color: Colors.white,
                    fontSize: ConfigSize.defaultSize! * 1.8,
                    fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  BlocBuilder<MyStoreBloc, MyStoreState>(
                    builder: (context, state) {
                   if (state is MyStoreSucssesState){
                    diamond = state.myStore.diamonds.toString();
                       return Text(
                      state.myStore.diamonds.toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: ConfigSize.defaultSize! * 1.8,
                            fontWeight: FontWeight.bold),
                      );
                   }else {
                    return  Text(
                       diamond,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: ConfigSize.defaultSize! * 1.8,
                            fontWeight: FontWeight.bold),
                      );
                   }
                    },
                  ),
                  SizedBox(width: ConfigSize.defaultSize! * 0.5),
                  const Icon(Icons.diamond, color: Colors.blue),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
