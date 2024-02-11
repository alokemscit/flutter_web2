import 'package:flutter/material.dart';
import 'package:web_2/component/settings/functions.dart';

// ignore: non_constant_identifier_names
CustomGroupContainer(String caption, List<Widget> children) => Builder(
  builder: (context) {
    return Container(
      
        //decoration:customBoxDecoration.copyWith(color: kWebBackgroundDeepColor),
        decoration: CustomCaptionDecoration(),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomCaptionForContainer(caption),
              const SizedBox(
                height: 8,
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children:children))
            ]));
  }
);