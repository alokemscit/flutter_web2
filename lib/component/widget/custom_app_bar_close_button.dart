
import 'package:flutter/material.dart';

import '../settings/config.dart';

class CustomAppBarCloseButton extends StatelessWidget {
  const CustomAppBarCloseButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        InkWell(
          onTap: () {
    Navigator.pop(context);
              },
              borderRadius: BorderRadius.circular(50),
          child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                  color: kPrimaryColor.withOpacity(0.03),
                  borderRadius: BorderRadiusDirectional.circular(50)),
              child: const Icon(
                Icons.close,
                color: Colors.grey,
                size: 20,
              )),
        ),
      ],
    );
  }
}
