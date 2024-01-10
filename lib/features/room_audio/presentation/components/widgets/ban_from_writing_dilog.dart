
import 'package:flutter/material.dart';


class BanFromWritingDilog extends StatelessWidget {
  final String headerText;
  final String greenText;
  final VoidCallback accpetText;

  const BanFromWritingDilog({Key? key,
    required this.headerText,
    required this.greenText,
    required this.accpetText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      child: Container(
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xffEFFFDB),
              Color(0xffFFF1CC),
            ]
          ),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            SizedBox(height: 20,),
            Text(headerText,style: TextStyle(
              color: Colors.black
            ),),
            const Spacer(),
            Divider(
              color: Colors.black.withOpacity(0.12),
            ),
            SizedBox(height: 15,),
            InkWell(
              onTap: ()=>accpetText(),
              child: Container(
                width: MediaQuery.of(context).size.width,
                alignment: Alignment.center,
                child:  Text(greenText,style: Theme.of(context).textTheme.bodyMedium!.copyWith(color:const Color(0xff008751) ),),

              ),
            ),
            SizedBox(height: 15),

          ],
        ),
      ),
    );
  }
}
