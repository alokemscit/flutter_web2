
import 'package:flutter/material.dart';
import 'package:web_2/component/widget/vitalsign.dart';

class VitalSignGroup extends StatelessWidget {
  const VitalSignGroup({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CapWithTextFields(
          caption: 'Heaght(CM)',
          controller: TextEditingController(),
        ),
        CapWithTextFields(
          caption: 'Heaght(CM)',
          controller: TextEditingController(),
        ),
        CapWithTextFields(
          caption: 'Heaght(CM)',
          controller: TextEditingController(),
        ),
        CapWithTextFields(
          caption: 'Heaght(CM)',
          controller: TextEditingController(),
        ),
        CapWithTextFields(
          caption: 'Heaght(CM)',
          controller: TextEditingController(),
        ),
        CapWithTextFields(
          caption: 'Heaght(CM)',
          controller: TextEditingController(),
        ),
        CapWithTextFields(
          caption: 'Heaght(CM)',
          controller: TextEditingController(),
        ),
        CapWithTextFields(
          caption: 'Heaght(CM)',
          controller: TextEditingController(),
        ),
      ],
    );
  }
}
