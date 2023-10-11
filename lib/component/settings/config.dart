import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

const Color backgroundColor = Color.fromARGB(255, 245, 250, 252);

const kPrimaryColor = Color(0xFF366CF6);
const kSecondaryColor = Color(0xFFF5F6FC);
const kBgLightColor = Color(0xFFF2F4FC);
const kBgDarkColor = Color(0xFFEBEDFA);
const kBadgeColor = Color(0xFFEE376E);
const kGrayColor = Color(0xFF8793B2);
const kTitleTextColor = Color(0xFF30384D);
const kTextColor = Color(0xFF4D5875);

const kDefaultPadding = 20.0;

List<BoxShadow> myboxShadow = [
  const BoxShadow(
    color: Color.fromARGB(255, 230, 229, 229),
    offset: Offset(2, 2),
    blurRadius: 2,
    spreadRadius: 1,
  ),
  const BoxShadow(
    color: Color.fromARGB(31, 255, 255, 255),
    offset: Offset(-10, -10),
    blurRadius: 2,
    spreadRadius: 1,
  ),
];


class CustomScrollBehavior extends MaterialScrollBehavior {
  @override
  Set<PointerDeviceKind> get dragDevices => {
        PointerDeviceKind.touch,
        PointerDeviceKind.mouse,
      };
}