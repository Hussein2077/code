

import 'package:flutter/material.dart';

import 'widget/lower/lower_body.dart';
import 'widget/profile_bottom_bar.dart';
import 'widget/upper/upper_body.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(children:const [
  UpperProfileBody(),
  LowerProfileBody(),
ProfileBottomBar()

      ],),
    );
  }
}