import 'package:flutter/material.dart';

import 'package:web_2/for_test.dart';

import '../component/settings/functions.dart';
import '../data/static_data.dart';

class Test5 extends StatelessWidget {
  const Test5({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomButton(
            text: "Show",
            onPressed: () {
              DoctorDialog(context, tmp_app_data[0]);
              //  showDataAlert(context);
            }),
      ),
    );
  }
}
