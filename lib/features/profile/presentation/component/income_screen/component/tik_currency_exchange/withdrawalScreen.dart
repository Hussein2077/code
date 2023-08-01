import 'package:flutter/material.dart';
import 'package:tik_chat_v2/core/resource_manger/color_manager.dart';
import 'package:tik_chat_v2/core/resource_manger/routs_manger.dart';
import 'package:tik_chat_v2/core/resource_manger/string_manager.dart';
import 'package:tik_chat_v2/core/utils/config_size.dart';
import 'package:tik_chat_v2/features/profile/presentation/component/income_screen/component/Instructions_agency_screen/component/request_agency_screen/widget/text_form_fild.dart';
import 'package:tik_chat_v2/features/profile/presentation/component/income_screen/component/tik_currency_exchange/widget/container_of_cash_withdrawal.dart';


class CashWithdrawal extends StatelessWidget {
  CashWithdrawal({Key? key}) : super(key: key);

  final TextEditingController userID = TextEditingController();
  final TextEditingController withdrawalAmount = TextEditingController();
  final formGlobalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: EdgeInsets.only(
                top: ConfigSize.defaultSize!*4.5,
                right:  ConfigSize.defaultSize!*1.5,
                left:  ConfigSize.defaultSize!*1.5
            ),
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

                      Text(StringManager.cashWithdrawal,
                          style:Theme.of(context).textTheme.bodyMedium,),

                      InkWell(
                        onTap: () {


                          Navigator.pushNamed(context, Routes.detailsWithdrawal);
                        },
                        child:Text(StringManager.details,
                          style:Theme.of(context).textTheme.bodyLarge,),
                      ),
                    ],
                  ),
                  SizedBox(
                    height:  ConfigSize.defaultSize!*2.0,
                  ),
                  const ContainerWithdrawal(
                    coins:'300',
                    diamond: '500',
                  ),
                  SizedBox(
                    height: ConfigSize.defaultSize!*2.0,
                  ),
                  Text(  StringManager.userID,
                    style:Theme.of(context).textTheme.bodyMedium,),


                  SizedBox(
                    height:  ConfigSize.defaultSize!*1.0,
                  ),

                  TextFormFieldWidget(
                    textEditingController: userID,
                    hintText: StringManager.enterUserID,
                    validator: (text){
                      if (text!.isEmpty) {
                        return StringManager.cantBeEmpty;
                      }
                      return null;
                    },
                    readOnly: false,
                  ),
                  SizedBox(
                    height:  ConfigSize.defaultSize!*2.0,
                  ),
                  Text(StringManager.withdrawal,
                    style:Theme.of(context).textTheme.bodyMedium,),

                  SizedBox(
                    height:  ConfigSize.defaultSize!*1.0,
                  ),
                  TextFormFieldWidget(
                    textEditingController: withdrawalAmount,
                    validator: (text) {
                      if (text!.isEmpty) {
                        return StringManager.cantBeEmpty;
                      }
                      return null;
                    },
                    hintText: StringManager.enterQuantityHere,
                    readOnly: false,
                  ),
                  const Spacer(
                    flex: 6,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (formGlobalKey.currentState!.validate()) {
                        formGlobalKey.currentState!.save();
                       /* BlocProvider.of<ChargeToBloc>(context)
                            .add(SendCharge(
                            uId: userID.text,
                            usd: withdrawalAmount.text));*/
                      }

                      //showToastWidget(ToastWidget().errorToast('Cant be Empty'));
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular( ConfigSize.defaultSize!*1.2)),
                        backgroundColor: ColorManager.mainColor,
                        fixedSize:
                        Size(MediaQuery.of(context).size.width,  ConfigSize.defaultSize!*6.0)),
                    child: Text(  StringManager.withdrawal,
                      style:Theme.of(context).textTheme.bodyLarge,),
                  ),
                  const Spacer(),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
