import 'package:flutter/material.dart';

 

import '../component/settings/functions.dart';
import '../component/widget/custom_button.dart';
import '../component/widget/doctor_panel.dart';
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
